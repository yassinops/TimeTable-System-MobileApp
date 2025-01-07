import 'dart:convert';
import 'package:http/http.dart' as http;

class TimetableService {
  final String baseUrl ="http://10.0.2.2:8081/timetables";


  Future<List<Map<String, dynamic>>> fetchTimetable() async {
    final response = await http.get(Uri.parse('$baseUrl'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load timetable');
    }
  }
}