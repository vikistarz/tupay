import 'dart:isolate';
import 'dart:convert';

class IsolateService {
  static Future<List<dynamic>> parseLargeJson(String json) async {
    return await Isolate.run(() {
      final decoded = jsonDecode(json);
      return decoded;
    });
  }
}