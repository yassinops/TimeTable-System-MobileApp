import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateService {
  final baseUrl = "http://10.0.2.2:8081/student";

  Future<bool> updateStudent({
    required int userId,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/modifyprofile/$userId');
    final body = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    });
    

    try {
      final response = await http.put(url,
          headers: {'Content-Type': 'application/json'}, body: body);
           if (response.statusCode == 200) {
        return true; 
      } else {
        print('Error: ${response.body}');
        return false; 
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
