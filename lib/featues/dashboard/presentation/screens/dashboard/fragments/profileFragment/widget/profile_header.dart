// lib/features/profile/presentation/widgets/profile_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/theme/app_theme.dart';
import '../../../../../provider/profile_provider.dart';


class ProfileHeader extends StatelessWidget {
  final AsyncValue<ProfileState> profileState;

  const ProfileHeader({super.key, required this.profileState});

  @override
  Widget build(BuildContext context) {
    final data = profileState.value is ProfileSuccess
        ? profileState.value as ProfileSuccess
        : ProfileSuccess();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.transactionHistoryFive,
                  child: Icon(Icons.verified, color: AppColors.primaryDark, size: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            data.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
          ),
          Text(
            data.email,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.paymentMeth.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.circle, color:  AppColors.primaryDark, size: 10),
                SizedBox(width: 6),
                Text('Identity Verified', style: TextStyle(color: AppColors.primaryDark, fontSize: 16, fontWeight: FontWeight.normal,)),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.textPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Edit Profile', style: TextStyle(color: AppColors.cardBackground, fontSize: 16, fontWeight: FontWeight.normal,)),
            ),
          ),
        ],
      ),
    );
  }
}