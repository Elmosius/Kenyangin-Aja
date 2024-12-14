import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/providers/food_provider.dart';

class FoodDetailPage extends ConsumerWidget {
  final String foodId;

  const FoodDetailPage({super.key, required this.foodId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodAsync = ref.watch(foodDetailProvider(foodId));

    return Scaffold(
      appBar: AppBar(title: const Text('Food Detail')),
      body: foodAsync.when(
        data: (food) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (food.imageUrl.isNotEmpty)
                Center(
                  child: Image.network(
                    food.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
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
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              if (food.locations.isNotEmpty) ...[
                Text(
                  'Location:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ...food.locations.map(
                  (location) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '- City: ${location.city}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        '- Address: ${location.address}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                'Rating: ${food.rating.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              if (food.tiktokRef != null)
                GestureDetector(
                  onTap: () {
                    // Buka TikTok Ref
                  },
                  child: Text(
                    'TikTok Ref: ${food.tiktokRef}',
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading food: $error'),
        ),
      ),
    );
  }
}
