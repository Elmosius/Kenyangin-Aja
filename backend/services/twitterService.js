import twitterApi from "../config/twitter.js";

const searchTweets = async (query) => {
  try {
    const response = await twitterApi.get("tweets/search/recent", {
      params: {
        query,
        max_results: 3,
        "tweet.fields": "public_metrics,text,author_id,created_at",
      },
    });

    return response.data;
  } catch (error) {
    console.error("Error fetching tweets:", error.message);
    throw new Error("Failed to fetch tweets");
  }
};

export { searchTweets };
