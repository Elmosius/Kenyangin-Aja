import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

class SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isActive;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: isActive ? Colors.white70 : AppColors.hitam,
        size: 20,
      ),
      title: Text(
        title,
        style: GoogleFonts.roboto(
            color: isActive ? Colors.white70 : AppColors.hitam,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      tileColor: isActive ? Colors.white70 : null,
    );
  }
}
