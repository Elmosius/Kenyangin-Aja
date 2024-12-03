import mongoose from "mongoose";

const TikTokSchema = new mongoose.Schema(
  {
    id: { type: String, unique: true },
    description: String,
    video_link: String,
    like_count: Number,
    comment_count: Number,
    share_count: Number,
    play_count: Number,
    creator: {
      id: String,
      name: String,
      avatar: String,
    },
    hashtags: [String],
  },
  {
    timestamps: true,
  }
);

const TikTok = mongoose.model("TikTok", TikTokSchema);
export default TikTok;
