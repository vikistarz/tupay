// lib/features/wallet/presentation/widgets/wallet_balance_card.dart
import 'package:flutter/material.dart';
import 'package:tupay_app/core/theme/app_theme.dart';

import '../../provider/wallet_detail_provider.dart';


class WalletBalanceCard extends StatelessWidget {
  final String currency;
  final WalletDetailSuccess data;

  const WalletBalanceCard({
    super.key,
    required this.currency,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(27),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1F2E), Color(0xFF0F1629)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [

          Positioned(
            bottom: 15,
            right: 30,
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'images/dollars.png',
                height: 106,
                width: 106,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Total $currency Balance',
                    style: const TextStyle(
                      color: AppColors.balanceCardThree,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(
                    currency == 'USD'
                        ? '\$ ${data.balance.toStringAsFixed(2)}'
                        : '¥${data.balance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.normal,
                      letterSpacing: -1,
                    ),
                  ),
                ),


                // Exchange Rate Banner
                Container(
                  margin: EdgeInsets.only(right: 30.0, left: 20.0, bottom: 25.0, top: 5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/trade_arrow.png',
                        height: 8,
                        width: 12,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '1 $currency = ${data.exchangeRate.toStringAsFixed(2)} NGN',
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '+0.2%',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}