import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:main/data/providers/auth_state_notifier.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.read(authStateNotifierProvider.notifier);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: const Text('Register'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                context.goNamed('login');
              },
              child: const Text(
                "Sudah ada akun? klik untuk login",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
