import TikTok from "../models/tiktokModel.js";
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

const getAllTikTokVideos = async (req, res) => {
  try {
    const videos = await TikTok.find();
    res.status(200).json({ message: "Fetched all videos", data: videos });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

const getTikTokVideoById = async (req, res) => {
  const { id } = req.params;

  try {
    const video = await TikTok.findOne({ id });
    if (!video) {
      return res.status(404).json({ message: "Video not found" });
    }

    res.status(200).json({ message: "Video fetched successfully", data: video });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

const deleteTikTokVideo = async (req, res) => {
  const { id } = req.params;

  try {
    const isReferenced = await Food.exists({ tiktokRef: id });

    if (isReferenced) {
      return res.status(500).json({
        message: "Cannot delete TikTok. It is still referenced by Food.",
      });
    }

    const video = await TikTok.findOneAndDelete({ id });
    if (!video) {
      return res.status(404).json({ message: "Video not found" });
    }

    res.status(200).json({ message: "Video deleted successfully" });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

export { getSearchVideos, getAllTikTokVideos, getTikTokVideoById, deleteTikTokVideo };
