import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/core/widgets/stat_card.dart';

class FavoriteStatSection extends StatelessWidget {
  final AsyncValue<List<dynamic>> favoritesAsync;

  const FavoriteStatSection({required this.favoritesAsync, super.key});

  @override
  Widget build(BuildContext context) {
    return favoritesAsync.when(
      data: (favorites) => StatCard(
        title: "Total yang disukai",
        value: "${favorites.length}",
        description:
            "Anda telah menyukai tempat berikut: ${favorites.map((food) => food.name).join(', ')}",
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text(
          'Error: $error',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
