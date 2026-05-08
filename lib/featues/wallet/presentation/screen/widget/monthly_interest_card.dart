// lib/features/wallet/presentation/widgets/monthly_interest_card.dart
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';


class MonthlyInterestCard extends StatelessWidget {
  const MonthlyInterestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE6F9F2),
        borderRadius: BorderRadius.circular(20),
      ),
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MONTHLY INTEREST',
                style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.primaryDark, fontSize: 16.0),
              ),
              const SizedBox(height: 4),

              Row(
                children: [

                  Image.asset(
                    "images/piggy.png",
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),

                  SizedBox(width: 5,),

                  const Text(
                    '\$42.15',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.primaryDark,),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),

              const Text('APY: 4.5% Fixed', style: TextStyle(fontSize: 12, color: AppColors.primaryDark,)),
            ],
          ),
    );
  }
}