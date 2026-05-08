// lib/features/wallet/presentation/widgets/spending_trend_chart.dart
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class SpendingTrendChart extends StatelessWidget {
  const SpendingTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const Text('Spending Trend', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary)),

              Expanded(child: SizedBox()),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: AppColors.chartOne,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text('Last 7 Days', style: TextStyle(fontSize: 13)),

                    Icon(Icons.keyboard_arrow_down_sharp, size: 15.0,),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 190,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(50,AppColors.chartOne, 'Mon'),
                _buildBar(70, AppColors.chartOne, 'Tue'),
                _buildBar(130, AppColors.primary, 'Wed'),
                _buildBar(95, AppColors.chartOne, 'Thu'),
                _buildBar(65, AppColors.primary, 'Fri'),
                _buildBar(110, AppColors.chartOne, 'Sat'),
                _buildBar(150, AppColors.textPrimary, 'Sun'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double height, Color color, String day) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 36,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}