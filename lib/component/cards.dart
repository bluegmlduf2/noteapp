import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/models.dart';

class NoteCardComponent extends StatelessWidget {
  final NotesModel noteData;
  final Function(NotesModel) onTapAction;

  const NoteCardComponent(
      {super.key, required this.noteData, required this.onTapAction});

  @override
  Widget build(BuildContext context) {
    String neatDate = DateFormat.yMd().add_jm().format(noteData.date);
    return GestureDetector(
      onTap: () => onTapAction(noteData),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                noteData.title.length <= 20
                    ? noteData.title
                    : '${noteData.title.substring(0, 20)}...',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                noteData.content.split('\n').first.length <= 30
                    ? noteData.content.split('\n').first
                    : '${noteData.content.split('\n').first.substring(0, 30)}...',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  neatDate,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor(String title) {
    final List<Color> colorList = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.teal
    ];
    return colorList[title.length % colorList.length];
  }
}
