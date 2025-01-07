import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // For date formatting
import 'package:time_table_system/Component/menu.dart';
import 'dart:convert'; // For JSON parsing

class TimeTable extends StatefulWidget {
  const TimeTable({
    super.key,
    required this.fullName,
    required this.role,
    required this.userId,
  });
  final String fullName;
  final String role;
  final int userId;

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  late DateTime _currentDate;
  late String _dayOfWeek;
  late String _formattedDate;
  late Future<List<Map<String, dynamic>>> _timetableFuture;

  // Timetable API service
  final String _baseUrl = 'https://your-backend-api.com';

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _dayOfWeek = DateFormat('EEEE').format(_currentDate); // Full day name (e.g., Monday)
    _formattedDate = DateFormat('d MMMM').format(_currentDate); // Date format (e.g., 6 Janvier)

    // Fetch timetable data when the widget is initialized
    _timetableFuture = _fetchTimetable();
  }

  // Fetch timetable data from the backend
  Future<List<Map<String, dynamic>>> _fetchTimetable() async {
    final response = await http.get(Uri.parse('$_baseUrl/timetable'));

    if (response.statusCode == 200) {
      // Parse the JSON response
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load timetable');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(90, 95, 231, 231),
        title: const Text(
          "UniTimeTable",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: Menu(
        fullName: widget.fullName,
        role: widget.role,
        userId: widget.userId,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _dayOfWeek,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formattedDate,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _timetableFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Failed to load timetable.'),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _timetableFuture = _fetchTimetable();
                            });
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No timetable data available.'));
                } else {
                  final timetableData = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: timetableData.length,
                    itemBuilder: (context, index) {
                      final entry = timetableData[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: ListTile(
                          title: Text(
                            entry['subject'] ?? 'No Subject',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${entry['time'] ?? 'No Time'} - ${entry['day'] ?? 'No Day'}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}