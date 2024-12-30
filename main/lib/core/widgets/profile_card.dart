import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

class ProfileCard extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onEditName;
  final VoidCallback onEditEmail;

  const ProfileCard({
    required this.userName,
    required this.userEmail,
    required this.onEditName,
    required this.onEditEmail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Namamu",
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.hitam,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.orange),
                  ),
                  onPressed: onEditName,
                  child: Text(
                    "Edit",
                    style: GoogleFonts.inter(
                      color: AppColors.hitam,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Email",
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.hitam,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userEmail,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.orange),
                  ),
                  onPressed: onEditEmail,
                  child: Text(
                    "Edit",
                    style: GoogleFonts.inter(
                      color: AppColors.hitam,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
