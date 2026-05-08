// lib/features/cards/presentation/widgets/virtual_card_widget.dart
import 'package:flutter/material.dart';
import '../../../../../../../../core/theme/app_theme.dart';
import '../../../../../provider/card_provider.dart';


class VirtualCardWidget extends StatelessWidget {
  final VirtualCardSuccess cardData;

  const VirtualCardWidget({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.visualCard, AppColors.visualCardOne],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.25),
            blurRadius: 50,
            offset: const Offset(0, 25),
            spreadRadius: -12,
          ),
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'VIRTUAL PLATINUM',
                        style: TextStyle(color: AppColors.balanceCardThree, fontSize: 15, fontWeight: FontWeight.normal),
                      ),

                      Expanded(child: SizedBox()),


                      Padding(
                        padding: const EdgeInsets.only(right: 0.0, top: 10.0),
                        child: Stack(
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Icon(Icons.circle, size: 20.0, color: AppColors.textSecondary,),
                            ),

                            Icon(Icons.circle, size: 20.0, color: AppColors.transactionHistoryTwo,),

                          ],
                        ),
                      ),
                    ],
                  ),

                  Text(
                    'USD Card',
                    style: TextStyle(color: AppColors.balanceCardFive, fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                ],
              ),

          const SizedBox(height: 10),
          Text(
            cardData.cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CARD HOLDER', style: TextStyle(color: AppColors.balanceCardThree, fontSize: 15)),

                  SizedBox(
                    height: 3.0,
                  ),

                  Text(
                    cardData.cardholder,
                    style: const TextStyle(color: AppColors.cardBackground, fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('EXPIRES', style: TextStyle(color: AppColors.balanceCardThree, fontSize: 15)),

                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    cardData.expiry,
                    style: const TextStyle(color: AppColors.cardBackground, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}