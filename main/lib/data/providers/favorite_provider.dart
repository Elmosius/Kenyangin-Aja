import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/models/food.dart';
import 'package:main/data/providers/api_client_provider.dart';
import 'package:main/data/services/favorite_service.dart';

final favoriteServiceProvider = Provider<FavoriteService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return FavoriteService(apiClient);
});

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, AsyncValue<List<Food>>>((ref) {
  final favoriteService = ref.read(favoriteServiceProvider);
  return FavoriteNotifier(favoriteService);
});



class FavoriteNotifier extends StateNotifier<AsyncValue<List<Food>>> {
  final FavoriteService _service;

  FavoriteNotifier(this._service) : super(const AsyncValue.loading());

  /// Memuat daftar favorit
  Future<void> fetchFavorites(String userId) async {
    try {
      final favorites = await _service.getFavorites(userId);
      state = AsyncValue.data(favorites);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Menambahkan makanan ke daftar favorit
  Future<void> addFavorite(String userId, String foodId) async {
    try {
      final updatedFavorites = await _service.addFavorite(userId, foodId);
      state = AsyncValue.data(updatedFavorites);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Menghapus makanan dari daftar favorit
  Future<void> removeFavorite(String userId, String foodId) async {
    try {
      final updatedFavorites = await _service.removeFavorite(userId, foodId);
      state = AsyncValue.data(updatedFavorites);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Memeriksa apakah makanan ada di daftar favorit
  bool isFavorite(String userId, String foodId) {
    final favorites = state.value;
    if (favorites == null) return false;
    return favorites.any((food) => food.id == foodId);
  }
}
