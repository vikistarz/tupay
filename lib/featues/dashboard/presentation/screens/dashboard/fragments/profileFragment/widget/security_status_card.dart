// lib/features/profile/presentation/widgets/security_status_card.dart
import 'package:flutter/material.dart';
import 'package:tupay_app/core/theme/app_theme.dart';


class SecurityStatusCard extends StatelessWidget {
  const SecurityStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.visualCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [

          Positioned(
            bottom: -15,
            right: -30,
            child: Opacity(
              opacity: 0.15,
              child: Icon(Icons.shield_outlined, color: Colors.white.withOpacity(0.3), size: 120),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 25.0),
                child: const Text(
                  'SECURITY STATUS',
                  style: TextStyle(color: AppColors.balanceCardThree, fontSize: 16,),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: const Text(
                  'Your account is',
                  style: TextStyle(color: AppColors.cardBackground, fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: const Text(
                  '85% Secured',
                  style: TextStyle(
                    color: AppColors.balanceCardFive,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 50),

             Padding(
               padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
               child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Review Security',
                        style: TextStyle(color: AppColors.transferSum, fontSize: 16,
                          fontWeight: FontWeight.normal,),
                      ),
                      const Icon(Icons.arrow_forward_outlined, color: AppColors.transferSum, size: 18),
                    ],
                  ),
             ),

              const SizedBox(height: 8),
            ],
          ),

        ],
      ),
    );
  }
}