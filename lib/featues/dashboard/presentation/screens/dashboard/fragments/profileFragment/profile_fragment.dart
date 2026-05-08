import 'package:flutter/material.dart';
// lib/features/profile/presentation/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/core/theme/app_theme.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/profileFragment/widget/daily_limit_card.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/profileFragment/widget/linked_methods_section.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/profileFragment/widget/profile_header.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/profileFragment/widget/profile_menu.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/profileFragment/widget/security_status_card.dart';

import '../../../../provider/profile_provider.dart';


class ProfileFragment extends ConsumerStatefulWidget {
  const ProfileFragment({super.key});

  @override
  ConsumerState<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends ConsumerState<ProfileFragment> {
  @override
  void initState() {
    super.initState();
    ref.read(profileProvider.notifier).loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150?img=3",
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Tupay",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileHeader(profileState: profileState),
            const SizedBox(height: 24),

            ProfileMenu(),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: ElevatedButton.icon(onPressed: (){
                Navigator.pop(context, {

                });
              },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.logout.withOpacity(0.4),
                  minimumSize:Size(MediaQuery.of(context).size.width, 75.0),
                  side: BorderSide(color: AppColors.logout.withOpacity(0.8), width: 1.0),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                icon: Image.asset(
                  "images/log_out.png",
                  height: 18,
                  width: 18,
                  fit: BoxFit.contain,
                ),
                label: Text("Log Out",  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: AppColors.recentActTwo),),
              ),
            ),


            SecurityStatusCard(),
            const SizedBox(height: 24),

            DailyLimitCard(),
            const SizedBox(height: 24),

            LinkedMethodsSection(),
            const SizedBox(height: 40),

            // Logout Button

          ],
        ),
      ),
    );
  }
}