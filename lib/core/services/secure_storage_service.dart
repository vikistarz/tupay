import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// lib/core/storage/secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  // Save sensitive data
  static Future<void> saveTransactionId(String id) async {
    await _storage.write(key: 'last_transaction_id', value: id);
  }

  // Read sensitive data
  static Future<String?> getTransactionId() async {
    return await _storage.read(key: 'last_transaction_id');
  }

  // Save auth token (example)
  static Future<void> saveAuthToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  static Future<String?> getAuthToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Delete all
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}