import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/providers/food_provider.dart';
import 'package:main/data/providers/tiktok_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodDetailPage extends ConsumerWidget {
  final String foodId;

  const FoodDetailPage({super.key, required this.foodId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodAsync = ref.watch(foodDetailProvider(foodId));

    return Scaffold(
      appBar: AppBar(title: const Text('Food Detail')),
      body: foodAsync.when(
        data: (food) {
          final tiktokDetailAsync = food.tiktokRef != null
              ? ref.watch(tiktokDetailProvider(food.tiktokRef!))
              : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (food.imageUrl.isNotEmpty)
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        food.imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Name: ${food.name}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Description: ${food.description}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                if (food.locations.isNotEmpty) ...[
                  const Text(
                    'Location:',
                  ),
                  ...food.locations.map(
                    (location) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '- City: ${location.city}',
                          ),
                          Text(
                            '- Address: ${location.address}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  'Rating: ${food.rating.toStringAsFixed(1)}',
                ),
                const SizedBox(height: 16),
                if (food.tiktokRef != null) ...[
                  const Divider(thickness: 1),
                  const Text(
                    'TikTok Reference:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tiktokDetailAsync != null
                      ? tiktokDetailAsync.when(
                          data: (tiktok) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
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
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Could not open TikTok'),
                                        ),
                                      );
                                    }
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
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) =>
                              Text('Failed to load TikTok data: $error'),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ] else
                  const Text('No TikTok reference available'),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading food: $error'),
        ),
      ),
    );
  }
}
