import 'package:main/data/models/food.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String? role;
  final List<Food> favorites;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.role,
    required this.favorites,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      password: json.containsKey('password') ? json['password'] : null,
      role: json['role'],
      favorites: (json['favorites'] as List)
          .map((food) => Food.fromJson(food))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'role': role,
      'favorites': favorites.map((food) => food.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
