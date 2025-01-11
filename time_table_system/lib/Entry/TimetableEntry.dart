import 'dart:convert';

class TimetableEntry {
  final String subjectName;
  final String roomName;
  final String seance;

  TimetableEntry({
    required this.subjectName,
    required this.roomName,
    required this.seance,
  });

  factory TimetableEntry.fromJson(Map<String, dynamic> json) {
  return TimetableEntry(
    subjectName: json['subjectName'] ?? '',
    roomName: json['roomName'] ?? '',
    seance: json['seance'] ?? '',
  );
}

  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName,
      'roomName': roomName,
      'seance': seance,
    };
  }
} 