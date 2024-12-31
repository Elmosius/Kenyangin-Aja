import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/tiktok_table.dart';
import 'package:main/data/providers/tiktok_provider.dart';

class TikTokListPage extends ConsumerWidget {
  const TikTokListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tiktoksAsync = ref.watch(tiktokProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TikTok List',
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      body: tiktoksAsync.when(
        data: (tiktoks) => Padding(
          padding: const EdgeInsets.all(30),
          child: TikTokTable(tiktoks: tiktoks),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF5F5F5),
    );
  }
}
