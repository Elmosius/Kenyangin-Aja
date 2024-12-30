import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
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
}
