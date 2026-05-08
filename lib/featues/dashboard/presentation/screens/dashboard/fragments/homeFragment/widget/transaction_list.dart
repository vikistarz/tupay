import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/theme/app_theme.dart';
import '../../../../../../data/transaction_model.dart';
import '../../../../../provider/homeProvider.dart';
class TransactionsSection extends StatelessWidget {
  final AsyncValue<HomeState> homeAsync;

  const TransactionsSection({
    super.key,
    required this.homeAsync,
  });

  @override
  Widget build(BuildContext context) {
    return homeAsync.when(
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),

      error: (err, _) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Center(child: Text('Error: $err')),
        ),
      ),

      data: (homeState) {
        if (homeState is HomeSuccess) {
          final transactions = homeState.transactions;

          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final tx = transactions[index];
                return _buildTransactionTile(tx);
              },
              childCount: transactions.length,
            ),
          );
        }

        return const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        );
      },
    );
  }


  Widget _buildTransactionTile(Transaction tx) {
    final isPositive = tx.amount.startsWith('+');
    final color = isPositive ? AppColors.transactionHistoryFive : AppColors.transactionHistoryFour;

    final colorIcon = isPositive ? AppColors.primaryDark : AppColors.textPrimary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getTransactionIcon(tx.title),
              color: colorIcon,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tx.subtitle,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Amount & Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                tx.amount,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: colorIcon,
                ),
              ),
              const SizedBox(height: 6),
              _buildStatusChip(tx.status),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getTransactionIcon(String title) {
    if (title.contains('Funding')) return Icons.account_balance;
    if (title.contains('Transfer')) return Icons.send;
    if (title.contains('Amazon')) return Icons.shopping_bag_outlined;
    return Icons.payment;
  }

  Widget _buildStatusChip(String status) {
    final isSuccess = status.toLowerCase() == 'success';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSuccess
            ? AppColors.transactionHistoryOne.withOpacity(0.15)
            : AppColors.transactionHistoryTwo,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isSuccess ? AppColors.primaryDark : AppColors.transactionHistoryThree,
        ),
      ),
    );
  }
}