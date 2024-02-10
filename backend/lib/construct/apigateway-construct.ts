import { Cors, IRestApi, ResponseType, RestApi } from 'aws-cdk-lib/aws-apigateway';
import { Construct } from 'constructs';

export class ApiGatewayConstruct extends Construct {

  readonly api: IRestApi;
  readonly url: string;

  constructor(scope: Construct, id: string) {
    super(scope, id);

    const api: RestApi = new RestApi(this, 'API', {
      defaultCorsPreflightOptions: {
        allowOrigins: Cors.ALL_ORIGINS,
        allowMethods: Cors.ALL_METHODS,
      },
    });
    
    this.addGatewayResponse(api, ResponseType.ACCESS_DENIED);
    this.addGatewayResponse(api, ResponseType.AUTHORIZER_FAILURE);
    this.addGatewayResponse(api, ResponseType.UNAUTHORIZED);
    this.addGatewayResponse(api, ResponseType.MISSING_AUTHENTICATION_TOKEN);
    this.addGatewayResponse(api, ResponseType.EXPIRED_TOKEN);

    this.addGatewayResponse(api, ResponseType.BAD_REQUEST_BODY);
    this.addGatewayResponse(api, ResponseType.BAD_REQUEST_PARAMETERS);

    this.addGatewayResponse(api, ResponseType.RESOURCE_NOT_FOUND);

    this.addGatewayResponse(api, ResponseType.DEFAULT_4XX);
    this.addGatewayResponse(api, ResponseType.DEFAULT_5XX);

    this.api = api;
    this.url = api.url;
  }

  private addGatewayResponse = (api: RestApi, responseType: ResponseType, statusCode?: string) => {
    api.addGatewayResponse(responseType.responseType, {
      type: responseType,
      statusCode,
      responseHeaders: {
        'Access-Control-Allow-Origin': "'*'",
      },
    });
  }
}
