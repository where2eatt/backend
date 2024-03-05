import { Duration } from 'aws-cdk-lib';
import { IFunction, Runtime } from 'aws-cdk-lib/aws-lambda';
import { NodejsFunction } from 'aws-cdk-lib/aws-lambda-nodejs';
import { Construct } from 'constructs';

export class LambdaConstruct extends Construct {
  readonly createUser: IFunction;
  readonly updateUser: IFunction;
  readonly getUser: IFunction;
  readonly createSession: IFunction;
  readonly getSession: IFunction;
  readonly updateSession: IFunction;
  readonly generateSessionRecs: IFunction;
  readonly createMessage: IFunction;
  readonly getMessage: IFunction;
  readonly updateMessage: IFunction;
  readonly createSessionMessages: IFunction;
  readonly getSessionMessages: IFunction;
  readonly updateSessionMessages: IFunction;

  constructor(scope: Construct, id: string) {
    super(scope, id);

    this.createUser = this.defaultFunction('CreateUser', './handlers/user/create-user.ts');
    this.getUser = this.defaultFunction('GetUser', './handlers/user/get-user.ts');
    this.updateUser = this.defaultFunction('UpdateUser', './handlers/user/update-user.ts');
  
    this.createSession = this.defaultFunction('CreateSession', './handlers/session/create-session.ts');
    this.getSession = this.defaultFunction('GetSession', './handlers/session/get-session.ts');
    this.updateSession = this.defaultFunction('UpdateSession', './handlers/session/update-session.ts');

    this.createMessage = this.defaultFunction('CreateMessage', './handlers/message/create-message.ts');
    this.getMessage = this.defaultFunction('GetMessage', './handlers/message/get-message.ts');
    this.updateMessage = this.defaultFunction('UpdateMessage', './handlers/message/update-message.ts');

    this.createSessionMessages = this.defaultFunction('CreateSessionMessages', './handlers/session_messages/create-session-messages.ts');
    this.getSessionMessages = this.defaultFunction('GetSessionMessages', './handlers/session_messages/get-session-messages.ts');
    this.updateSessionMessages = this.defaultFunction('UpdateSessionMessages', './handlers/session_messages/update-session-messages.ts');

    if (!process.env.GOOG_API_KEY) {
      throw new Error('Google Places API Key environment variable is not set');
    }

    this.generateSessionRecs = new NodejsFunction(this, 'GenerateSessionRecs', {
      functionName: 'GenerateSessionRecs',
      entry: './handlers/session/generate-session-recs.ts',
      memorySize: 256,
      runtime: Runtime.NODEJS_20_X,
      timeout: Duration.seconds(15),
      depsLockFilePath: './package-lock.json',
      environment: { GOOGLE_PLACES_API_KEY: process.env.GOOG_API_KEY},
    });
  }

  private defaultFunction = (
    funcName: string,
    handlerPath: string,
    environment?: Record<string, string>
  ): IFunction => {
    return new NodejsFunction(this, funcName, {
      functionName: funcName,
      entry: handlerPath,
      memorySize: 256,
      runtime: Runtime.NODEJS_20_X,
      timeout: Duration.seconds(15),
      depsLockFilePath: './package-lock.json',
      environment,
    });
  }
}
