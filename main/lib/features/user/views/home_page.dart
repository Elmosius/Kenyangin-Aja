import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/core/widgets/header.dart';
import 'package:main/core/widgets/search_bar.dart';
import 'package:main/core/widgets/top_rating.dart';
import 'package:main/core/widgets/viral_place_list.dart';
import 'package:main/data/models/food.dart';
import 'package:main/data/providers/food_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final foodsAsync = ref.watch(foodProvider);

    const int maxTopRating = 5;
    const int maxViralPlaces = 4;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: foodsAsync.when(
        data: (foods) {
          final topRatingFoods = List<Food>.from(foods)
            ..sort((a, b) => b.rating.compareTo(a.rating))
            ..take(maxTopRating);

          final viralPlacesFoods = List<Food>.from(foods)
            ..sort((a, b) => (b.createdAt!).compareTo(a.createdAt!))
            ..take(maxViralPlaces);

          List<Food> searchResults = foods;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(35),
            child: Column(
              children: [
                const HeaderWidget(),
                const SizedBox(height: 24),
                SearchBarWidget(
                  onSearch: (query) {
                    searchResults = foods
                        .where((food) => food.name
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                        .toList();
                  },
                ),
                const SizedBox(height: 24),
                TopRatingWidget(
                  topRatingFoods: topRatingFoods.take(5).toList(),
                ),
                const SizedBox(height: 24),
                ViralPlacesWidget(
                  viralPlacesFoods: viralPlacesFoods.take(4).toList(),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text("Error: $error"),
        ),
      ),
    );
  }
}
