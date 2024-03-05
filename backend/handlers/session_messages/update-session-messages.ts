import { Handler } from "aws-lambda";
import { DynamoDBClient, UpdateItemCommand } from '@aws-sdk/client-dynamodb';
import { SESSIONS_MESSAGES_TABLE_NAME } from "../../data/constants";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { sessionId, messageId} = body;

  try {
    const params = {
      TableName: SESSIONS_MESSAGES_TABLE_NAME,
      Key: {
        sessionId: { S: sessionId },
      },
      UpdateExpression: 'SET messageList = list_append(messageList, :messageId)',
      ExpressionAttributeValues: {
        ':messageId': [messageId],
      },
      ReturnValues: 'ALL_NEW' as const,
      ConditionExpression: 'attribute_exists(sessionId)',
    };
    const result = await ddbClient.send(new UpdateItemCommand(params));
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
