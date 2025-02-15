import 'package:flutter/material.dart';
import '../data/models.dart';
import '../screens/edit.dart';

class ViewNotePage extends StatelessWidget {
  final NotesModel note;
  final Function() triggerRefetch;

  const ViewNotePage(
      {super.key, required this.note, required this.triggerRefetch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditNotePage(
                  existingNote: note,
                  triggerRefetch: triggerRefetch,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(note.content),
      ),
    );
  }
}
