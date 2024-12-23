import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:main/core/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 800;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            top: 350,
            child: Image.asset(
              'assets/images/lingkaran-hijau.png',
              fit: BoxFit.fill,
            ),
          ),

          // Content
          SafeArea(
            child: Center(
              child: SizedBox(
                width: isWeb ? 700 : double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Image.asset(
                          'assets/images/intro.png',
                          fit: BoxFit.contain,
                          width: isWeb ? 500 : 400,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          crossAxisAlignment: isWeb
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kenyangin aja",
                              style: GoogleFonts.montserrat(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: AppColors.hitam,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Tempat dimana kamu bisa menemukan berbagai macam makanan yang lagi viral.",
                              textAlign:
                                  isWeb ? TextAlign.center : TextAlign.start,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.hitam,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.pushNamed('login');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.hitam,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text("Login"),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {
                                      context.pushNamed('register');
                                    },
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      side: const BorderSide(
                                          color: AppColors.hitam),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      "SignUp",
                                      style: TextStyle(color: AppColors.hitam),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            Center(
                              child: Text(
                                "Unpublish App",
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.hitam,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
