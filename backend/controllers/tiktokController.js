import { searchVideos } from "../services/tiktokService.js";

const getSearchVideos = async (req, res) => {
  const { query } = req.query;

  try {
    const videos = await searchVideos(query || "kulinerbandung");
    res.status(200).json({ message: "Vidio fetched and saved successfully", data: videos });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

export { getSearchVideos };
