import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/models/food.dart';
import 'package:main/data/providers/api_client_provider.dart';
import 'package:main/data/services/food_service.dart';

final foodProvider =
    StateNotifierProvider<FoodNotifier, AsyncValue<List<Food>>>((ref) {
  return FoodNotifier(ref.read(foodServiceProvider));
});

final foodDetailProvider =
    FutureProvider.family<Food, String>((ref, id) async {
  final foodService = ref.read(foodServiceProvider);
  return await foodService.getFoodDetail(id);
});

class FoodNotifier extends StateNotifier<AsyncValue<List<Food>>> {
  final FoodService _foodService;

  FoodNotifier(this._foodService) : super(const AsyncValue.loading()) {
    fetchFoods();
  }

  Future<void> fetchFoods() async {
    try {
      final foods = await _foodService.fetchFoods();
      state = AsyncValue.data(foods);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> addFood(Food food) async {
    try {
      await _foodService.addFood(food);
      fetchFoods(); // Refresh list after adding
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateFood(String id, Food food) async {
    try {
      await _foodService.updateFood(id, food);
      fetchFoods();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteFood(String id) async {
    try {
      await _foodService.deleteFood(id);
      fetchFoods(); 
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
