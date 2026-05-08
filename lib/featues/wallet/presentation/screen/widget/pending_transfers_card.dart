// lib/features/wallet/presentation/widgets/pending_transfers_card.dart
import 'package:flutter/material.dart';
import 'package:tupay_app/core/theme/app_theme.dart';

class PendingTransfersCard extends StatelessWidget {
  const PendingTransfersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                'PENDING TRANSFERS',
                style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.pendingTrans, fontSize: 16.0),
              ),
              SizedBox(height: 4),
              Row(
                children: [


                  Icon(Icons.access_time_rounded,  color: AppColors.pendingTransTwo, size: 20),

                  SizedBox(width: 4),
                  Text(
                    '02',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text('Totaling \$1,200.00', style: TextStyle(color: AppColors.bottomNavDisabled)),
            ],
          ),
    );
  }
}