import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

class CreationDateCard extends StatelessWidget {
  final String accountCreationDate;

  const CreationDateCard({required this.accountCreationDate, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Akun ini dibuat pada tanggal $accountCreationDate",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.hitam,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
