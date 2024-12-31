import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/models/tiktok.dart';
import 'package:main/data/providers/api_client_provider.dart';
import 'package:main/data/services/tiktok_service.dart';

final tiktokServiceProvider =
    Provider((ref) => TikTokService(ref.read(apiClientProvider)));

final tiktokProvider = FutureProvider<List<TikTok>>((ref) async {
  final tiktokService = ref.read(tiktokServiceProvider);
  return tiktokService.fetchAllVideos();
});

final tiktokDetailProvider =
    FutureProvider.family<TikTok, String>((ref, id) async {
  final tiktokService = ref.read(tiktokServiceProvider);
  return tiktokService.fetchVideoById(id);
});

final tiktokActionProvider =
    StateNotifierProvider<TikTokActionNotifier, AsyncValue<void>>((ref) {
  final tiktokService = ref.read(tiktokServiceProvider);
  return TikTokActionNotifier(tiktokService);
});

final refreshTikTokProvider = FutureProvider<List<TikTok>>((ref) async {
  final tiktokService = ref.read(tiktokServiceProvider);
  return tiktokService.searchVideos("kulinerbandung");
});

final searchTikTokProvider = FutureProvider.family<List<TikTok>, String>(
  (ref, query) async {
    final tiktokService = ref.read(tiktokServiceProvider);
    return tiktokService.searchVideos(query);
  },
);

class TikTokActionNotifier extends StateNotifier<AsyncValue<void>> {
  final TikTokService _tiktokService;

  TikTokActionNotifier(this._tiktokService)
      : super(const AsyncValue.data(null));

  Future<void> deleteTikTok(String id) async {
    state = const AsyncValue.loading();
    try {
      await _tiktokService.deleteVideo(id);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
