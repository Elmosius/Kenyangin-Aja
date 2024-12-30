import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/core/widgets/food_grid.dart';
import 'package:main/core/widgets/search_bar.dart';
import 'package:main/core/widgets/title.dart';
import 'package:main/data/providers/city_provider.dart';
import 'package:main/data/providers/food_provider.dart';

class ViralPage extends StatefulWidget {
  const ViralPage({super.key});

  @override
  State<ViralPage> createState() => _ViralPageState();
}

class _ViralPageState extends State<ViralPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final foodsAsync = ref.watch(foodProvider);
        final selectedLocation = ref.watch(cityProvider);

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF5F5F5),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: foodsAsync.when(
            data: (foods) {
              final viralFoods = foods
                  .where((food) =>
                      food.locations.any(
                          (location) => location.city == selectedLocation) &&
                      food.name
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase()))
                  .toList()
                ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleWidget(
                        title: "Tempat Makanan Lagi Viral Nich..."),
                    const SizedBox(height: 24),
                    SearchBarWidget(
                      onSearch: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    FoodGridWidget(
                      foods: viralFoods,
                      emptyMessage:
                          "Maaf, saat ini belum ada tempat viral yang cocok.",
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'Error: $error',
                style: const TextStyle(fontSize: 14, color: Colors.red),
              ),
            ),
          ),
        );
      },
    );
  }
}
