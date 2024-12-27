import 'package:main/data/models/tiktok_creator.dart';

class TikTok {
  final String id;
  final String description;
  final String videoLink;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int playCount;
  final TikTokCreator creator;
  final List<String> hashtags;
  final DateTime? createdAt;

  TikTok({
    required this.id,
    required this.description,
    required this.videoLink,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.playCount,
    required this.creator,
    required this.hashtags,
    this.createdAt,
  });

  factory TikTok.fromJson(Map<String, dynamic> json) {
    return TikTok(
      id: json['id'],
      description: json['description'],
      videoLink: json['video_link'],
      likeCount: json['like_count'],
      commentCount: json['comment_count'],
      shareCount: json['share_count'],
      playCount: json['play_count'],
      creator: TikTokCreator.fromJson(json['creator']),
      hashtags: List<String>.from(json['hashtags']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
