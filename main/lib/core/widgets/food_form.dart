import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FoodFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController imageUrlController;
  final bool isEditMode;

  const FoodFormFields({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.imageUrlController,
    this.isEditMode = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nama Restoran
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Nama Restoran',
            hintText:
                isEditMode ? 'Edit nama restoran' : 'Masukkan nama restoran',
            labelStyle: GoogleFonts.inter(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
            suffixIcon: const Icon(
              Icons.restaurant,
              color: Colors.black,
              size: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.hijauTua),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? 'Nama restoran masih kosong!' : null,
        ),
        const SizedBox(height: 16),

        // Deskripsi Restoran
        TextFormField(
          controller: descriptionController,
          decoration: InputDecoration(
            labelText: 'Deskripsi Restoran',
            hintText: isEditMode
                ? 'Edit deskripsi restoran'
                : 'Masukkan deskripsi singkat restoran',
            labelStyle: GoogleFonts.inter(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            suffixIcon: Icon(
              MdiIcons.text,
              color: Colors.black,
              size: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.hijauTua),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          maxLines: 3,
          validator: (value) =>
              value?.isEmpty ?? true ? 'Deskripsi masih kosong!' : null,
        ),
        const SizedBox(height: 16),

        // URL Gambar Restoran
        TextFormField(
          controller: imageUrlController,
          decoration: InputDecoration(
            labelText: 'URL Gambar Restoran',
            hintText:
                isEditMode ? 'Edit URL gambar restoran' : 'Masukkan URL gambar',
            labelStyle: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            suffixIcon: const Icon(
              Icons.image,
              color: Colors.black,
              size: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.hijauTua),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          validator: (value) =>
              value?.isEmpty ?? true ? 'URL gambar masih kosong!' : null,
        ),
      ],
    );
  }
}
