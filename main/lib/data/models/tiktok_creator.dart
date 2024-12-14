class TikTokCreator {
  final String id;
  final String name;
  final String avatar;

  TikTokCreator({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory TikTokCreator.fromJson(Map<String, dynamic> json) {
    return TikTokCreator(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}
