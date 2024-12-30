import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CreationDateCard extends StatelessWidget {
  final String accountCreationDate;

  const CreationDateCard({required this.accountCreationDate, super.key});

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(accountCreationDate);

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
            "Akun ini dibuat pada tanggal $formattedDate",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk memformat tanggal
  String _formatDate(String rawDate) {
    try {
      final date = DateTime.parse(rawDate);
      final formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
      return formatter.format(date);
    } catch (e) {
      return "Tanggal tidak valid";
    }
  }
}
