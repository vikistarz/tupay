// lib/features/wallet/presentation/wallet_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/featues/wallet/presentation/screen/widget/action_buttons_row.dart';
import 'package:tupay_app/featues/wallet/presentation/screen/widget/monthly_interest_card.dart';
import 'package:tupay_app/featues/wallet/presentation/screen/widget/pending_transfers_card.dart';
import 'package:tupay_app/featues/wallet/presentation/screen/widget/recent_activity_list.dart';
import 'package:tupay_app/featues/wallet/presentation/screen/widget/spending_trend_chart.dart';
import 'package:tupay_app/featues/wallet/presentation/screen/widget/wallet_balance_card.dart';

import '../../../../core/theme/app_theme.dart';
import '../provider/wallet_detail_provider.dart';


class WalletDetailScreen extends ConsumerStatefulWidget {
  final String currency;

  const WalletDetailScreen({super.key, this.currency = 'USD'});

  @override
  ConsumerState<WalletDetailScreen> createState() => _WalletDetailScreenState();
}

class _WalletDetailScreenState extends ConsumerState<WalletDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Load wallet data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(walletDetailProvider.notifier).loadWalletData(widget.currency);
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletState = ref.watch(walletDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.currency} Wallet', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 32.0,),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150?img=3",
              ),
            ),
          ),
        ],
      ),
      body: walletState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (state) {
          if (state is WalletDetailSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WalletBalanceCard(currency: widget.currency, data: state),
                  const SizedBox(height: 40),
                  const ActionButtonsRow(),
                  const SizedBox(height: 32),
                  const SpendingTrendChart(),
                  const SizedBox(height: 32),
                  const MonthlyInterestCard(),
                  const SizedBox(height: 24),
                  const PendingTransfersCard(),
                  const SizedBox(height: 32),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Recent USD Activity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary)),
                          const Text('Filtered by USD Wallet', style: TextStyle(color: AppColors.textSecondary, fontSize: 12.0)),
                        ],
                      ),

                      Expanded(child: SizedBox()),

                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Text('View All', style: TextStyle(color: AppColors.primaryDark, fontSize: 16.0)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RecentActivityList(transactions: state.recentTransactions),
                ],
              ),
            );
          }
          return const Center(child: Text(''));
        },
      ),
    );
  }
}