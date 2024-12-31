import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:main/features/admin/views/add_food_page.dart';
import 'package:main/features/admin/views/admin_dashboard_page.dart';
import 'package:main/features/admin/views/edit_food_page.dart';
import 'package:main/features/admin/views/food_detail_page.dart';
import 'package:main/features/admin/views/food_list_page.dart';
import 'package:main/features/auth/views/intro_page.dart';
import 'package:main/features/auth/views/login_page.dart';
import 'package:main/features/auth/views/not_found.dart';
import 'package:main/features/auth/views/register_page.dart';
import 'package:main/features/user/views/home_page.dart';
import 'package:main/features/user/views/liked_page.dart';
import 'package:main/features/user/views/main_page.dart';
import 'package:main/features/user/views/post_detail_page.dart';
import 'package:main/features/user/views/profile_page.dart';
import 'package:main/features/user/views/top_rating_page.dart';
import 'package:main/features/user/views/viral_page.dart';

GoRouter appRouter({
  required bool isLoggedIn,
  required String userRole,
}) {
  log('nama role $userRole');
  return GoRouter(
    initialLocation:
        isLoggedIn ? '/dashboard/food_detail/675bcd61d26a2280e2917b45' : '/',
    redirect: (context, state) {
      final isAccessingAdmin = state.uri.toString().startsWith('/dashboard');
      final isLoggingIn = state.uri.toString() == '/login';
      final isRegistering = state.uri.toString() == '/register';
      final isIntro = state.uri.toString() == '/';

      if (!isLoggedIn && !isLoggingIn && !isRegistering && !isIntro) {
        return '/';
      }

      if (isAccessingAdmin && userRole != 'admin') {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'intro',
        builder: (context, state) => const IntroPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const MainPage(
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: '/liked',
        name: 'liked',
        builder: (context, state) => const MainPage(
          child: LikedPage(),
        ),
      ),
      GoRoute(
        path: '/all-top-rating',
        name: 'top-rating',
        builder: (context, state) => const MainPage(
          child: TopRatingPage(),
        ),
      ),
      GoRoute(
        path: '/post-detail',
        name: 'post-detail',
        builder: (context, state) => const MainPage(
          child: PostDetailPage(),
        ),
      ),
      GoRoute(
        path: '/all-viral',
        name: 'viral',
        builder: (context, state) => const MainPage(
          child: ViralPage(),
        ),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const MainPage(
          child: ProfilePage(),
        ),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardLayout(
          child: Center(child: Text('Welcome to Admin Dashboard!')),
        ),
        routes: [
          GoRoute(
            path: 'list_food',
            name: 'list_food',
            builder: (context, state) => const DashboardLayout(
              child: FoodListPage(),
            ),
          ),
          GoRoute(
            path: 'add_food',
            name: 'add_food',
            builder: (context, state) => const DashboardLayout(
              child: AddFoodPage(),
            ),
          ),
          GoRoute(
            path: 'edit_food/:id',
            name: 'edit_food',
            builder: (context, state) {
              final foodId = state.pathParameters['id']!;
              return EditFoodPage(foodId: foodId);
            },
          ),
          GoRoute(
            path: 'food_detail/:id',
            name: 'food_detail',
            builder: (context, state) {
              final foodId = state.pathParameters['id']!;
              return FoodDetailPage(foodId: foodId);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
    debugLogDiagnostics: true,
  );
}
