import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<http.Response> makeRequest(
    Uri url, {
    required String method,
    Map<String, dynamic>? body,
  }) async {
    try {
      late http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(url);
          break;
        case 'POST':
          response = await http.post(url, body: jsonEncode(body));
          break;
        case 'DELETE':
          response = await http.delete(url, body: jsonEncode(body));
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      return response;
    } catch (e) {
      throw Exception('Network request failed: $e');
    }
  }
}
