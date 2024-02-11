import { Handler } from "aws-lambda";
import {
  DynamoDBClient,
  GetItemCommand,
  GetItemCommandInput,
} from '@aws-sdk/client-dynamodb';

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const { sessionId } = event.queryStringParameters;

  try {
    const params: GetItemCommandInput = {
      TableName: 'Sessions',
      Key: sessionId,
    };
    const result = await ddbClient.send(new GetItemCommand(params));;

    // use session data to find recommendations


    if (result) {
      return {
        statusCode: 200,
        body: JSON.stringify(result),
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      };
    }
    return {
      statusCode: 404,
      body: JSON.stringify({
        message: 'user does not exist',
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
