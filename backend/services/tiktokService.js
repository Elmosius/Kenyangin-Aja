import tiktok from "../config/tiktok.js";
import TikTok from "../models/tiktokModel.js";

const searchVideos = async (query) => {
  const filters = {
    minLikes: 10000,
    minComments: 500,
    minShares: 1000,
    minViews: 1000000,
  };

  try {
    const res = await tiktok.public.search({
      category: "general",
      query: `${query}`,
      country: "id",
    });

    // Filter dan mapping video
    const filteredVideos = res.json.data
      .filter((video) => {
        const stats = video.item.stats;
        return stats.diggCount >= filters.minLikes && stats.commentCount >= filters.minComments && stats.shareCount >= filters.minShares && stats.playCount >= filters.minViews;
      })
      .map((video) => ({
        id: video.item.id,
        description: video.item.desc,
        video_link: `https://www.tiktok.com/@${video.item.author.uniqueId}/video/${video.item.id}`,
        like_count: video.item.stats.diggCount,
        comment_count: video.item.stats.commentCount,
        share_count: video.item.stats.shareCount,
        play_count: video.item.stats.playCount,
        creator: {
          id: video.item.author.uniqueId,
          name: video.item.author.nickname,
          avatar: video.item.author.avatarLarger,
        },
        hashtags: video.item.textExtra.map((tag) => tag.hashtagName),
      }));

    // Simpan video baru ke database
    const newVideos = [];
    for (const video of filteredVideos) {
      const exists = await TikTok.findOne({ id: video.id });
      if (!exists) {
        console.info(`Saving new video: ${video.id}`);
        const savedVideo = await TikTok.create(video);
        newVideos.push(savedVideo);
      } else {
        console.info(`Video already exists: ${video.id}`);
      }
    }

    console.info(`New videos added: ${newVideos.length}`);
    return newVideos; // Return hanya video yang baru disimpan
  } catch (e) {
    console.error("Error fetching TikTok videos:", e.message);
    throw new Error("Failed to fetch TikTok videos");
  }
};

export { searchVideos };
