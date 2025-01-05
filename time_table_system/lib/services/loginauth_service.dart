import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginauthService {
  final baseUrl = 'http://10.0.2.2:8081/api/v1/auth/authenticate';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print("user loged in successfully");
      final responseData = jsonDecode(response.body);
      return{
        'fullName':responseData['fullName'],
        'role':responseData['role'],
        'userId':responseData['userId'],
      };
    } else {
      throw Exception('failed to register:${response.body}');
    }
  }
}


