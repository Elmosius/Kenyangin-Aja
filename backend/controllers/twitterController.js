import { searchTweets } from "../services/twitterService.js";

const getTrendingTweets = async (req, res) => {
  const { hashtag, minLikes = 1000, minReplies = 5, minRetweets = 10 } = req.query;

  try {
    const tweets = await searchTweets(`#${hashtag}`);

    const filteredTweets = tweets.data.filter((tweet) => {
      const metrics = tweet.public_metrics;
      return metrics.like_count >= minLikes && metrics.reply_count >= minReplies && metrics.retweet_count >= minRetweets;
    });
    res.status(200).json(filteredTweets);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

export { getTrendingTweets };
