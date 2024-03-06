import { Handler } from "aws-lambda";
import {
  DynamoDBClient,
  GetItemCommand,
  GetItemCommandInput,
} from '@aws-sdk/client-dynamodb';
import { MESSAGES_TABLE_NAME } from "../../data/constants";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { messageId } = body;

  try {
    const params: GetItemCommandInput = {
      TableName: MESSAGES_TABLE_NAME,
      Key: { messageId: { S: messageId} },
    };
    const messageResult = (await ddbClient.send(new GetItemCommand(params))).Item;
    if (messageResult) {
      return {
        statusCode: 200,
        body: JSON.stringify(messageResult),
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      };
    }
    return {
      statusCode: 404,
      body: JSON.stringify({
        message: 'message does not exist',
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
