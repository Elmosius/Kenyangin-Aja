import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/models/tiktok.dart';
import 'package:main/data/providers/api_client_provider.dart';
import 'package:main/data/services/tiktok_service.dart';

final tiktokServiceProvider =
    Provider((ref) => TikTokService(ref.read(apiClientProvider)));

final tiktokDetailProvider =
    FutureProvider.family<TikTok, String>((ref, id) async {
  final tiktokService = ref.read(tiktokServiceProvider);
  return tiktokService.fetchVideoById(id);
});
