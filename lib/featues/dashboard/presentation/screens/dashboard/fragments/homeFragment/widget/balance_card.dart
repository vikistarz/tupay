import 'package:flutter/material.dart';

import '../../../../../../../../core/theme/app_theme.dart';

class BalanceHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;
  final bool isVisible;
  final VoidCallback onVisibilityToggle;

  BalanceHeaderDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.isVisible,
    required this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BalanceCard(
      isVisible: isVisible,
      onVisibilityToggle: onVisibilityToggle,
    );
  }

  @override
  double get maxExtent => maxHeight;
  @override
  double get minExtent => minHeight;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}




class BalanceCard extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onVisibilityToggle;

  const BalanceCard({
    super.key,
    required this.isVisible,
    required this.onVisibilityToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 25, 20, 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.balanceCardOne,
            AppColors.balanceCardTwo,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            height: 5.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL BALANCE',
                style: TextStyle(
                  color: AppColors.balanceCardThree,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: onVisibilityToggle,
                child: Icon(
                  isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: AppColors.cardBackground,
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Amount
          Text(
            isVisible ? '₦ 4,850,200.00' : '••••••••••',
            style: const TextStyle(
              color: AppColors.cardBackground,
              fontSize: 32,
              fontWeight: FontWeight.normal,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),

          // Growth
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.balanceCardFour.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: const Row(
                  children: [

                    SizedBox(width: 7),
                    Text(
                      '+2.4%',
                      style: TextStyle(
                        color: AppColors.balanceCardFive,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),

                    SizedBox(width: 7),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'vs last month',
                style: TextStyle(color: AppColors.balanceCardThree, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


