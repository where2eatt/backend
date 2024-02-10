import { Handler } from "aws-lambda";

export const handler: Handler = async (event, context) => {
  const body = JSON.parse(event.body);
  const { username, image = undefined, bio = undefined } = body;
  const userId = event.requestContext.authorizer.principalId;

  try {
    const result = {};
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
