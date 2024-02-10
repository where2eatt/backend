import { Handler } from 'aws-lambda';
import { DynamoDBClient, PutItemCommand } from '@aws-sdk/client-dynamodb';

const dbclient = new DynamoDBClient({ region: 'us-west-2' });

export const handler: Handler = async (event, context) => {
  const { data } = event;

  const params = {
    TableName: 'YourTableName',
    Item: data,
  };

  try {
    const data = await dbclient.send(new PutItemCommand(params));

    return {
      statusCode: 200,
      body: JSON.stringify({ message: 'Entry created successfully' }),
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ message: 'Failed to create entry' }),
      headers: {
        'Access-Control-Allow-Origin': '*',
      },
    };
  }
};
