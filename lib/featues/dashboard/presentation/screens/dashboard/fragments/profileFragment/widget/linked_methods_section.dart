// lib/features/profile/presentation/widgets/linked_methods_section.dart
import 'package:flutter/material.dart';

import '../../../../../../../../core/theme/app_theme.dart';


class LinkedMethodsSection extends StatefulWidget {
  const LinkedMethodsSection({super.key});

  @override
  State<LinkedMethodsSection> createState() =>
      _LinkedMethodsSectionState();
}

class _LinkedMethodsSectionState
    extends State<LinkedMethodsSection> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Linked Methods',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textPrimary,
                ),
              ),

              TextButton(
                onPressed: () {},
                child: const Text(
                  'Add New',
                  style: TextStyle(
                    color: AppColors.primaryDark,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _linkedMethod(
            index: 0,
            logoColor: AppColors.linkDev,
            title: 'Chase Bank Premier',
            subtitle: 'Checking •••• 4421',
          ),

          const SizedBox(height: 12),

          _linkedMethod(
            index: 1,
            logoColor: AppColors.primary,
            title: 'Wells Fargo Savings',
            subtitle: 'Savings •••• 0982',
          ),
        ],
      ),
    );
  }

  Widget _linkedMethod({
    required int index,
    required Color logoColor,
    required String title,
    required String subtitle,
  }) {

    final isActive = selectedIndex == index;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border: Border.all(
            color: AppColors.transfer_stepperTwo.withOpacity(0.5),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: logoColor,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  logoColor == AppColors.linkDev
                      ? 'CHASE'
                      : 'WF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              isActive
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: isActive
                  ? AppColors.primaryDark
                  : AppColors.transfer_stepper,
            ),
          ],
        ),
      ),
    );
  }
}