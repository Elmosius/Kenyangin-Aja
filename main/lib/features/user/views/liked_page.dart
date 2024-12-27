import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:main/data/providers/auth_state_notifier.dart';
import 'package:main/data/providers/favorite_provider.dart';

class LikedPage extends ConsumerWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider.notifier);
    final userId = authState.userProfile?['id'];

    final favoritesAsync = ref.watch(favoriteProvider);

    ref.read(favoriteProvider.notifier).fetchFavorites(userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tempat yang kamu tandai!'),
      ),
      body: favoritesAsync.when(
        data: (favorites) => favorites.isEmpty
            ? const Center(child: Text("Kamu belum menandai tempat!"))
            : GridView.builder(
                itemCount: favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final food = favorites[index];
                  return GestureDetector(
                    onTap: () {
                      context.push('/food_detail', extra: food);
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(food.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(food.name,
                                  style: const TextStyle(color: Colors.white)),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.orange),
                                  Text("${food.rating}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              ref
                                  .read(favoriteProvider.notifier)
                                  .removeFavorite(userId, food.id);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
