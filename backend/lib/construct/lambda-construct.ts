import { Duration } from 'aws-cdk-lib';
import { IFunction, Runtime } from 'aws-cdk-lib/aws-lambda';
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs';
import { Construct } from 'constructs';

export interface LambdaConstructProps {
  dbUrl: string;
  apiUrl: string;
}

export class LambdaConstruct extends Construct {
 readonly testLambda: IFunction;

 constructor(scope: Construct, id: string, props: LambdaConstructProps) {
  super(scope, id);

  this.testLambda = new NodejsFunction(this, 'testLambda', {
    functionName: 'TestLambda',
    entry: './handlers/testLambda.ts',
    memorySize: 256,
    runtime: Runtime.NODEJS_20_X,
    timeout: Duration.seconds(15),
    depsLockFilePath: './package-lock.json',
  });
 }
}
