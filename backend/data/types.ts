export type UserPreferences = {
  cuisine: string[];
  dietaryRestrictions: string[];
  minPrice: number;
  maxPrice: number;
};

export type Session = {
  sessionId: string;
  location: string;
  date?: string;
  time?: string;
  numPeople?: number;
} & Record<string, UserPreferences>;
