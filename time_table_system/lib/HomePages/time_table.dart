import 'package:flutter/material.dart';
import 'package:time_table_system/Component/menu.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key, required this.fullName, required this.role,required this.userId});
  final String fullName;
  final String role;
  final int userId;
  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
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
    );
  }
}
