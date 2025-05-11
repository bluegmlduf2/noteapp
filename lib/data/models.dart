import 'dart:convert';
import 'package:flutter/material.dart';

class NotesModel {
  int? id;
  String title;
  String content;
  DateTime date;
  TimeOfDay? startDate;
  TimeOfDay? endDate;
  List<int> days;
  bool isImportant;

  NotesModel({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    this.startDate,
    this.endDate,
    required this.days,
    required this.isImportant,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'startDate':
          startDate != null ? '${startDate!.hour}:${startDate!.minute}' : null,
      'endDate': endDate != null ? '${endDate!.hour}:${endDate!.minute}' : null,
      'days': jsonEncode(days),
      'isImportant': isImportant ? 1 : 0,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    TimeOfDay? parseTime(String? timeStr) {
      if (timeStr == null) return null;
      final parts = timeStr.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    return NotesModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
      startDate: parseTime(map['startDate']),
      endDate: parseTime(map['endDate']),
      days: map['days'] != null ? List<int>.from(jsonDecode(map['days'])) : [],
      isImportant: map['isImportant'] == 1,
    );
  }
}
