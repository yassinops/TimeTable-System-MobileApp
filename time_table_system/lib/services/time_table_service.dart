import 'package:http/http.dart' as http;
import 'package:time_table_system/Entry/TimetableEntry.dart';
import 'dart:convert';

class TimetableService {
  final String host = "192.168.100.96";

  Future<Map<String, List<TimetableEntry>>> fetchTimetable(int? classId, int userId, String role) async {
    String path;
    if (role == "TEACHER") {
      path = "/teacher/timetables/$userId";
    } else {
      if (classId == null) {
        throw Exception('Class ID is required for students');
      }
      path = "/timetables/$classId";
    }

    Uri url = Uri(
      scheme: 'http',
      host: host,
      port: 8080,
      path: path,
    );

    print('Fetching timetable from: $url');

    try {
      final response = await http.get(url);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (role == "TEACHER") {
          final Map<String, List<TimetableEntry>> teacherTimetable = {};
          data.forEach((day, entries) {
            teacherTimetable[day] = entries.map((entry) => TimetableEntry.fromJson(entry)).toList();
          });
          return teacherTimetable;
        } else {
          final Map<String, dynamic> calendar = data['calendar'];
          final Map<String, List<TimetableEntry>> studentTimetable = {};
          calendar.forEach((day, entries) {
            studentTimetable[day] = entries.map((entry) => TimetableEntry.fromJson(entry)).toList();
          });
          return studentTimetable;
        }
      } else {
        throw Exception('Failed to load timetable: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch timetable: $e');
    }
  }
}