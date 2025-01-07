import 'dart:convert';
import 'package:http/http.dart' as http;

class TimetableService {
  final String host = "172.16.106.172:8080"; // Host and port
  final String path = "/timetables"; // API endpoint path

  // Fetch timetable data
  Future<List<Map<String, dynamic>>> fetchTimetable(int classId) async {
    // Construct the URL using Uri.http
    final Uri url = Uri.http(host, "$path/$classId");

    print('Fetching timetable from: $url'); // Debugging

    try {
      // Make the GET request
      final response = await http.get(url);

      print('Response status code: ${response.statusCode}'); 
      print('Response body: ${response.body}'); 

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        // Handle non-200 status codes
        throw Exception('Failed to load timetable: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      print('Error fetching timetable: $e'); // Debugging
      throw Exception('Failed to fetch timetable: $e');
    }
  }
}
