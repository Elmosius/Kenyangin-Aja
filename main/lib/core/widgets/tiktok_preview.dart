import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/providers/tiktok_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TikTokPreview extends ConsumerWidget {
  final String tiktokRef;

  const TikTokPreview({super.key, required this.tiktokRef});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tiktokDetailAsync = ref.watch(tiktokDetailProvider(tiktokRef));

    return tiktokDetailAsync.when(
      data: (tiktok) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Description: ${tiktok.description}'),
              Text('Likes: ${tiktok.likeCount}'),
              Text('Comments: ${tiktok.commentCount}'),
              Text('Shares: ${tiktok.shareCount}'),
              Text('Plays: ${tiktok.playCount}'),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  final url = tiktok.videoLink;
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open TikTok')),
                    );
                  }
                },
                child: const Text(
                  'Watch Video',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Failed to load TikTok details: $error'),
    );
  }
}
