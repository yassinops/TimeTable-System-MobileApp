import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://10.0.2.2:8081/api/v1/auth/register';
  

  Future<void> register(
      String firstName, String lastName, String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('user registered successfully');
    } else {
      throw Exception('failed to register: ${response.body}');
    }
  }
}
