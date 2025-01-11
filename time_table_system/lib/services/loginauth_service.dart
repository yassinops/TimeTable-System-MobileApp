import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginauthService {
  final String host = "localhost"; // Host only
  final int port = 8080; // Port separately
  final String path = "/api/v1/auth/authenticate"; // API endpoint path

  // Login method
  Future<Map<String, dynamic>> login(String email, String password) async {
    // Construct the URL using Uri.http
    final Uri url = Uri.http('$host:$port', path);

    print('Logging in at: $url'); // Debug log

    try {
      // Make the POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        print("User logged in successfully");
        // Parse the JSON response
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Login response data: $responseData'); // Debug log

        // Extract user role
        final String role = responseData['role'];

        // Declare variables for classId and departmentId
        int? classId;
        int? departmentId;

        // Assign values based on the role
        if (role == 'STUDENT') {
          classId = responseData['classId']; // Assuming 'classId' is returned for students
        } else if (role == 'TEACHER') {
          departmentId = responseData['departmentId']; // Assuming 'departmentId' is returned for teachers
        }

        // Return the user data along with classId or departmentId
        return {
          'fullName': responseData['fullName'],
          'role': role,
          'userId': responseData['userId'],
          'classId': classId,
          'departmentId': departmentId,
        };
      } else {
        // Handle non-200 status codes
        print('Failed to login. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception(
            'Failed to login: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Exception occurred while logging in: $e');
      throw Exception('Failed to login: $e');
    }
  }
}