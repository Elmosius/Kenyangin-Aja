import 'package:main/data/models/food.dart';
import 'package:main/data/services/api_client.dart';

class FavoriteService {
  final ApiClient _apiClient;

  FavoriteService(this._apiClient);

  /// Mendapatkan daftar favorit pengguna
  Future<List<Food>> getFavorites(String userId) async {
    try {
      final response = await _apiClient.get('/favorite/$userId');
      final favorites = (response.data['favorites'] as List)
          .map((json) => Food.fromJson(json))
          .toList();
      return favorites;
    } catch (e) {
      throw Exception('Failed to fetch favorites: $e');
    }
  }

  /// Menambahkan makanan ke favorit
  Future<List<Food>> addFavorite(String userId, String foodId) async {
    try {
      final response = await _apiClient.post('/favorite', {
        "userId": userId,
        "foodId": foodId,
      });
      final updatedFavorites = (response.data['favorites'] as List)
          .map((json) => Food.fromJson(json))
          .toList();
      return updatedFavorites;
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  /// Menghapus makanan dari favorit
  Future<List<Food>> removeFavorite(String userId, String foodId) async {
    try {
      final response = await _apiClient.delete('/favorite', data: {
        "userId": userId,
        "foodId": foodId,
      });
      final updatedFavorites = (response.data['favorites'] as List)
          .map((json) => Food.fromJson(json))
          .toList();
      return updatedFavorites;
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }
}
