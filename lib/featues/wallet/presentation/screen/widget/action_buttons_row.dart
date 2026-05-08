// lib/features/wallet/presentation/widgets/action_buttons_row.dart
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionButton(
          imagePath: "images/add_fund.png",
          label: 'Add Funds',
          onTap: () {},
        ),
        _buildActionButton(
          imagePath: "images/transfer.png",
          label: 'Transfer',
          onTap: () {},
        ),
        _buildActionButton(
          imagePath: "images/view_card.png",
          label: 'View Card',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String imagePath,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 10.0,
            ),

            Image.asset(
              imagePath,
              height: 48,
              width: 48,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}