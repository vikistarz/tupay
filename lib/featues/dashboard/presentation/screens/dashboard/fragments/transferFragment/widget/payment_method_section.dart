// lib/features/transfer/presentation/widgets/payment_method_section.dart
import 'package:flutter/material.dart';
import '../../../../../../../../core/theme/app_theme.dart';

class PaymentMethodSection extends StatelessWidget {
  final String selectedMethod; // e.g., "Tupay Balance"

  const PaymentMethodSection({
    super.key,
    this.selectedMethod = 'Tupay Balance',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: const Text('PAYMENT METHOD', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.recentCard),),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.only(right:20.0, left: 20.0),
            child: _buildPaymentOption(
              imagePath: "images/account.png",
              title: 'Tupay Balance',
              subtitle: '\$12,450.00 available',
                isSelected: selectedMethod == 'Tupay Balance',
              context: context
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right:20.0, left: 20.0),
            child: _buildPaymentOption(
              imagePath: "images/play.png",
              title: 'Apple Pay',
              subtitle: 'Instant processing', context: context,
              isSelected: selectedMethod == 'Apple Pay',
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right:20.0, left: 20.0, bottom: 20.0),
            child: _buildPaymentOption(
              imagePath: "images/ios_icon.png",
              title: 'Google Pay',
              subtitle: 'Secure checkout', context: context,
              isSelected: selectedMethod == 'Google Pay',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String imagePath,
    required String title,
    required String subtitle,
    required BuildContext context,
    bool isSelected = false,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppColors.primaryDark : AppColors.transfer_stepperTwo,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? AppColors.paymentMeth.withOpacity(0.1)  : AppColors.cardBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20.0),
          child: Image.asset(
          imagePath,
          height: 20,
          width: 20,
          fit: BoxFit.contain,
          ),
        ),

      const SizedBox(height: 5),

      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary),),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 20.0, bottom: 20.0),
        child: Text(subtitle, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? AppColors.primaryDark : AppColors.recentCard),),
      ),

        ],
      ),
    );
  }
}