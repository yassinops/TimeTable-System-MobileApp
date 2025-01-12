import 'dart:convert';
import 'package:http/http.dart' as http;

import '../UserResponse.dart';

class UpdateService {
  final String host = "localhost:8080"; // Replace with your backend host
  final String path = "/student"; // Replace with your backend base path
  final String pathGetProfile = "/admin";
  // Fetch user data
  Future<UserResponse> fetchUserData(int userId) async {
    final Uri url = Uri.parse('http://$host$pathGetProfile/getprofile/$userId');

    print('Fetching user data from: $url');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        print('User data fetched successfully: $userData');
        return UserResponse.fromJson(userData);
      } else {
        print('Failed to fetch user data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
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
    final Uri url = Uri.parse('http://$host$path/modifyprofile/$userId');
    final body = jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    });

    print('Updating user data at: $url');
    print('Request body: $body');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

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