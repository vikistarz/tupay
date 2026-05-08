// lib/features/transfer/presentation/widgets/transfer_stepper.dart
import 'package:flutter/material.dart';

import '../../../../../../../../core/theme/app_theme.dart';


class TransferStepper extends StatelessWidget {
  final int currentStep;
  final Function(int)? onStepTap;

  const TransferStepper({
    super.key,
    required this.currentStep,
    this.onStepTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

          /// 💳 Horizontal Wallet Cards
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              children: [

                _buildStep(
                  1,
                  'Amount',
                  isActive: currentStep == 1,
                ),

                _buildConnector(currentStep > 1),

                const SizedBox(width: 25),

                _buildStep(
                  2,
                  'Recipient',
                  isActive: currentStep == 2,
                ),

                const SizedBox(width: 25),

                _buildConnector(currentStep > 2),

                _buildStep(
                  3,
                  'Review',
                  isActive: currentStep == 3,
                ),
              ],
            ),
          ),

        ],
    );
  }

  Widget _buildStep(
      int number,
      String label, {
        required bool isActive,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onStepTap?.call(number),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.primaryDark
                  : AppColors.cardBackground,
              border: isActive ?   Border.all(color: AppColors.primaryDark) : Border.all(color: AppColors.transfer_stepper, width: 2.0)

            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyle(
                  color: isActive
                      ? AppColors.cardBackground
                      : AppColors.transfer_stepper,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 7),

          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive
                  ? FontWeight.w600
                  : FontWeight.normal,
              color: isActive
                  ? AppColors.primaryDark
                  : AppColors.transfer_stepper,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnector(bool isActive) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 2,
        color: isActive
            ? AppColors.primaryDark
            : Colors.grey.shade300,
      ),
    );
  }
}