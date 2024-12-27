import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:main/core/themes/colors.dart';
import 'package:main/data/providers/auth_state_notifier.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 800;

    Future<void> login() async {
      try {
        await authStateNotifier.login(
          email: emailController.text,
          password: passwordController.text,
        );

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );

        // mau kemana stelah login
        context.goNamed('home');
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
          Positioned.fill(
            top: 150,
            child: Image.asset(
              'images/lingkaran-orange.png',
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              height: isWeb ? double.infinity : 800,
              child: Column(
                crossAxisAlignment: isWeb
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 250,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Image.asset(
                            'images/login.png',
                            width: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Align(
                            alignment:
                                isWeb ? Alignment.center : Alignment.centerLeft,
                            child: Text(
                              'Welcome',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.montserrat(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: AppColors.hitam,
                              ),
                            ),
                          ),
                          Align(
                            alignment:
                                isWeb ? Alignment.center : Alignment.centerLeft,
                            child: Text(
                              'Back!',
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
                              suffixIcon: const Icon(Icons.email_outlined),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.hitam),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.hitam),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
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
                                borderSide: BorderSide(color: AppColors.hitam),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.hitam),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Login Button
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
                            onPressed: login,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),
                        // Forgot Password
                        GestureDetector(
                          onTap: () {
                            context.pushNamed('register');
                          },
                          child: Text(
                            'Belum ada akun? Daftar disini',
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
        ],
      ),
    );
  }
}
