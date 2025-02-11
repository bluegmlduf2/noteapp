import 'dart:math';

class NotesModel {
  late int id;
  late String title;
  late String content;
  late bool isImportant;
  late DateTime date;

  NotesModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.isImportant,
      required this.date});

  NotesModel.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    title = map['title'];
    content = map['content'];
    date = DateTime.parse(map['date']);
    isImportant = map['isImportant'] == 1 ? true : false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'content': content,
      'isImportant': isImportant == true ? 1 : 0,
      'date': date.toIso8601String()
    };
  }

  NotesModel.random() {
    id = Random(10).nextInt(1000) + 1;
    title = 'Lorem Ipsum ' * (Random().nextInt(4) + 1);
    content = 'Lorem Ipsum ' * (Random().nextInt(4) + 1);
    isImportant = Random().nextBool();
    date = DateTime.now().add(Duration(hours: Random().nextInt(100)));
  }
}
