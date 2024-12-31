import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/core/widgets/food_table.dart';
import 'package:main/data/providers/food_provider.dart';

class FoodListPage extends ConsumerWidget {
  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodsAsync = ref.watch(foodProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Food List'),
          backgroundColor: const Color(0xFFF5F5F5),
        ),
        body: foodsAsync.when(
          data: (foods) => FoodListTable(foods: foods),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text(
              'Error: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5));
  }
}
