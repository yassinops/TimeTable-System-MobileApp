import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateService {
  final String host = "localhost:8080"; // Host and port combined
  final String path = "/student"; // Base path for student-related endpoints

  // Fetch user data
  Future<Map<String, dynamic>> fetchUserData(int userId) async {
    // Construct the URL using Uri.parse
    final Uri url = Uri.parse('http://$host$path/getprofile/$userId');

    print('Fetching user data from: $url'); // Debug log

    try {
      // Make the GET request
      final response = await http.get(url);

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> userData = json.decode(response.body);
        print('User data fetched successfully: $userData');
        return userData;
      } else {
        // Handle non-200 status codes
        print('Failed to fetch user data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Exception occurred while fetching user data: $e');
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
    // Construct the URL using Uri.parse
    final Uri url = Uri.parse('http://$host$path/modifyprofile/$userId');
    final body = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    });

    print('Updating user data at: $url'); // Debug log
    print('Request body: $body'); // Debug log

    try {
      // Make the PUT request
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        print('User data updated successfully');
        return true;
      } else {
        print('Failed to update user data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception occurred while updating user data: $e');
      return false;
    }
  }
}