import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:main/features/admin/views/add_food_page.dart';
import 'package:main/features/admin/views/admin_dashboard_page.dart';
import 'package:main/features/admin/views/food_list_page.dart';
import 'package:main/features/auth/views/login_page.dart';
import 'package:main/features/auth/views/register_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
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
      path: '/',
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
      ],
    ),
  ],
  debugLogDiagnostics: true,
  initialLocation: '/login',
  routerNeglect: true,
);
