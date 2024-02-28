import { Handler } from "aws-lambda";
import { DynamoDBClient, UpdateItemCommand } from '@aws-sdk/client-dynamodb';
import { SESSIONS_TABLE_NAME } from '../../data/constants';
import { unmarshall } from "@aws-sdk/util-dynamodb";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { sessionId, username, preferences } = body;
  // TODO: validate that user exists

  try {
    const params = {
      TableName: SESSIONS_TABLE_NAME,
      Key: {
        sessionId: { S: sessionId },
      },
      UpdateExpression: `SET preferencesFor_${username} = :preferences`,
      ExpressionAttributeValues: {
        ':preferences': { S: JSON.stringify(preferences) },
      },
      ReturnValues: 'ALL_NEW' as const,
      ConditionExpression: 'attribute_exists(sessionId)',
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
