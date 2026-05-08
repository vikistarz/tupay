// lib/features/profile/presentation/widgets/profile_menu.dart
import 'package:flutter/material.dart';
import 'package:tupay_app/core/theme/app_theme.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          _menuItem("images/person.png", 'Personal Information'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 25.0),
            child: const Divider(height: 15),
          ),
          _menuItem("images/security.png", 'Security (Biometrics/PIN)'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 25.0),
            child: const Divider(height: 15),
          ),
          _menuItem("images/housing.png", 'Linked Bank Accounts'),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 25.0),
            child: const Divider(height: 15),
          ),
          _menuItem("images/help.png", 'Help & Support'),
        ],
      ),
    );
  }

  Widget _menuItem(String imagePath, String title) {
    return ListTile(
      leading:   Image.asset(
        imagePath,
        height: 32,
        width: 32,
        fit: BoxFit.contain,
      ),
      title: Text(title, style: const TextStyle(fontSize: 16.0, color: AppColors.textPrimary)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.transfer_stepper),
      onTap: () {},
    );
  }
}