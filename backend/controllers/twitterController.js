import { searchTweets } from "../services/twitterService.js";

const getTrendingTweets = async (req, res) => {
  const { hastag } = req.query;
  try {
    const tweets = await searchTweets(hastag);
    res.status(200).json(tweets);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

export { getTrendingTweets };
