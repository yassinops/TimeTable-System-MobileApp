import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 46, 209, 234),
        title: const Text(
          "UniTimeTable",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
