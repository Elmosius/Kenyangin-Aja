import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main/core/widgets/creation_card.dart';
import 'package:main/data/providers/auth_state_notifier.dart';
import 'package:main/data/providers/favorite_provider.dart';
import 'package:main/core/widgets/profile_card.dart';
import 'package:main/core/widgets/stat_card.dart';
import 'package:main/core/widgets/delete_button.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> _showEditDialog({
    required BuildContext context,
    required String title,
    required String initialValue,
    required ValueChanged<String> onConfirm,
  }) async {
    final TextEditingController controller =
        TextEditingController(text: initialValue);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Masukkan $title baru",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  onConfirm(controller.text);
                  context.pop();
                  // SnackBar untuk notifikasi sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("$title berhasil diperbarui!")),
                  );
                } catch (e) {
                  Navigator.pop(context);
                  // SnackBar untuk notifikasi error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Gagal memperbarui $title: $e")),
                  );
                }
              },
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateNotifierProvider.notifier);
    final userProfile = authState.userProfile;

    final userId = userProfile?['id'] ?? '';
    final favoritesAsync = ref.watch(favoriteProvider);

    if (userProfile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final userName = userProfile['name'] ?? 'Unknown';
    final userEmail = userProfile['email'] ?? 'Unknown';
    final accountCreationDate = userProfile['createdAt'] ?? 'Unknown';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
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
            ProfileCard(
              userName: userName,
              userEmail: userEmail,
              onEditName: () async {
                await _showEditDialog(
                  context: context,
                  title: "Nama",
                  initialValue: userName,
                  onConfirm: (newName) async {
                    await ref
                        .read(authStateNotifierProvider.notifier)
                        .updateUserProfile(
                      userId: userId,
                      updates: {'name': newName},
                    );
                  },
                );
                setState(() {}); // Trigger rebuild
              },
              onEditEmail: () async {
                await _showEditDialog(
                  context: context,
                  title: "Email",
                  initialValue: userEmail,
                  onConfirm: (newEmail) async {
                    await ref
                        .read(authStateNotifierProvider.notifier)
                        .updateUserProfile(
                      userId: userId,
                      updates: {'email': newEmail},
                    );
                  },
                );
                setState(() {}); // Trigger rebuild
              },
            ),
            const SizedBox(height: 16),

            // Statistics Card (Favorites)
            favoritesAsync.when(
              data: (favorites) => StatCard(
                title: "Total yang disukai",
                value: "${favorites.length}",
                description:
                    "Anda telah menyukai tempat berikut: ${favorites.map((food) => food.name).join(', ')}.",
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Center(
                child: Text(
                  'Error: $error',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Account Creation Date Card
            CreationDateCard(
              accountCreationDate: accountCreationDate,
            ),
            const SizedBox(height: 24),

            // Delete Account Button
            DeleteButton(
              onPressed: () {
                ref
                    .read(authStateNotifierProvider.notifier)
                    .deleteAccount(userId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
