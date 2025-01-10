import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/data/providers/tiktok_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TikTokPreview extends ConsumerWidget {
  final String tiktokRef;

  const TikTokPreview({super.key, required this.tiktokRef});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tiktokDetailAsync = ref.watch(tiktokDetailProvider(tiktokRef));

    return tiktokDetailAsync.when(
      data: (tiktok) => Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tiktok.description,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _statItem(
                      Icons.thumb_up, formatNumber(tiktok.likeCount), 'Likes'),
                  const SizedBox(width: 20),
                  _statItem(Icons.comment, formatNumber(tiktok.commentCount),
                      'Comments'),
                  const SizedBox(width: 20),
                  _statItem(
                      Icons.share, formatNumber(tiktok.shareCount), 'Shares'),
                  const SizedBox(width: 20),
                  _statItem(Icons.play_arrow, formatNumber(tiktok.playCount),
                      'Plays'),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final url = tiktok.videoLink;
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Could not open TikTok'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Watch Video',
                  style: GoogleFonts.inter(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blueAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Failed to load TikTok details: $error',
          style: GoogleFonts.inter(color: Colors.red),
        ),
      ),
    );
  }

  Widget _statItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 14, color: AppColors.hijauTua),
        const SizedBox(height: 5),
        Text(
          value,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

String formatNumber(int number) {
  if (number >= 1000000) {
    return '${(number / 1000000).toStringAsFixed(1)}M';
  } else if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(1)}K';
  } else {
    return number.toString();
  }
}
