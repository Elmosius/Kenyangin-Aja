import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/core/widgets/creation_card.dart';
import 'package:main/core/widgets/delete_button.dart';
import 'package:main/core/widgets/profile_card.dart';
import 'package:main/core/widgets/stat_card.dart';
import 'package:main/core/widgets/title.dart';

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
            const TitleWidget(title: "Profile"),
            const SizedBox(height: 24),
            ProfileCard(
              userName: userName,
              userEmail: userEmail,
              onEditName: () {
                // Tambahkan fungsi edit nama
              },
              onEditEmail: () {
                // Tambahkan fungsi edit email
              },
            ),
            const SizedBox(height: 16),
            const StatCard(
              title: "Total yang disukai",
              value: "$totalLiked",
              description:
                  "Lorem ipsum dolor sit amet consectetur. Erat auctor a aliquam vel congue luctus.",
            ),
            const SizedBox(height: 16),
            const CreationDateCard(
              accountCreationDate: accountCreationDate,
            ),
            const SizedBox(height: 24),
            DeleteButton(onPressed: () {
              // Tambahkan fungsi delete akun
            }),
          ],
        ),
      ),
    );
  }
}
