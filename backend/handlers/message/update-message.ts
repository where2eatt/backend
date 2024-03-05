import { Handler } from "aws-lambda";
import { DynamoDBClient, UpdateItemCommand } from '@aws-sdk/client-dynamodb';
import { MESSAGES_TABLE_NAME } from '../../data/constants';
import { unmarshall } from "@aws-sdk/util-dynamodb";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { messageId, message} = body;

  try {
    const params = {
      TableName: MESSAGES_TABLE_NAME,
      Key: {
        messageId: { S: messageId },
      },
      UpdateExpression: `SET messageFor_${messageId} = :message`,
      ExpressionAttributeValues: {
        ':preferences': { S: JSON.stringify(message) },
      },
      ReturnValues: 'ALL_NEW' as const,
      ConditionExpression: 'attribute_exists(messageId)',
    };
    const result = (await ddbClient.send(new UpdateItemCommand(params))).Attributes;
    return {
      statusCode: 200,
      body: JSON.stringify(unmarshall(result || {})),
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
