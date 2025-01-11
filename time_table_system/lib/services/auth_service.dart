import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String host = "localhost:8080"; // Host and port combined
  final String path = "/api/v1/auth/register"; // API endpoint path

  // Register method
  Future<void> register(
      String firstName,
      String lastName,
      String email,
      String password,
      ) async {
    // Construct the URL using Uri.parse
    final Uri url = Uri.parse('http://$host$path');

    print('Registering user at: $url'); // Debug log

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
        print('Failed to register. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to register: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Exception occurred during registration: $e');
      throw Exception('Failed to register: $e');
    }
  }
}