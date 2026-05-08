// lib/features/dashboard/providers/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'dart:isolate';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final double totalBalance;
  final List<Transaction> transactions;
  const HomeSuccess(this.totalBalance, this.transactions);
}
class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
}

class Transaction {
  final String title;
  final String subtitle;
  final String amount;
  final String status;
  final String time;

  Transaction({required this.title, required this.subtitle, required this.amount, required this.status, required this.time});
}

class HomeNotifier extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    return await loadHome();
  }

  Future<HomeState> loadHome() async {
    state = const AsyncLoading();

    try {
      final transactions = await computeHeavyJsonProcessing();

      final success = HomeSuccess(
        4850200.00,
        transactions,
      );

      state = AsyncData(success);
      return success;

    } catch (e, st) {
      state = AsyncError(e, st);
      return HomeError(e.toString());
    }
  }

  Future<void> refreshData() async {
    await loadHome();
  }
}

final homeProvider = AsyncNotifierProvider<HomeNotifier, HomeState>(
      () => HomeNotifier(),
);

// Background Isolate Example
Future<List<Transaction>> computeHeavyJsonProcessing() async {
  return Isolate.run(() async {
    // Mock heavy processing
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Transaction(title: "Wallet Funding", subtitle: "Via Bank Transfer • 2m ago", amount: "+₦250,000", status: "Success", time: "2m ago"),
      Transaction(title: "Transfer to John Doe", subtitle: "External Bank • 1h ago", amount: "-₦45,000", status: "Success", time: "1h ago"),
      Transaction(title: "Amazon.com", subtitle: "Virtual Card • Yesterday", amount: "-\$120.50", status: "Pending", time: "Yesterday"),
    ];
  });
}