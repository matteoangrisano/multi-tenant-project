#!/usr/bin/env node
import "dotenv";
import { config } from "dotenv";
config({ path: `${__dirname}/../../.env` });

import "source-map-support/register";
import * as cdk from "aws-cdk-lib";
import { InfrastructureStack } from "../lib/infrastructure-stack";
// import { Infrastructure as RadixLibTemplate } from "../../libs/radix-lib-template/infrastructure";

console.log("load with ", process.env.ACCOUNT, process.env.REGION);

const app = new cdk.App();
new InfrastructureStack(
  app,
  `${process.env.PROJECT_NAME}-infrastructure-${process.env.STAGE}`,
  {
    env: { account: process.env.ACCOUNT, region: process.env.REGION },
  }
);

// new RadixLibTemplate(
//   app,
//   `${process.env.PROJECT_NAME}-radix-lib-template-${process.env.STAGE}`,
//   `${process.env.PROJECT_NAME}-first-bucket-${process.env.STAGE}`,
//   `${process.env.PROJECT_NAME}-second-bucket-${process.env.STAGE}`,
//   {
//     env: { account: process.env.ACCOUNT, region: process.env.REGION },
//   }
// );
