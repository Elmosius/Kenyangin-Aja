import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/providers/auth_state_notifier.dart';
import 'package:main/routes/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider.notifier);
    final isLoggedIn = ref.watch(authStateNotifierProvider);
    final userRole = authState.userProfile?['role'] ?? '';

    return MaterialApp.router(
      title: 'Welcome Kenyagins!',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter(
        isLoggedIn: isLoggedIn,
        userRole: userRole,
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
