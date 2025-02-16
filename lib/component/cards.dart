import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/data/colors.dart';
import '../data/models.dart';

class NoteCardComponent extends StatelessWidget {
  final NotesModel noteData;
  final Function(NotesModel) onTapAction;

  const NoteCardComponent(
      {super.key, required this.noteData, required this.onTapAction});

  @override
  Widget build(BuildContext context) {
    String createdDate = DateFormat('yyyy/MM/dd hh:mm a').format(noteData.date);

    return GestureDetector(
      onTap: () => onTapAction(noteData),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: blue2,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(20),
          // padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                noteData.title.length <= 30
                    ? noteData.title
                    : '${noteData.title.substring(0, 30)}...',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                // noteData.content,
                noteData.content.split('\n').first.length <= 40
                    ? noteData.content.split('\n').first
                    : '${noteData.content.split('\n').first.substring(0, 130)}...',
                style: TextStyle(
                  fontSize: 12,
                  color: textgray1,
                ),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  createdDate,
                  style: TextStyle(
                    fontSize: 12,
                    color: textgray1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
