import 'package:main/data/models/location.dart';

class Food {
  final String id;
  final String name;
  final String description;
  final List<Location> locations;
  final String imageUrl;
  final double rating;
  final String? tiktokRef;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.locations,
    required this.imageUrl,
    required this.rating,
    this.tiktokRef,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      locations: (json['locations'] as List)
          .map((loc) => Location.fromJson(loc))
          .toList(),
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      tiktokRef: json['tiktokRef'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'locations': locations.map((loc) => loc.toJson()).toList(),
      'imageUrl': imageUrl,
      'rating': rating,
      'tiktokRef': tiktokRef,
    };
  }
}
