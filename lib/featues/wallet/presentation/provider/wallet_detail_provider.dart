// lib/features/wallet/providers/wallet_detail_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

sealed class WalletDetailState {}

class WalletDetailInitial extends WalletDetailState {}
class WalletDetailLoading extends WalletDetailState {}
class WalletDetailSuccess extends WalletDetailState {
  final double balance;
  final double exchangeRate;
  final List<WalletTransaction> recentTransactions;

  WalletDetailSuccess({
    required this.balance,
    required this.exchangeRate,
    required this.recentTransactions,
  });
}
class WalletDetailError extends WalletDetailState {
  final String message;
  WalletDetailError(this.message);
}

class WalletTransaction {
  final String title;
  final String subtitle;
  final String amount;
  final String status;
  final String time;

  WalletTransaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
    required this.time,
  });
}

class WalletDetailNotifier extends AsyncNotifier<WalletDetailState> {
  @override
  Future<WalletDetailState> build() async {
    return WalletDetailInitial();
  }

  Future<void> loadWalletData(String currency) async {
    state = AsyncData(WalletDetailLoading());

    try {
      // Simulate API call + heavy processing
      await Future.delayed(const Duration(milliseconds: 1200));

      final transactions = [
        WalletTransaction(
          title: "Amazon.com Seattle",
          subtitle: "Oct 24, 2023 • 2:45 PM",
          amount: "-\$124.99",
          status: "COMPLETED",
          time: "Oct 24, 2023",
        ),
        WalletTransaction(
          title: "Deposit from NGN Wallet",
          subtitle: "Oct 22, 2023 • 11:15 AM",
          amount: "+\$2,500.00",
          status: "COMPLETED",
          time: "Oct 22, 2023",
        ),
        WalletTransaction(
          title: "DigitalOcean Cloud Svcs",
          subtitle: "Oct 20, 2023 • 09:00 AM",
          amount: "-\$45.00",
          status: "PENDING",
          time: "Oct 20, 2023",
        ),
        WalletTransaction(
          title: 'Stripe Payout - Project X',
          subtitle: 'Oct 18, 2023 • 4:20 PM',
          amount: '+\$1,420.00',
          status: 'COMPLETED',
          time: 'Oct 18, 2023 • 4:20 PM',
        ),
      ];

      state = AsyncData(WalletDetailSuccess(
        balance: 12450.80,
        exchangeRate: 1485.50,
        recentTransactions: transactions,
      ));
    } catch (e) {
      state = AsyncData(WalletDetailError(e.toString()));
    }
  }
}

final walletDetailProvider = AsyncNotifierProvider<WalletDetailNotifier, WalletDetailState>(
      () => WalletDetailNotifier(),
);