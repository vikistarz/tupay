// lib/features/cards/providers/virtual_card_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

sealed class VirtualCardState {}

class VirtualCardInitial extends VirtualCardState {}
class VirtualCardLoading extends VirtualCardState {}
class VirtualCardSuccess extends VirtualCardState {
  final bool isActive;
  final String cardNumber;
  final String cardholder;
  final String expiry;
  final List<CardTransaction> recentTransactions;

  VirtualCardSuccess({
    this.isActive = true,
    this.cardNumber = "•••• •••• •••• 8842",
    this.cardholder = "Alexander Roland",
    this.expiry = "09 / 27",
    required this.recentTransactions,
  });
}
class VirtualCardError extends VirtualCardState {
  final String message;
  VirtualCardError(this.message);
}

class CardTransaction {
  final String title;
  final String subtitle;
  final String amount;
  final String status;
  final String date;

  CardTransaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
    required this.date,
  });
}

class VirtualCardNotifier extends AsyncNotifier<VirtualCardState> {
  @override
  Future<VirtualCardState> build() async => VirtualCardInitial();

  Future<void> loadCardData() async {
    state = AsyncData(VirtualCardLoading());
    await Future.delayed(const Duration(milliseconds: 800));

    state = AsyncData(VirtualCardSuccess(
      recentTransactions: [
        CardTransaction(
          title: "Apple Services",
          subtitle: "Subscription",
          amount: "-\$14.99",
          status: "Completed",
          date: "Oct 24",
        ),
        CardTransaction(
          title: "Blue Bottle Coffee",
          subtitle: "Dining",
          amount: "-\$8.50",
          status: "Completed",
          date: "Oct 22",
        ),
        CardTransaction(
          title: "Card Top-up",
          subtitle: "Transfer",
          amount: "+\$500.00",
          status: "Completed",
          date: "Oct 20",
        ),
      ],
    ));
  }

  Future<void> toggleFreeze(bool value) async {
    // Mock API call
    await Future.delayed(const Duration(milliseconds: 300));
    // You can update state here if needed
  }
}

final virtualCardProvider = AsyncNotifierProvider<VirtualCardNotifier, VirtualCardState>(
      () => VirtualCardNotifier(),
);