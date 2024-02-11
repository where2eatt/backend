import { Handler } from 'aws-lambda';
import { v4 } from 'uuid';
import { DynamoDBClient, PutItemCommand } from '@aws-sdk/client-dynamodb';
import { SESSIONS_TABLE_NAME } from '../../data/constants';

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { username } = body;

  const sessionId = `${Date.now()}_${v4()}`;

  try {
    const params = {
      TableName: SESSIONS_TABLE_NAME,
      Item: {
        sessionId: { S: sessionId },
        sessionHostUsername: { S: username },
      },
      ReturnValues: 'ALL_OLD' as const,
    };
    const result = (await ddbClient.send(new PutItemCommand(params))).Attributes;
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
