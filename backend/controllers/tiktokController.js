import { searchVideos } from "../services/tiktokService.js";

const getSearchVideos = async (req, res) => {
  const { query } = req.query;
  try {
    const videos = await searchVideos(query || "makananviralbandung");
    res.status(200).json(videos);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

export { getSearchVideos };
