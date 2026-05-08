// lib/features/cards/presentation/widgets/security_controls.dart
import 'package:flutter/material.dart';

import '../../../../../../../../core/theme/app_theme.dart';
import '../../../../../provider/card_provider.dart';


class SecurityControls extends StatelessWidget {
  final VirtualCardSuccess cardData;

  const SecurityControls({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: const Text(
              'SECURITY CONTROLS',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.textPrimary),
            ),
          ),
          const SizedBox(height: 12),

          Container(
            margin: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
            decoration: BoxDecoration(
              color: AppColors.cardSecurity,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildControlItem(
              imagePath: "images/freeze.png",
              title: 'Freeze Card',
              isSwitch: true,
              onChanged: (val) {},
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            decoration: BoxDecoration(
              color: AppColors.cardSecurity,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildControlItem(
              imagePath: "images/limit.png",
              title: 'Set Limits',
              trailing: const Icon(Icons.chevron_right, color: AppColors.cardSecurityOne,),
              onTap: () {},
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: AppColors.cardSecurity,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildControlItem(
              imagePath: "images/pin.png",
              title: 'Reset PIN',
              trailing: const Icon(Icons.chevron_right, color: AppColors.cardSecurityOne,),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlItem({
    required String imagePath,
    required String title,
    bool isSwitch = false,
    Widget? trailing,
    VoidCallback? onTap,
    ValueChanged<bool>? onChanged,
  }) {
    return ListTile(
       leading: Image.asset(
         imagePath,
         height: 20,
         width: 20,
         fit: BoxFit.contain,
       ),

      title: Text(title, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: AppColors.textPrimary)),
      trailing: isSwitch
          ? Transform.scale(
        scale: 0.8, // increase/decrease overall size
        child: Switch(
          value: false,
          onChanged: onChanged,

          // Remove black outline
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

          thumbColor: WidgetStateProperty.all(Colors.white),

          trackColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primaryDark;
            }
            return AppColors.cardSecurityOne;
          }),

          trackOutlineColor: WidgetStateProperty.all(
            Colors.transparent,
          ),
        ),
      )
          : trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}

