import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/core/widgets/empty_status.dart';
import 'package:main/core/widgets/header.dart';
import 'package:main/core/widgets/search_bar.dart';
import 'package:main/features/user/layouts/top_rating.dart';
import 'package:main/features/user/layouts/viral_place_list.dart';
import 'package:main/data/providers/food_provider.dart';
import 'package:main/data/providers/city_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final foodsAsync = ref.watch(foodProvider);
        final selectedLocation = ref.watch(cityProvider);

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: foodsAsync.when(
            data: (foods) {
              final filteredFoods = foods
                  .where((food) =>
                      food.locations.any(
                          (location) => location.city == selectedLocation) &&
                      food.name
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                  .toList();

              final topRatingFoods = filteredFoods
                  .where((food) => food.rating >= 4.5)
                  .toList()
                ..sort((a, b) => b.rating.compareTo(a.rating));

              final viralPlacesFoods = filteredFoods
                ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

              final isEmpty =
                  topRatingFoods.isEmpty && viralPlacesFoods.isEmpty;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(35),
                child: Column(
                  children: [
                    HeaderWidget(
                      selectedLocation: selectedLocation,
                      onLocationChanged: (value) {
                        ref.read(cityProvider.notifier).setCity(value);
                      },
                    ),
                    const SizedBox(height: 24),
                    SearchBarWidget(
                      onSearch: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    if (isEmpty)
                      const EmptyStateWidget(
                        message:
                            "Maaf, saat ini belum ada tempat yang cocok dengan pencarian Anda.",
                        imagePath: 'assets/images/status_empty.png',
                      )
                    else ...[
                      if (topRatingFoods.isNotEmpty) ...[
                        TopRatingWidget(
                          topRatingFoods: topRatingFoods.take(5).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],
                      if (viralPlacesFoods.isNotEmpty) ...[
                        ViralPlacesWidget(
                          viralPlacesFoods: viralPlacesFoods.take(4).toList(),
                        ),
                      ],
                    ],
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
      },
    );
  }
}
