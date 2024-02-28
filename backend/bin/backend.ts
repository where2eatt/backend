#!/usr/bin/env node
import 'source-map-support/register';
import * as dotenv from 'dotenv';
import { App } from 'aws-cdk-lib';
import { BackendStack } from '../lib/backend-stack';

const app = new App();
dotenv.config();

new BackendStack(app, 'BackendStack', {
});