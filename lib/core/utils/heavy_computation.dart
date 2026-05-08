// lib/core/utils/heavy_computation.dart
import 'dart:isolate';

Future<List<dynamic>> processLargeTransactionData() async {
  return Isolate.run(() async {
    // Simulate 5MB JSON processing
    await Future.delayed(const Duration(milliseconds: 600));

    // Mock large dataset
    final List<Map<String, dynamic>> transactions = List.generate(5000, (index) {
      return {
        "id": "TXN_${DateTime.now().millisecondsSinceEpoch}_$index",
        "amount": (100 + index % 1000).toDouble(),
        "currency": index % 3 == 0 ? "USD" : "EUR",
        "status": index % 5 == 0 ? "FAILED" : "SUCCESS",
        "timestamp": DateTime.now().subtract(Duration(minutes: index)).toIso8601String(),
      };
    });

    // Heavy filtering
    final filtered = transactions.where((tx) =>
    tx['status'] == "SUCCESS" && tx['amount'] > 500
    ).toList();

    return filtered;
  });
}