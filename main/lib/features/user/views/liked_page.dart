import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/models/food.dart';
import 'package:go_router/go_router.dart';

class LikedPage extends ConsumerWidget {
  const LikedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedFoods = ref.watch(likedFoodProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tempat yang kamu tandai!',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // Tambahkan aksi pencarian di sini
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: likedFoods.isEmpty
          ? const Center(
              child: Text(
                "Kamu belum menandai tempat!",
                style: TextStyle(fontSize: 16),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: likedFoods.length,
                itemBuilder: (context, index) {
                  final food = likedFoods[index];
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
                          right: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                food.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4,
                                      color: Colors.black,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${food.rating.toStringAsFixed(1)} ratings",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 4,
                                          color: Colors.black,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              ref
                                  .read(likedFoodProvider.notifier)
                                  .removeFood(food);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
