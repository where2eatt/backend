import { Handler } from "aws-lambda";
import { DynamoDBClient, PutItemCommand } from '@aws-sdk/client-dynamodb';
import { MESSAGES_TABLE_NAME } from "../../data/constants";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { sessionId, username, message} = body;

  try {
    const params = {
      TableName: MESSAGES_TABLE_NAME,
      Item: {
        sessionId: {S: sessionId},
        username: {S: username},
        message: {S: message},
        timestamp: {N: Date.now().toString()}
      },
    };
    const result = await ddbClient.send(new PutItemCommand(params));;
    return {
      statusCode: 200,
      body: JSON.stringify(result),
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
