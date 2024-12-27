import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/services/api_client.dart';
import 'package:main/data/services/favorite_service.dart';
import 'package:main/data/services/food_service.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final foodServiceProvider = Provider((ref) {
  final apiClient = ref.read(apiClientProvider);
  return FoodService(apiClient);
});

final favoriteServiceProvider = Provider((ref) {
  final apiClient = ref.read(apiClientProvider);
  return FavoriteService(apiClient);
});
