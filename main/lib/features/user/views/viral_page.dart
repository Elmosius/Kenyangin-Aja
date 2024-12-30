import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/empty_status.dart';
import 'package:main/core/widgets/grid_card.dart';
import 'package:main/core/widgets/search_bar.dart';
import 'package:main/data/providers/food_provider.dart';
import 'package:go_router/go_router.dart';

class ViralPage extends StatefulWidget {
  const ViralPage({super.key});

  @override
  State<ViralPage> createState() => _ViralPageState();
}

class _ViralPageState extends State<ViralPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final double childAspectRatio = screenWidth < 800 ? 3 / 3 : 8 / 5;

    return Consumer(
      builder: (context, ref, child) {
        final foodsAsync = ref.watch(foodProvider);

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: foodsAsync.when(
            data: (foods) {
              // Filter data untuk makanan viral berdasarkan waktu pembuatan (createdAt)
              final viralFoods = foods
                  .where((food) => food.name
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList()
                ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    Text(
                      "Tempat Makanan Lagi Viral Nich...",
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Search Bar
                    SearchBarWidget(
                      onSearch: (query) {
                        setState(() {
                          searchQuery = query;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Konten Grid atau Pesan Kosong
                    viralFoods.isEmpty
                        ? const Center(
                            child: EmptyStateWidget(
                              message:
                                  "Maaf, saat ini belum ada tempat yang cocok dengan pencarian Anda.",
                              imagePath: 'images/status_empty.png',
                            ),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viralFoods.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: screenWidth < 600 ? 2 : 5,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 32,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemBuilder: (context, index) {
                              final food = viralFoods[index];
                              return GridCardWidget(
                                name: food.name,
                                imageUrl: food.imageUrl,
                                rating: food.rating,
                                onTap: () {
                                  context.goNamed('food_detail', extra: food);
                                },
                              );
                            },
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
