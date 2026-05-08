import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Currency conversion calculation', () {
    const rate = 0.9245;
    const send = 1000.0;
    final receive = send * rate;

    expect(receive, closeTo(924.5, 0.1));
  });

  test('Currency conversion with different rate', () {
    const rate = 1485.50; // NGN per USD
    const send = 500.0;
    final receive = send * rate;

    expect(receive, equals(742750.0));
  });

  test('Should handle zero amount', () {
    const rate = 0.9245;
    const send = 0.0;
    final receive = send * rate;

    expect(receive, equals(0.0));
  });
}