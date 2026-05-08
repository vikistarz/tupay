// lib/features/cards/presentation/widgets/recent_card_transactions.dart
import 'package:flutter/material.dart';

import '../../../../../../../../core/theme/app_theme.dart';
import '../../../../../provider/card_provider.dart';


class RecentCardTransactions extends StatelessWidget {
  final List<CardTransaction> transactions;

  const RecentCardTransactions({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final isCredit = tx.amount.startsWith('+');

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.transactionHistoryTwo,
                child: Icon(
                  _getIcon(tx.title),
                  color: AppColors.recentCard,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tx.title, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0, color: AppColors.textPrimary)),
                    Text('${tx.date} • ${tx.subtitle}',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    tx.amount,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: isCredit ? AppColors.primaryDark : AppColors.recentActTwo,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tx.status,
                    style: const TextStyle(color: AppColors.primaryDark, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getIcon(String title) {
    if (title.contains('Apple')) return Icons.shopping_bag_outlined;
    if (title.contains('Coffee')) return Icons.restaurant;
    if (title.contains('Top-up')) return Icons.account_balance_wallet_outlined;
    return Icons.payment;
  }
}