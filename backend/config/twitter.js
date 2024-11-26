import axios from "axios";

const twitterApi = axios.create({
  baseURL: "https://api.twitter.com/2/",
  headers: {
    Authorization: `Bearer ${process.env.TWITTER_BEARER_TOKEN}`,
  },
});

export default twitterApi;
