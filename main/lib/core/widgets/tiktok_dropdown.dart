import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/data/models/tiktok.dart';
import 'package:main/data/providers/tiktok_provider.dart';

class TikTokDropdown extends ConsumerWidget {
  final String? selectedTikTokRef;
  final Function(String?) onChanged;

  const TikTokDropdown({
    super.key,
    required this.selectedTikTokRef,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tiktokFuture = ref.watch(tiktokServiceProvider).fetchAllVideos();

    return FutureBuilder<List<TikTok>>(
      future: tiktokFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Failed to load TikTok data: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final tiktoks = snapshot.data!;
          return DropdownButtonFormField<String>(
            isDense: true,
            dropdownColor: Colors.white,
            value: selectedTikTokRef,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.hijauTua),
                borderRadius: BorderRadius.circular(8),
              ),
              labelText: 'TikTok Video Reference',
              labelStyle: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: tiktoks.map((TikTok tiktok) {
              return DropdownMenuItem(
                value: tiktok.id,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: SizedBox(
                    width: 300,
                    child: Text(
                      '${tiktok.creator.name} - ${tiktok.description}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('No TikTok data available'),
          );
        }
      },
    );
  }
}
