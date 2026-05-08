import 'package:flutter/material.dart';
import 'package:tupay_app/core/theme/app_theme.dart';

import '../../../../../../../wallet/presentation/screen/wallet_detail_screen.dart';

class WalletSection extends StatelessWidget {
  const WalletSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🏷️ Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                "Wallets",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WalletDetailScreen(),
                    ),
                  );
                },
                child: Text(
                  "Manage",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        /// 💳 Horizontal Wallet Cards
        SizedBox(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            children: const [
              WalletCard(
                imagePath: "images/china.png",
                currency: "CNY",
                country: "CHINA",
                amount: "¥85,000",
              ),
              WalletCard(
                imagePath: "images/usa.png",
                currency: "USD",
                country: "UNITED STATES",
                amount: "\$12,450",
              ),

              WalletCard(
                imagePath: "images/usa.png",
                currency: "USD",
                country: "UNITED STATES",
                amount: "\$12,450",
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class WalletCard extends StatelessWidget {
  final String imagePath; // 👈 change from IconData
  final String currency;
  final String country;
  final String amount;

  const WalletCard({
    required this.imagePath,
    super.key,
    required this.currency,
    required this.country,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 20, bottom: 5.0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Image.asset(
                  imagePath,
                  height: 18,
                  width: 21,
                  fit: BoxFit.contain,
                ),

                const SizedBox(width: 5),

                Text(
                  currency,
                  style: TextStyle(
                    color: AppColors.balanceCardThree,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// 🌍 Currency Label
            Text(
              amount,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 18.0
              ),
            ),

            const SizedBox(height: 10),
            /// 💰 Amount
            Text(
              country,
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.balanceCardThree,
                fontWeight: FontWeight.normal,
                fontSize: 10.0
              ),
            ),
          ],
        ),
    );
  }
}