// lib/features/transfer/providers/transfer_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';



// lib/features/transfer/providers/transfer_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

sealed class TransferState {}

class TransferSuccess extends TransferState {
  final double sendAmount;
  final double receiveAmount;
  final String fromCurrency;
  final String toCurrency;
  final double rate;
  final double fee;
  final String? errorMessage;

  TransferSuccess({
    this.sendAmount = 0.0,
    this.receiveAmount = 0.0,
    this.fromCurrency = 'USD',
    this.toCurrency = 'EUR',
    this.rate = 0.9245,
    this.fee = 4.50,
    this.errorMessage,
  });

  TransferSuccess copyWithNewAmount(double newSendAmount, {String? error}) {
    // Only update amount if valid, otherwise keep previous valid amount
    final isValid = newSendAmount > 0 && newSendAmount <= 12450.00;
    return TransferSuccess(
      sendAmount: isValid ? newSendAmount : sendAmount,
      receiveAmount: isValid ? newSendAmount * rate : receiveAmount,
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      rate: rate,
      fee: fee,
      errorMessage: error,
    );
  }
}

class TransferNotifier extends AsyncNotifier<TransferState> {
  final double _tupayBalance = 12450.00;

  @override
  Future<TransferState> build() async => TransferSuccess();

  void updateSendAmount(double newAmount) {
    final current = state.value is TransferSuccess
        ? state.value as TransferSuccess
        : TransferSuccess();

    String? error;

    if (newAmount > _tupayBalance) {
      error = 'Insufficient balance. You have \$${_tupayBalance.toStringAsFixed(2)} available.';
    } else if (newAmount <= 0) {
      error = 'Please enter a valid amount';
    }

    state = AsyncData(
      current.copyWithNewAmount(newAmount, error: error),
    );
  }
}

final transferProvider = AsyncNotifierProvider<TransferNotifier, TransferState>(
      () => TransferNotifier(),
);
