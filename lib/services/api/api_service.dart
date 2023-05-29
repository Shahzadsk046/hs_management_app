import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api';

  // Helper method to handle HTTP requests
  Future<dynamic> _handleRequest(http.Response response) async {
    final body = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      print("API Service 12");
      print(body);
      return body;
    } else {
      throw body['message'] ?? 'Request failed';
    }
  }

  // GET request
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return _handleRequest(response);
  }

  // POST request
  Future<dynamic> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    print("I'm in API Service 32");
    print(endpoint);
    print("I'm in API Service 34");
    print(data);
    return _handleRequest(response);
  }

  // PUT request
  Future<dynamic> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return _handleRequest(response);
  }

  // DELETE request
  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));
    return _handleRequest(response);
  }
}
