import { Handler } from "aws-lambda";
import { DynamoDBClient, PutItemCommand } from '@aws-sdk/client-dynamodb';
import { USERS_TABLE_NAME } from "../../data/constants";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { username, bio = undefined, preferences = {} } = body;
  // const userId = event.requestContext.authorizer.principalId;

  try {
    const params = {
      TableName: USERS_TABLE_NAME,
      Item: {
        username: { S: username },
        preferences: { S: JSON.stringify(preferences) },
      },
      ConditionExpression: 'attribute_not_exists(username)',
      ReturnValues: 'ALL_OLD' as const,
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
