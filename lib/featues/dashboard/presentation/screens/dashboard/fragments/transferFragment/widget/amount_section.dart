// lib/features/transfer/presentation/widgets/amount_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../../core/theme/app_theme.dart';
import '../../../../../provider/transfer_provider.dart';


class AmountSection extends StatefulWidget {
  final AsyncValue<TransferState> transferState;
  final Function(double) onAmountChanged;

  const AmountSection({
    super.key,
    required this.transferState,
    required this.onAmountChanged,
  });

  @override
  State<AmountSection> createState() => _AmountSectionState();
}

class _AmountSectionState extends State<AmountSection> {
  late TextEditingController _controller;


  @override
  void initState() {
    super.initState();
    final data = _getCurrentData();
    _controller = TextEditingController(text: data.sendAmount.toStringAsFixed(0));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TransferSuccess _getCurrentData() {
    return widget.transferState.value is TransferSuccess
        ? widget.transferState.value as TransferSuccess
        : TransferSuccess(errorMessage: null);
  }

  @override
  Widget build(BuildContext context) {
    final data = _getCurrentData();

    return Card(
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How much are you sending?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Real-time market rates with zero hidden spreads.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),

            // You Send
            const Text('You Send', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _buildEditableAmountField(data),

            // After _buildEditableAmountField(data),

            if (data.errorMessage != null && data.errorMessage!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Text(
                  data.errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // Recipient Gets
            const Text('Recipient Gets', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _buildReadOnlyAmountField(data),



            const SizedBox(height: 16),

            Container(
              margin:  const EdgeInsets.only( bottom: 20.0),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.transfer_stepperOne,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      const SizedBox(width: 5),

                      Image.asset(
                        'images/trade_arrow.png',
                        height: 8,
                        width: 12,
                        fit: BoxFit.cover,
                      ),

                      const SizedBox(width: 7),

                      Expanded(child: Text('Rate: 1 USD = ${data.rate} EUR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.recentCard),),),

                      const SizedBox(width: 30),
                      Expanded(child: const Text('Guaranteed for 2h', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.primaryDark),),)
                    ],
                  ),
                  const SizedBox(height: 8),

                  Divider(
                    color: AppColors.cardBackground,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Transparent Fee', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.recentCard),),
                      Text('\$${data.fee} USD', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.recentCard),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableAmountField(TransferSuccess data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
                child: TextFormField(
                  controller: _controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    // REMOVE ALL BORDERS
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    counterText: '',
                    contentPadding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                  ),
                  onChanged: (value) {
                    final amount = double.tryParse(value.replaceAll(',', '')) ?? 0.0;
                    widget.onAmountChanged(amount);

                    // Optional: Clear error when user starts typing valid amount
                    if (amount > 0 && amount <= 12450) {
                      // You can call clearError if you add it in notifier
                    }
                  },
                ),
              ),


          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.transfer_stepperOne,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.transfer_stepperTwo),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🇺🇸', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary)),
                SizedBox(width: 8),
                Text('USD', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary)),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildReadOnlyAmountField(TransferSuccess data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              data.receiveAmount.toStringAsFixed(2),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.transfer_stepperOne,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.transfer_stepperTwo),
            ),
            child: Row(
              children: [
                const Text('🇪🇺', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary)),
                const SizedBox(width: 8),
                const Text('EUR', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.textPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
