import 'package:main/data/models/food.dart';
import 'package:main/data/services/api_client.dart';

class FoodService {
  final ApiClient _apiClient;

  FoodService(this._apiClient);

  Future<List<Food>> fetchFoods() async {
    final response = await _apiClient.get('/foods');
    return (response.data as List).map((food) => Food.fromJson(food)).toList();
  }

  Future<void> deleteFood(String id) async {
    await _apiClient.delete('/foods/$id');
  }

  Future<Food> addFood(Food food) async {
    final response = await _apiClient.post('/foods', food.toJson());
    return Food.fromJson(response.data['food']);
  }

  Future<Food> updateFood(String id, Food food) async {
    final response = await _apiClient.put('/foods/$id', food.toJson());
    return Food.fromJson(response.data['food']);
  }
}