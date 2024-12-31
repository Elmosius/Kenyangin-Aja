import 'package:main/data/models/tiktok.dart';
import 'package:main/data/services/api_client.dart';

class TikTokService {
  final ApiClient _apiClient;

  TikTokService(this._apiClient);

  Future<List<TikTok>> fetchAllVideos() async {
    final response = await _apiClient.get('/api/tiktok');
    final data = response.data['data'] as List;
    return data.map((json) => TikTok.fromJson(json)).toList();
  }

  Future<TikTok> fetchVideoById(String id) async {
    final response = await _apiClient.get('/api/tiktok/$id');
    return TikTok.fromJson(response.data['data']);
  }

  Future<void> deleteVideo(String id) async {
    await _apiClient.delete('/api/tiktok/$id');
  }

  Future<List<TikTok>> searchVideos(String query) async {
    final response =
        await _apiClient.get('/api/tiktok/search', params: {'query': query});
    final data = response.data['data'] as List;
    return data.map((json) => TikTok.fromJson(json)).toList();
  }
}
