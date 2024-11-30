import tiktok from "../config/tiktok.js";

const searchVideos = async (query) => {
  try {
    const res = await tiktok.public.search({
      category: "general",
      query: `${query}`,
      country: "id",
    });

    return res.json;
  } catch (e) {
    console.error("Error fetching TikTok videos:", e.message);
    throw new Error("Failed to fetch TikTok videos");
  }
};

export { searchVideos };
