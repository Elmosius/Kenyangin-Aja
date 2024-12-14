import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Failed to load TikTok data: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final tiktoks = snapshot.data!;
          return DropdownButtonFormField<String>(
            value: selectedTikTokRef,
            decoration: const InputDecoration(labelText: 'TikTok Ref'),
            items: tiktoks.map((TikTok tiktok) {
              return DropdownMenuItem(
                value: tiktok.id,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 500), // Batasi lebar
                  child: Text(
                    tiktok.creator.name ,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          );
        } else {
          return const Text('No TikTok data available');
        }
      },
    );
  }
}
