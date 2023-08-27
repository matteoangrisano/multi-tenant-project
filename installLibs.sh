#!/bin/bash

git submodule update --remote

SERVICES=$(awk '/services: {/,/^  }/{print}' ./serverless/serverless-compose.ts | sed -nE 's/^\s*([^:]+):.*$/\1/p' | sed 's/[", ]//g' | grep -v "services" | grep -v "^path$")

echo "Chiavi trovate:"
echo "$SERVICES"

for SERVICE in $SERVICES; do
  if [ -d "libs/$SERVICE" ]; then
    pushd libs/$SERVICE/serverless
    yarn install
    popd
  else
    echo "Directory per $SERVICE non trovata!"
  fi
done

if [ -d "serverless" ]; then
  pushd serverless
  yarn install
  popd
else
  echo "Directory per serverless non trovata!"
fi

if [ -d "infrastructure" ]; then
  pushd infrastructure
  yarn install
  popd
else
  echo "Directory per infrastructure non trovata!"
fi

for SERVICE in $SERVICES; do
  if [ -d "libs/$SERVICE" ]; then
    pushd libs/$SERVICE/infrastructure
    yarn install
    yarn build
    popd
  else
    echo "Directory per $SERVICE non trovata!"
  fi
done
