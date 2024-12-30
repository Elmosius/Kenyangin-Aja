import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridCardWidget extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double rating;
  final VoidCallback onTap;
  final Widget? trailingIcon;

  const GridCardWidget({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.onTap,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.45),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          // Text & Rating
          Positioned(
            bottom: 16,
            left: 8,
            right: trailingIcon != null ? 48 : 8, // Adjust for trailingIcon
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      "$rating ratings",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Trailing Icon (e.g., Love Button)
          if (trailingIcon != null)
            Positioned(
              top: 8,
              right: 8,
              child: trailingIcon!,
            ),
        ],
      ),
    );
  }
}
