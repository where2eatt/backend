import { Handler } from "aws-lambda";
import {
  DynamoDBClient,
  GetItemCommand,
  GetItemCommandInput,
} from '@aws-sdk/client-dynamodb';
import { unmarshall } from "@aws-sdk/util-dynamodb";
import { Session, UserPreferences } from "../../data/types";
import axios from "axios";
import { RESTAURANT_TYPE_OPTIONS } from "../../data/constants";

const ddbClient = new DynamoDBClient({ region: 'us-west-2' });
export const handler: Handler = async (event, context) => {
  const { sessionId } = event.queryStringParameters;

  try {
    if (!process.env.GOOGLE_PLACES_API_KEY) {
      throw new Error(
        'Google Places API Key environment variable is not set'
      );
    }

    const params: GetItemCommandInput = {
      TableName: 'Sessions',
      Key: { sessionId: { S: sessionId } },
    };
    const sessionResult = (await ddbClient.send(new GetItemCommand(params))).Item;

    if (sessionResult) {
      const session = unmarshall(sessionResult) as Session;

      const { sessionId: _, location, numPeople, date, time, ...rest } = session;

      const userPreferences: UserPreferences[] = Object.entries(rest)
        .filter(([key]) => key.startsWith('preferencesFor'))
        .map(([_, value]) => JSON.parse(String(value)));
      
      const veganRestaurant = userPreferences.some((pref) => {
        return pref.dietaryRestrictions && pref.dietaryRestrictions.includes(
          'vegan'
        );
      });
      const vegatarianRestaurant = userPreferences.some((pref) => {
        return pref.dietaryRestrictions && pref.dietaryRestrictions.includes('vegetarian')
      });
      const primaryType = veganRestaurant
        ? "vegan_restaurant"
        : vegatarianRestaurant
          ? "vegetarian_restaurant"
          : "";

      const restuarantTypes: string[] = userPreferences
        .flatMap((pref) => pref.cuisine);
      
      const locationQuery = encodeURIComponent(location);
      console.log("restuarantTypes", restuarantTypes);

      const requestBody = {
        // includedPrimaryTypes: [primaryType],
        includedTypes: [primaryType, ...restuarantTypes].filter((type) =>
          RESTAURANT_TYPE_OPTIONS.has(type)
        ),
        maxResultCount: 10,
        locationRestriction: {
          circle: {
            center: {
              latitude: 47.6546,
              longitude: -122.3075,
            },
            radius: 2500.0,
          },
        },
      };

      console.log(requestBody);
      const response = await axios.post(
        "https://places.googleapis.com/v1/places:searchNearby",
        requestBody,
        {
          headers: {
            "Content-Type": "application/json",
            "X-Goog-Api-Key": process.env.GOOGLE_PLACES_API_KEY,
            "X-Goog-FieldMask": "places.displayName",
          },
        }
      );

      const restaurants = response.data;
      console.log(restaurants);

      return {
        statusCode: 200,
        body: JSON.stringify(restaurants),
        headers: {
          'Access-Control-Allow-Origin': '*',
        },
      };
    }
    return {
      statusCode: 404,
      body: JSON.stringify({
        message: 'session does not exist',
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
