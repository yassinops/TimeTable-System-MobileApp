import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateService {
  final String host = "192.168.100.96:8080"; // Host and port
  final String path = "/student"; // Base path for student-related endpoints

  // Fetch user data
  Future<Map<String, dynamic>> fetchUserData(int userId) async {
    // Construct the URL using Uri.http
    final Uri url = Uri.http(host, "$path/getprofile/$userId");

    try {
      // Make the GET request
      final response = await http.get(url);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        // Handle non-200 status codes
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('Failed to fetch user data: $e');
    }
  }

  // Update user data
  Future<bool> updateStudent({
    required int userId,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    // Construct the URL using Uri.http
    final Uri url = Uri.http(host, "$path/modifyprofile/$userId");
    final body = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    });

    try {
      // Make the PUT request
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Check if the request was successful
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
