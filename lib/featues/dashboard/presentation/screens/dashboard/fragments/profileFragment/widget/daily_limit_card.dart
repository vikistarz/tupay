// lib/features/profile/presentation/widgets/daily_limit_card.dart
import 'package:flutter/material.dart';
import '../../../../../../../../core/theme/app_theme.dart';


class DailyLimitCard extends StatelessWidget {
  const DailyLimitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: AppColors.textPrimary.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.paymentMeth.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.trending_up, color: AppColors.primaryDark, size: 18.0,),
                  ),
                  Expanded(child: SizedBox()),

                  const Text(
                    'Daily Limit',
                    style: TextStyle(fontSize: 16, color: AppColors.recentCard),
                  ),
                ],
          ),
          const SizedBox(height: 16),
          const Text(
            '\$10,000.00',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
          ),
          Text(
            'Remaining: \$4,250.00',
            style: TextStyle(color: AppColors.transfer_stepper, fontSize: 16,),
          ),
          const SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.575, // 5750/10000
              minHeight: 8,
              backgroundColor: AppColors.transactionHistoryTwo,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
            ),
          ),
        ],
      ),
    );
  }
}