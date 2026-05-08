// lib/features/cards/presentation/widgets/card_information.dart
import 'package:flutter/material.dart';
import '../../../../../../../../core/theme/app_theme.dart';
import '../../../../../provider/card_provider.dart';


class CardInformation extends StatelessWidget {
  final VirtualCardSuccess cardData;

  const CardInformation({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CARD INFORMATION',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.recentCard),
            ),
            const SizedBox(height: 10),
            _infoRow('Cardholder Name', cardData.cardholder),
            _infoRow('Billing Address',
                '128 Innovation Way, Suite 400\nSan Francisco, CA 94105'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Image(
                  image: AssetImage('images/apple_pay.png'),
                  height: 20,
                  width: 20,
                ),
                label: const Text('Add to Apple Wallet'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}