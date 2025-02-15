import 'dart:math';

class NotesModel {
  int? id;
  String title;
  String content;
  bool isImportant;
  DateTime date;

  NotesModel({
    this.id,
    required this.title,
    required this.content,
    required this.isImportant,
    required this.date,
  });

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      isImportant: map['isImportant'] == 1,
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'isImportant': isImportant ? 1 : 0,
      'date': date.toIso8601String(),
    };
  }
}
