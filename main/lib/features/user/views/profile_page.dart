import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/themes/colors.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Data pengguna (mockup untuk sementara)
    const userName = "Elmo";
    const userEmail = "elmo@gmail.com";
    const totalLiked = 20;
    const accountCreationDate = "xx-xx-xxxx";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul
            Text(
              "Profile",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Card untuk Nama
            Card(
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
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.orange),
                          ),
                          onPressed: () {
                            // Tambahkan fungsi edit nama
                          },
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
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.orange)),
                          onPressed: () {
                            // Tambahkan fungsi edit email
                          },
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
            ),

            const SizedBox(height: 16),
            // Card untuk Total yang Disukai
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total yang disukai",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.hitam,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: AppColors.orange),
                          ),
                          child: Text(
                            "$totalLiked",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Lorem ipsum dolor sit amet consectetur. Erat auctor a aliquam vel congue luctus.",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: AppColors.hitam,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            // Card untuk Tanggal Akun Dibuat
            SizedBox(
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
            ),

            const SizedBox(height: 24),

            // Tombol Delete Akun
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  // Tambahkan fungsi delete akun
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
            ),
          ],
        ),
      ),
    );
  }
}
