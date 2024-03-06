import { Handler } from 'aws-lambda';
import { v4 } from 'uuid';
import { DynamoDBClient, PutItemCommand } from '@aws-sdk/client-dynamodb';
import { SESSIONS_TABLE_NAME,  SESSIONS_MESSAGES_TABLE_NAME } from '../../data/constants';
import { } from "../../data/constants";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { username, numPeople, date, time, location } = body;
  // TODO: validate that user exists

  const sessionId = `${username}-${new Date().toLocaleDateString('en-US', { month: '2-digit', day: '2-digit', year: '2-digit' }).replace(/\//g, '')}-${Math.random().toString(36).substring(2, 6)}`;

  try {
    const params = {
      TableName: SESSIONS_TABLE_NAME,
      Item: {
        sessionId: { S: sessionId },
        sessionHostUsername: { S: username },
        location: { S: location },
        date: { S: date || "" },
        time: { S: time || ""},
        numPeople: { N: numPeople || "0"},
      },
    };

    try {
      const params = {
        TableName: SESSIONS_MESSAGES_TABLE_NAME,
        Item: {
          sessionId: { S: sessionId },
          messageList: { L: [] },
        },
        ConditionExpression: 'attribute_not_exists(sessionId)',
      };
      const result = await ddbClient.send(new PutItemCommand(params));
    } catch (e) {
      console.error(e);
      return {
        statusCode: 400,
        body: '{}',
        headers: {
          'Access-Control-Allow-Origin, Failed to input into SessionMessage Table': '*',
        },
      };
    }
    const result = (await ddbClient.send(new PutItemCommand(params))).Attributes;
    return {
      statusCode: 200,
      body: JSON.stringify({
        sessionId,
        sessionHostUsername: username,
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
