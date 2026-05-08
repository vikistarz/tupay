// lib/features/transfer/presentation/widgets/transfer_summary.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/core/theme/app_theme.dart';
import '../../../../../provider/transfer_provider.dart';

class TransferSummary extends StatelessWidget {
  final AsyncValue<TransferState> transferState;

  const TransferSummary({super.key, required this.transferState});

  @override
  Widget build(BuildContext context) {
    final data = transferState.value is TransferSuccess
        ? transferState.value as TransferSuccess
        : TransferSuccess(errorMessage: null);

    final hasError = data.errorMessage != null && data.errorMessage!.isNotEmpty;
    final totalToPay = data.sendAmount + data.fee;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Transfer Summary',
              style: TextStyle(color: AppColors.cardBackground, fontSize: 16, fontWeight: FontWeight.normal)),
          
          Divider(
            color: AppColors.transferSum,height: 32
          ),

          const SizedBox(height: 16),


          _summaryRow('Sending', '${data.sendAmount.toStringAsFixed(2)} USD'),
          _summaryRow('Fees', '${data.fee.toStringAsFixed(2)} USD', isGreen: true),
          _summaryRow('Estimated Arrival', 'Today, ~15 mins'),

          Divider(
            color: AppColors.transferSum,height: 32
          ),

          const Text('TOTAL TO PAY', style: TextStyle(color: AppColors.balanceCardThree, fontSize: 16.0)),
          Text(
              '${totalToPay.toStringAsFixed(2)} USD',
            style: const TextStyle(color: AppColors.cardBackground, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: hasError ? null : () {
                // Proceed to next step (Review & Send)
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(hasError ? 'INSUFFICIENT BALANCE' : 'REVIEW & SEND',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: hasError ? AppColors.recentActTwo : AppColors.cardBackground)),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.balanceCardThree, fontSize: 16.0),),
          Text(
            value,
            style: TextStyle(
              color: isGreen ? AppColors.paymentMeth  : AppColors.cardBackground,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}