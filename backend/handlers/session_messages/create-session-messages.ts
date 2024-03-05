import { Handler } from "aws-lambda";
import { DynamoDBClient, PutItemCommand } from '@aws-sdk/client-dynamodb';
import { SESSIONS_MESSAGES_TABLE_NAME } from "../../data/constants";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { sessionId, messageList = {} } = body;
  
  try {
    const params = {
      TableName: SESSIONS_MESSAGES_TABLE_NAME,
      Item: {
        sessionId: { S: sessionId },
        messageList: { L: messageList },
      },
      ConditionExpression: 'attribute_not_exists(sessionId)',
    };
    const result = await ddbClient.send(new PutItemCommand(params));
    return {
      statusCode: 200,
      body: JSON.stringify({
        sessionId,
        messageList,
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
