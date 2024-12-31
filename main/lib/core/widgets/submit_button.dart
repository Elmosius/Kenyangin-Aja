import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onSubmit;

  const SubmitButton({
    super.key,
    required this.formKey,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.orange),
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          onSubmit();
        }
      },
      child: Text(
        'Submit',
        style: GoogleFonts.inter(
          color: AppColors.hitam,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
