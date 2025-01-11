import 'package:flutter/material.dart';
import 'package:time_table_system/Component/menu.dart';
import 'package:time_table_system/Entry/TimetableEntry.dart';
import 'package:time_table_system/services/time_table_service.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({
    super.key,
    required this.fullName,
    required this.role,
    required this.userId,
    required this.classId,
  });
  final String fullName;
  final String role;
  final int userId;
  final int? classId;

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  late Future<Map<String, List<TimetableEntry>>> _timetableFuture;

  final TimetableService _timetableService = TimetableService();

  final List<String> _daysOfWeek = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];

  String _selectedDay = 'MONDAY';

  @override
  void initState() {
    super.initState();
    if (widget.role != "TEACHER" && widget.classId == null) {
      throw Exception('Class ID is required for non-teacher roles');
    }
    _timetableFuture = _timetableService.fetchTimetable(
        widget.classId, widget.userId, widget.role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(90, 95, 231, 231),
        title: const Text("UniTimeTable", style: TextStyle(color: Colors.white)),
      ),
      drawer: Menu(
        fullName: widget.fullName,
        role: widget.role,
        userId: widget.userId,
        classId: widget.classId,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  value: _selectedDay,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDay = newValue!;
                    });
                  },
                  items: _daysOfWeek
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<Map<String, List<TimetableEntry>>>(
              future: _timetableFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _timetableFuture = _timetableService.fetchTimetable(
                                  widget.classId, widget.userId, widget.role);
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
                  if (!timetableData.containsKey(_selectedDay)) {
                    return const Center(child: Text('No classes scheduled for the selected day.'));
                  }
                  final currentDayEntries = timetableData[_selectedDay]!;
                  if (currentDayEntries.isEmpty) {
                    return const Center(child: Text('No classes scheduled for the selected day.'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: currentDayEntries.length,
                    itemBuilder: (context, index) {
                      final entry = currentDayEntries[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: ListTile(
                          title: Text(
                            entry.subjectName,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Room: ${entry.roomName}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                              Text('Seance: ${entry.seance}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                            ],
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