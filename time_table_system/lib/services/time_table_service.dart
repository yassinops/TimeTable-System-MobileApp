import 'package:http/http.dart' as http;
import 'package:time_table_system/Entry/TimetableEntry.dart';
import 'dart:convert';

class TimetableService {
  final String host = "127.0.0.1"; // Use IPv4 address instead of "localhost"

  Future<Map<String, List<TimetableEntry>>> fetchTimetable(int? classId, int userId, String role) async {
    print('Fetching timetable for user: $userId with role: $role');

    String path;
    if (role == "TEACHER") {
      path = "/teacher/timetables/$userId";
      print('User is a TEACHER, using path: $path');
    } else {
      if (classId == null) {
        print('Class ID is required for students but was not provided.');
        throw Exception('Class ID is required for students');
      }
      path = "/timetables/$classId";
      print('User is a STUDENT, using path: $path');
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
        print('Decoded JSON data: $data');

        if (role == "TEACHER") {
          // Teacher logic (unchanged)
          print('Processing timetable for TEACHER role.');
          final Map<String, List<TimetableEntry>> teacherTimetable = {};
          final Map<String, dynamic> teacherInformationMap = data['teacherInformationMap'];
          teacherInformationMap.forEach((day, entries) {
            print('Processing day: $day');
            teacherTimetable[day] = (entries as List<dynamic>)
                .map((entry) => TimetableEntry.fromJson(entry))
                .toList();
          });
          print('Teacher timetable processed successfully.');
          return teacherTimetable;
        } else {
          // Student logic (fixed)
          print('Processing timetable for STUDENT role.');

          // Parse the response as a list
          final List<dynamic> responseList = data;

          // Extract the first item (assuming there's only one item in the list)
          if (responseList.isNotEmpty) {
            final Map<String, dynamic> firstItem = responseList[0];

            // Access the 'calendar' field
            final Map<String, dynamic> calendar = firstItem['calendar'];

            // Process the calendar
            final Map<String, List<TimetableEntry>> studentTimetable = {};
            calendar.forEach((day, entries) {
              print('Processing day: $day');
              studentTimetable[day] = (entries as List<dynamic>)
                  .map((entry) => TimetableEntry.fromJson(entry))
                  .toList();
            });

            print('Student timetable processed successfully.');
            return studentTimetable;
          } else {
            throw Exception('No timetable data found for the student.');
          }
        }
      } else {
        print('Failed to load timetable. Status code: ${response.statusCode}');
        throw Exception('Failed to load timetable: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while fetching timetable: $e');
      throw Exception('Failed to fetch timetable: $e');
    }
  }}