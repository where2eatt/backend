import { Handler } from "aws-lambda";
import {
  DynamoDBClient,
  GetItemCommand,
  GetItemCommandInput,
} from '@aws-sdk/client-dynamodb';
import { unmarshall } from '@aws-sdk/util-dynamodb';
import { SESSIONS_MESSAGES_TABLE_NAME } from "../../data/constants";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const { sessionId } = event.queryStringParameters;

  try {
    const params: GetItemCommandInput = {
      TableName: SESSIONS_MESSAGES_TABLE_NAME,
      Key: { sessionId: { S: sessionId } },
    };
    const session = (await ddbClient.send(new GetItemCommand(params))).Item;
    if (session) {
      return {
        statusCode: 200,
        body: JSON.stringify(unmarshall(session)),
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      };
    }
    return {
      statusCode: 404,
      body: JSON.stringify({
        message: 'session does not exist',
      }),
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
    };
  } catch (e) {
    console.error(e);
    return {
      statusCode: 400,
      body: '{}',
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
    };
  }
};
