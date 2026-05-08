import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../featues/dashboard/presentation/screens/dashboard/fragments/homeFragment/widget/balance_card.dart';


void main() {
  testWidgets('BalanceCard golden test', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BalanceCard(
            isVisible: true,
            onVisibilityToggle: () {},
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(BalanceCard),
      matchesGoldenFile('goldens/balance_card.png'),
    );
  });
}