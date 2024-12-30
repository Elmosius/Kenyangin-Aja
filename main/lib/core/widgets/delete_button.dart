import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onConfirmed;

  const DeleteButton({required this.onConfirmed, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        onPressed: () {
          _showConfirmationDialog(context);
        },
        child: Text(
          "Delete akun ini",
          style: GoogleFonts.inter(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: Colors.red,
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Konfirmasi Hapus Akun"),
          content: const Text(
              "Apakah Anda yakin ingin menghapus akun ini? Tindakan ini tidak dapat dibatalkan."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Batal",
                style: GoogleFonts.inter(color: Colors.black),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pop(context);
                onConfirmed();
              },
              child:
                  Text("Hapus", style: GoogleFonts.inter(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
