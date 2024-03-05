import { Handler } from "aws-lambda";
import { DynamoDBClient, PutItemCommand } from '@aws-sdk/client-dynamodb';
import { MESSAGES_TABLE_NAME } from "../../data/constants";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { messageId, sessionId, username, message} = body;
  
  try {
    const params = {
      TableName: MESSAGES_TABLE_NAME,
      Item: {
        messageId: { S: messageId },
        sessionId: {S: sessionId},
        username: {S: username},
        message: {S: message}
      },
      ConditionExpression: 'attribute_not_exists(messageId)',
      ReturnValues: 'ALL_NEW' as const,
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
