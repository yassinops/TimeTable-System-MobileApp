import 'package:flutter/material.dart';
import 'package:time_table_system/Component/menu.dart';
import 'package:time_table_system/Entry/TimetableEntry.dart';
import 'package:time_table_system/services/time_table_service.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  final PageController _pageController = PageController();

  final List<String> _daysOfWeek = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];

  int _selectedDayIndex = 0;

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildDaySelector() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _daysOfWeek.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDayIndex = index;
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedDayIndex == index
                    ? Colors.blue
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _daysOfWeek[index],
                  style: TextStyle(
                    color: _selectedDayIndex == index
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildClassCard(TimetableEntry entry) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    entry.subjectName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(90, 95, 231, 231).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Seance ${entry.seance}',
                    style: const TextStyle(
                      color: Color.fromARGB(90, 95, 231, 231),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.room, color: Colors.grey[600], size: 20),
                const SizedBox(width: 8),
                Text(
                  entry.roomName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(90, 95, 231, 231),
        title: const Text(
          "UniTimeTable",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Menu(
        fullName: widget.fullName,
        role: widget.role,
        userId: widget.userId,
        classId: widget.classId,
      ),
      body: Column(
        children: [
          _buildDaySelector(),
          const SizedBox(height: 10),
          SmoothPageIndicator(
            controller: _pageController,
            count: _daysOfWeek.length,
            effect: WormEffect(
              dotColor: Colors.grey[300]!,
              activeDotColor: Colors.blue,
              dotHeight: 8,
              dotWidth: 8,
              spacing: 8,
            ),
          ),
          const SizedBox(height: 10),
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
                        Icon(
                          Icons.error_outline,
                          color: Colors.red[300],
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error loading timetable',
                          style: TextStyle(color: Colors.red[300], fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _timetableFuture = _timetableService.fetchTimetable(
                                  widget.classId, widget.userId, widget.role);
                            });
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 70,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No timetable data available.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedDayIndex = index;
                    });
                  },
                  itemCount: _daysOfWeek.length,
                  itemBuilder: (context, index) {
                    final day = _daysOfWeek[index];
                    final entries = snapshot.data![day] ?? [];

                    if (entries.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_busy,
                              size: 70,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No classes scheduled for $day',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: entries.length,
                      itemBuilder: (context, index) => _buildClassCard(entries[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}