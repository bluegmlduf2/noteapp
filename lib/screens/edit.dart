import 'package:flutter/material.dart';
import '../data/models.dart';
import '../services/database.dart';

class EditNotePage extends StatefulWidget {
  final Function() triggerRefetch;
  final NotesModel? existingNote;

  const EditNotePage(
      {super.key, required this.triggerRefetch, this.existingNote});

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late NotesModel currentNote;
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    currentNote = widget.existingNote ??
        NotesModel(
            id: 0,
            title: '',
            content: '',
            isImportant: false,
            date: DateTime.now());
    titleController = TextEditingController(text: currentNote.title);
    contentController = TextEditingController(text: currentNote.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content')),
            ElevatedButton(onPressed: _saveNote, child: const Text('Save')),
          ],
        ),
      ),
    );
  }

  void _saveNote() async {
    currentNote.title = titleController.text;
    currentNote.content = contentController.text;
    if (widget.existingNote == null) {
      await NotesDatabaseService.db.addNoteInDB(currentNote);
    } else {
      await NotesDatabaseService.db.updateNoteInDB(currentNote);
    }
    widget.triggerRefetch();
    Navigator.pop(context);
  }
}
