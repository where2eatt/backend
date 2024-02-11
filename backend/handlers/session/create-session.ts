import { Handler } from 'aws-lambda';
import { DynamoDBClient, PutItemCommand } from '@aws-sdk/client-dynamodb';

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { username } = body;

  const sessionId = `${username}_${Date.now().toString(36)}`;

  try {
    const params = {
      TableName: 'Sessions',
      Item: {
        sessionId: { S: sessionId },
        sessionHostUsername: { S: username },
      },
    };
    const result = await ddbClient.send(new PutItemCommand(params));
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
