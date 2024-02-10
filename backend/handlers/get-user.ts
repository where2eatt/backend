import { Handler } from "aws-lambda";


export const handler: Handler = async (event, context) => {
  const { userId } = event.queryStringParameters;

  try {
    const result = {};
    if (result) {
      return {
        statusCode: 200,
        body: JSON.stringify(result),
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      };
    }
    return {
      statusCode: 404,
      body: JSON.stringify({
        message: 'user does not exist',
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
