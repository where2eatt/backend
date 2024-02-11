import { Duration } from 'aws-cdk-lib';
import { IFunction, Runtime } from 'aws-cdk-lib/aws-lambda';
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs';
import { Construct } from 'constructs';

export class LambdaConstruct extends Construct {
 readonly createUser: IFunction;
 readonly updateUser: IFunction;
 readonly getUser: IFunction;

 constructor(scope: Construct, id: string) {
  super(scope, id);

  this.createUser = new NodejsFunction(this, 'createUser', {
    functionName: 'CreateUser',
    entry: './handlers/user/create-user.ts',
    memorySize: 256,
    runtime: Runtime.NODEJS_20_X,
    timeout: Duration.seconds(15),
    depsLockFilePath: './package-lock.json',
  });

  this.getUser = new NodejsFunction(this, 'getUser', {
    functionName: 'GetUser',
    entry: './handlers/user/get-user.ts',
    memorySize: 256,
    runtime: Runtime.NODEJS_20_X,
    timeout: Duration.seconds(15),
    depsLockFilePath: './package-lock.json',
  });

  this.updateUser = new NodejsFunction(this, 'updateUser', {
    functionName: 'UpdateUser',
    entry: './handlers/user/update-user.ts',
    memorySize: 256,
    runtime: Runtime.NODEJS_20_X,
    timeout: Duration.seconds(15),
    depsLockFilePath: './package-lock.json',
  });
 }
}
