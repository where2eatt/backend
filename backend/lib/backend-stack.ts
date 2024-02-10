import { RemovalPolicy, Stack, StackProps } from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { LambdaConstruct } from './construct/lambda-construct';
import { ApiGatewayConstruct } from './construct/apigateway-construct';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';
import { AuthorizationType, IAuthorizer, IRestApi, JsonSchema, JsonSchemaType, LambdaIntegration, MethodOptions, Model } from 'aws-cdk-lib/aws-apigateway';

export class BackendStack extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);

    const usersTable = new dynamodb.Table(this, 'UsersTable', {
      tableName: 'Users',
      partitionKey: {
        name: 'userId',
        type: dynamodb.AttributeType.STRING,
      },
      removalPolicy: RemovalPolicy.DESTROY,
    });

    const apiGateway = new ApiGatewayConstruct(this, 'api gateway');

    const lambda = new LambdaConstruct(this, 'lambda');

    const user = apiGateway.api.root.addResource('user');
    user.addMethod(
      'POST',
      new LambdaIntegration(lambda.createUser),
      this.jsonBodyValidationOptions(
      {
        api: apiGateway.api,
        name: 'create-user-model',
        schema: {
        username: JsonSchemaType.STRING,
        image: JsonSchemaType.STRING,
        bio: JsonSchemaType.STRING,
        },
        required: ['username'],
      })
    );
    user.addMethod(
      'GET',
      new LambdaIntegration(lambda.getUser),
      this.queryParamValidationOptions({
      userId: true,
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
