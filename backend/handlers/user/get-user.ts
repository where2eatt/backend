import { Handler } from "aws-lambda";
import {
  DynamoDBClient,
  GetItemCommand,
  GetItemCommandInput,
} from '@aws-sdk/client-dynamodb';

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const { username } = event.queryStringParameters;
  console.log('username', username)

  try {
    const params: GetItemCommandInput = {
      TableName: 'Users',
      Key: username,
    };
    const result = await ddbClient.send(new GetItemCommand(params));;
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
