import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final String imagePath;

  const EmptyStateWidget({
    required this.message,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: 500,
          height: 400,
        ),
        const SizedBox(height: 16),
        Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
