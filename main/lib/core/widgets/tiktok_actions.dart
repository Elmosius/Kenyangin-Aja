import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/data/models/tiktok.dart';
import 'package:main/data/providers/tiktok_provider.dart';

class TikTokActions extends ConsumerWidget {
  final TikTok tiktok;

  const TikTokActions({super.key, required this.tiktok});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.info, color: Colors.blue, size: 20),
          onPressed: () => _showDetailModal(context),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red, size: 20),
          onPressed: () => _showDeleteConfirmation(context, ref),
        ),
      ],
    );
  }

  void _showDetailModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Creator: ${tiktok.creator.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Description: ${tiktok.description}'),
                const SizedBox(height: 8),
                Text('Likes: ${tiktok.likeCount}'),
                Text('Comments: ${tiktok.commentCount}'),
                Text('Shares: ${tiktok.shareCount}'),
                Text('Plays: ${tiktok.playCount}'),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Delete TikTok',
            style: GoogleFonts.inter(color: Colors.black),
          ),
          content: Text(
            'Are you sure you want to delete this TikTok video?',
            style: GoogleFonts.inter(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(color: Colors.black),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                'Delete',
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final notifier = ref.read(tiktokActionProvider.notifier);

      await notifier.deleteTikTok(tiktok.id);
      ref.invalidate(tiktokProvider);
      final state = ref.read(tiktokActionProvider);

      if (context.mounted) {
        if (state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete TikTok Ref')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('TikTok deleted successfully')),
          );
        }
      }
    }
  }
}
