import 'package:main/data/models/tiktok.dart';
import 'package:main/data/services/api_client.dart';

class TikTokService {
  final ApiClient _apiClient;

  TikTokService(this._apiClient);

  Future<TikTok> fetchTikTokDetail(String tiktokId) async {
    final response = await _apiClient.get('api/tiktok/$tiktokId');
    return TikTok.fromJson(response.data);
  }
}
