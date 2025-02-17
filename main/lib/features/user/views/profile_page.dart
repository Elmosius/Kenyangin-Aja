import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/creation_card.dart';
import 'package:main/core/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:main/data/providers/auth_state_notifier.dart';
import 'package:main/data/providers/favorite_provider.dart';
import 'package:main/core/widgets/delete_button.dart';
import 'package:main/features/user/layouts/fav_stat.dart';
import 'package:main/features/user/layouts/profile_card.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    final authState = ref.read(authStateNotifierProvider.notifier);
    final userId = authState.userProfile?['id'];

    if (userId != null) {
      ref.read(favoriteProvider.notifier).fetchFavorites(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider.notifier);
    final userProfile = authState.userProfile;

    log(userProfile.toString());

    final userId = userProfile?['id'] ?? '';
    final favoritesAsync = ref.watch(favoriteProvider);

    if (userProfile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final userName = userProfile['name'] ?? 'Unknown';
    final userEmail = userProfile['email'] ?? 'Unknown';
    final accountCreationDate = userProfile['createdAt'] ?? 'Unknown';
    final role = userProfile['role'] ?? 'user';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Title
            Text(
              "Profile",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // Profile Card (Name & Email)
            ProfileCardSection(
                userName: userName, userEmail: userEmail, userId: userId),
            const SizedBox(height: 16),

            // Statistics Card (Favorites)
            FavoriteStatSection(favoritesAsync: favoritesAsync),
            const SizedBox(height: 16),

            // Account Creation Date Card
            CreationDateCard(
              accountCreationDate: accountCreationDate,
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (role == 'admin')
                  CustomButton(
                    text: 'Admin Page',
                    onPressed: () {
                      context.goNamed('dashboard');
                    },
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 12,
                  ),
                if (role != 'admin')
                  CustomButton(
                    text: 'Logout',
                    onPressed: () async {
                      await authState.logout();
                      if (!context.mounted) return;
                      context.goNamed('login');
                    },
                    backgroundColor: Colors.white,
                    textColor: Colors.black,
                    fontSize: 12,
                  ),
                // Delete Account Button
                DeleteButton(
                  onConfirmed: () {
                    ref
                        .read(authStateNotifierProvider.notifier)
                        .deleteAccount(userProfile['id']);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
