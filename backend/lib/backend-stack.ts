import { RemovalPolicy, Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { LambdaConstruct } from './construct/lambda-construct';
import { ApiGatewayConstruct } from './construct/apigateway-construct';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';
import { AuthorizationType, IAuthorizer, IRestApi, JsonSchema, JsonSchemaType, LambdaIntegration, MethodOptions, Model } from 'aws-cdk-lib/aws-apigateway';
import { SESSIONS_TABLE_NAME, USERS_TABLE_NAME, SESSIONS_MESSAGES_TABLE_NAME} from '../data/constants';

export class BackendStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    const usersTable = new dynamodb.Table(this, 'UsersTable', {
      tableName: USERS_TABLE_NAME,
      partitionKey: {
        name: 'username',
        type: dynamodb.AttributeType.STRING,
      },
      removalPolicy: RemovalPolicy.DESTROY,
    });

    /**
     * a session includes number of people, location, time.
     * For each user, there is cuisine preference, dietary restrictions, price range
     */
    const sessionsTable = new dynamodb.Table(this, 'SessionsTable', {
      tableName: SESSIONS_TABLE_NAME,
      partitionKey: {
        name: 'sessionId',
        type: dynamodb.AttributeType.STRING,
      },
      removalPolicy: RemovalPolicy.DESTROY,
    });

    const sessionMessagesTable = new dynamodb.Table(this, 'SessionsMessagesTable', {
      tableName: SESSIONS_MESSAGES_TABLE_NAME,
      partitionKey: {
        name: 'sessionId',
        type: dynamodb.AttributeType.STRING,
      },
      removalPolicy: RemovalPolicy.DESTROY,
    });

    const lambda = new LambdaConstruct(this, 'lambda');

    usersTable.grantWriteData(lambda.createUser);
    usersTable.grantReadData(lambda.getUser);
    usersTable.grantWriteData(lambda.updateUser);

    sessionsTable.grantWriteData(lambda.createSession);
    sessionsTable.grantReadData(lambda.getSession);
    sessionsTable.grantWriteData(lambda.updateSession);

    sessionsTable.grantReadData(lambda.generateSessionRecs);

    sessionMessagesTable.grantWriteData(lambda.createSession);
    sessionMessagesTable.grantReadData(lambda.getSessionMessages);
    sessionMessagesTable.grantWriteData(lambda.updateSessionMessages);

    const apiGateway = new ApiGatewayConstruct(this, 'api gateway');

    const user = apiGateway.api.root.addResource('user');
    const session = apiGateway.api.root.addResource('session');
    const recommendation = apiGateway.api.root.addResource('recommendation');

    const sessionMessage = apiGateway.api.root.addResource('session-message');

    user.addMethod(
      'POST',
      new LambdaIntegration(lambda.createUser),
      this.jsonBodyValidationOptions(
      {
        api: apiGateway.api,
        name: 'create-user-model',
        schema: {
          username: JsonSchemaType.STRING,
          bio: JsonSchemaType.STRING,
          preferences: JsonSchemaType.OBJECT,
        },
        required: ['username'],
      })
    );
    user.addMethod(
      'GET',
      new LambdaIntegration(lambda.getUser),
      this.queryParamValidationOptions({
        username: true,
      })
    );
    user.addMethod(
      'PATCH',
      new LambdaIntegration(lambda.updateUser),
      this.jsonBodyValidationOptions({
        api: apiGateway.api,
        name: 'update-user-model',
        schema: {
          username: JsonSchemaType.STRING,
          bio: JsonSchemaType.STRING,
          preferences: JsonSchemaType.OBJECT,
        },
        required: [],
      })
    );

    session.addMethod(
      'POST',
      new LambdaIntegration(lambda.createSession),
      this.jsonBodyValidationOptions({
        api: apiGateway.api,
        name: 'create-session-model',
        schema: {
          username: JsonSchemaType.STRING,
        },
        required: ['username', 'location'],
      })
    );
    session.addMethod(
      'GET',
      new LambdaIntegration(lambda.getSession),
      this.queryParamValidationOptions({
        sessionId: true,
      })
    );
    session.addMethod(
      'PATCH',
      new LambdaIntegration(lambda.updateSession),
      this.jsonBodyValidationOptions({
        api: apiGateway.api,
        name: 'update-session-model',
        schema: {
          sessionId: JsonSchemaType.STRING,
          sessionHostUsername: JsonSchemaType.STRING,
        },
        required: ['sessionId', 'username', 'preferences'],
      })
    );

    recommendation.addMethod(
      'GET',
      new LambdaIntegration(lambda.generateSessionRecs),
      this.queryParamValidationOptions({
        sessionId: true,
      })
    );

    /*sessionMessage.addMethod(
      'POST',
      new LambdaIntegration(lambda.createSessionMessages),
      this.jsonBodyValidationOptions({
        api: apiGateway.api,
        name: 'create-session-message-model',
        schema: {
          sessionId: JsonSchemaType.STRING,
          messageList: JsonSchemaType.ARRAY,
        },
        required: ['sessionId', 'messageList'],
      })
    ); */
    sessionMessage.addMethod(
      'GET',
      new LambdaIntegration(lambda.getSessionMessages),
      this.queryParamValidationOptions({
        messageId: true,
      })
    );
    sessionMessage.addMethod(
      'PATCH',
      new LambdaIntegration(lambda.updateSessionMessages),
      this.jsonBodyValidationOptions({
        api: apiGateway.api,
        name: 'update-session-message-model',
        schema: {
          sessionId: JsonSchemaType.STRING,
          username: JsonSchemaType.STRING,
          timestamp: JsonSchemaType.STRING,
          message: JsonSchemaType.STRING
        },
        required: ['sessionId', 'username', 'timestamp', 'message'],
      })
    );
  }

    private jsonBodyValidationOptions = (options: JsonBodyValidationOptions, authorizer?: IAuthorizer): MethodOptions => {
    const schema = Object.keys(options.schema).reduce((result: { [property: string]: JsonSchema }, key: string) => {
      result[key] = { type: options.schema[key] };
      return result;
    }, {});
    return {
      requestValidatorOptions: {
        validateRequestBody: true,
      },
      requestModels: {
        'application/json': new Model(this, options.name, {
          restApi: options.api,
          schema: {
            type: JsonSchemaType.OBJECT,
            required: options.required.length === 0 ? undefined : options.required,
            properties: schema,
          },
        }),
      },
      authorizer,
      authorizationType: authorizer ? AuthorizationType.CUSTOM : AuthorizationType.NONE,
    };
  }

  private queryParamValidationOptions = (options: QueryParamValidationOptions, authorizer?: IAuthorizer): MethodOptions => {
    let params = Object.keys(options).reduce((result: { [param: string]: boolean }, key: string) => {
      result[`method.request.querystring.${key}`] = options[key];
      return result;
    }, {});
    return {
      requestValidatorOptions: {
        validateRequestParameters: true,
      },
      requestParameters: params,
      authorizer,
      authorizationType: authorizer ? AuthorizationType.CUSTOM : AuthorizationType.NONE,
    };
  }
}

interface JsonBodyValidationOptions {
  api: IRestApi;
  name: string;
  schema: { [property: string]: JsonSchemaType };
  required: string[];
}

interface QueryParamValidationOptions {
  [param: string]: boolean;
}
