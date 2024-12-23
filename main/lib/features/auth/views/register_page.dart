import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:main/core/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/data/providers/auth_state_notifier.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 800;

    Future<void> register() async {
      try {
        await authStateNotifier.register(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );
        context.goNamed('dashboard');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            top: 150,
            child: Image.asset(
              'images/lingkaran-orange2.png',
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: isWeb ? 950 : 800,
              child: Center(
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: isWeb ? double.infinity : 800,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Header Image
                        Stack(
                          children: [
                            Positioned(
                              child: Image.asset(
                                'images/regist.png',
                                width: 350,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: SizedBox(
                            child: Column(
                              children: [
                                Align(
                                  alignment: isWeb
                                      ? Alignment.center
                                      : Alignment.centerLeft,
                                  child: Text(
                                    "Let's Start",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.hitam,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Form Fields
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Column(
                            children: [
                              // Name Field
                              SizedBox(
                                width: 500,
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Name',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hitam,
                                      ),
                                    ),
                                    suffixIcon:
                                        const Icon(Icons.person_outline),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.hitam),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.hitam),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Email Field
                              SizedBox(
                                width: 500,
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Email Address',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hitam,
                                      ),
                                    ),
                                    suffixIcon:
                                        const Icon(Icons.email_outlined),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.hitam),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.hitam),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Password Field
                              SizedBox(
                                width: 500,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Password',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hitam,
                                      ),
                                    ),
                                    suffixIcon: const Icon(Icons.lock_outline),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.hitam),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.hitam),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),

                              // Register Button
                              SizedBox(
                                height: 45,
                                width: 500,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.hitam,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: register,
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),

                              // Link to Login
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed('login');
                                },
                                child: Text(
                                  'Sudah ada akun? Klik di sini untuk login',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.hitam,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
