import { Handler } from "aws-lambda";
import { DynamoDBClient, UpdateItemCommand } from '@aws-sdk/client-dynamodb';

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { username, preferences = {} } = body;

  try {
    const params = {
      TableName: 'Users',
      Key: {
        username: { S: username },
      },
      UpdateExpression: 'SET preferences = :preferences',
      ExpressionAttributeValues: {
        ':preferences': { S: JSON.stringify(preferences) },
      },
      ReturnValues: 'ALL_NEW' as const,
      ConditionExpression: 'attribute_exists(username)',
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
