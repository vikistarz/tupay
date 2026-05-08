// lib/features/transfer/presentation/widgets/recipient_details_section.dart
import 'package:flutter/material.dart';

import '../../../../../../../../core/theme/app_theme.dart';

class RecipientDetailsSection extends StatelessWidget {
  const RecipientDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: const Text(
                    'RECIPIENT DETAILS',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.recentCard),
                  ),
                ),
                const SizedBox(width: 70),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Select from contacts', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.primaryDark)),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
            child: TextField(
              keyboardType:TextInputType.name,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hint: Text("Full Name", style: TextStyle(color: AppColors.textSecondary, fontSize: 16.0),),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: const TextField(
              keyboardType:TextInputType.number,
              cursorColor: Colors.black,
              maxLength: 10,
              decoration: InputDecoration(
                hint: Text("IBAN / Account Number", style: TextStyle(color: AppColors.textSecondary, fontSize: 16.0),),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),

        ],
      ),
    );
  }
}