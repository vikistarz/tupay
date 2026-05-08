import 'package:flutter/material.dart';


// lib/features/transfer/presentation/transfer_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/transferFragment/widget/amount_section.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/transferFragment/widget/payment_method_section.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/transferFragment/widget/recipient_details_section.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/transferFragment/widget/transfer_stepper.dart';
import 'package:tupay_app/featues/dashboard/presentation/screens/dashboard/fragments/transferFragment/widget/transfer_summary.dart';

import '../../../../../../../core/theme/app_theme.dart';
import '../../../../provider/transfer_provider.dart';


class TransferFragment extends ConsumerStatefulWidget {
  const TransferFragment({super.key});

  @override
  ConsumerState<TransferFragment> createState() => _TransferFragmentState();
}

class _TransferFragmentState extends ConsumerState<TransferFragment> with RestorationMixin {
  int currentStep = 1;
  final RestorableDouble _sendAmount = RestorableDouble(1000.0);

  @override
  String? get restorationId => 'transfer_screen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_sendAmount, 'send_amount');
  }

  @override
  void dispose() {
    _sendAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transferState = ref.watch(transferProvider);

    // Update provider when restored value changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_sendAmount.value != 1000.0) {
        ref.read(transferProvider.notifier).updateSendAmount(_sendAmount.value);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150?img=3",
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Tupay",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TransferStepper(
              currentStep: currentStep,
              onStepTap: (step) {
                setState(() {
                  currentStep = step;
                });
              },
            ),
            const SizedBox(height: 22),

            AmountSection(
              transferState: transferState,
              onAmountChanged: (newAmount) {
                ref.read(transferProvider.notifier).updateSendAmount(newAmount);
              },
            ),
            const SizedBox(height: 32),

            const PaymentMethodSection(),
            const SizedBox(height: 22),


            const RecipientDetailsSection(),
            const SizedBox(height: 32),

            TransferSummary(transferState: transferState),
            const SizedBox(height: 24),

            // Encryption Note
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.transfer_stepperTwo.withOpacity(0.3),
                    width:  1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.transfer_stepperOne.withOpacity(0.5)
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user, color: AppColors.primaryDark, size: 22.0,),
                  const SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End-to-End Encryption',
                          style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                        ),

                        Text(
                          'our transaction is protected by bank-grade security protocols.',
                          style: TextStyle(fontSize: 13,  color: AppColors.recentCard),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),

    );
  }
}