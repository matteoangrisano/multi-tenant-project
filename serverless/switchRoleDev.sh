#!/bin/bash

CREDS=$(aws sts assume-role --role-arn arn:aws:iam::ACCOUNT-ID:role/ROLE --role-session-name my-sls-session --out json)

echo CRED: $CREDS
export AWS_ACCESS_KEY_ID=$(echo $CREDS | jq -r '.Credentials.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(echo $CREDS | jq -r '.Credentials.SecretAccessKey')
export AWS_SESSION_TOKEN=$(echo $CREDS | jq -r '.Credentials.SessionToken')

echo $@
$@