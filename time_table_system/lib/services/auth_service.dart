import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String host = "172.16.106.172:8080"; // Host and port
  final String path = "/api/v1/auth/register"; // API endpoint path

  // Register method
  Future<void> register(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    // Construct the URL using Uri.http
    final Uri url = Uri.http(host, path);

    try {
      // Make the POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
        }),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        print('User registered successfully');
      } else {
        // Handle non-200 status codes
        throw Exception(
            'Failed to register: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('Failed to register: $e');
    }
  }
}
