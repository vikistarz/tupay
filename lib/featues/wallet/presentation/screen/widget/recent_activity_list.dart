// lib/features/wallet/presentation/widgets/recent_activity_list.dart
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../provider/wallet_detail_provider.dart';


class RecentActivityList extends StatelessWidget {
  final List<WalletTransaction> transactions;

  const RecentActivityList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final isPositive = tx.amount.startsWith('+');

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.recentAct,
                child: Icon(
                  _getIcon(tx.title),
                  color: AppColors.transactionHistoryThree,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tx.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(tx.subtitle, style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    tx.amount,
                    style: TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 16.0,
                      color: isPositive ? AppColors.primaryDark : AppColors.recentActTwo,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildStatusChip(tx.status),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Amazon')) return Icons.shopping_bag_outlined;
    if (title.contains('Deposit')) return Icons.arrow_downward;
    if (title.contains('DigitalOcean')) return Icons.language;
    if (title.contains('Stripe Payout - Project X')) return Icons.payments_outlined;
    return Icons.payment;
  }

  Widget _buildStatusChip(String status) {
    final isCompleted = status == 'COMPLETED';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.recentActThree.withOpacity(0.10) : AppColors.recentActFour,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isCompleted ? AppColors.primaryDark: AppColors.pendingTransTwo,
        ),
      ),
    );
  }
}