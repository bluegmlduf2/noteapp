import 'package:flutter/material.dart';
import '../data/models.dart';
import '../data/colors.dart';
import '../services/database.dart';

class EditNotePage extends StatefulWidget {
  final Function() triggerRefetch;
  final NotesModel? existingNote;

  const EditNotePage({
    super.key,
    required this.triggerRefetch,
    this.existingNote,
  });

  @override
  _EditNotePageState createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late NotesModel currentNote;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    currentNote = widget.existingNote ??
        NotesModel(
          title: '',
          content: '',
          isImportant: false,
          date: DateTime.now(),
        );

    contentController = TextEditingController(text: currentNote.content);
  }

  void _saveNote() async {
    if (contentController.text.isEmpty) {
      return;
    }
    // 저장한 메모의 상태저장
    setState(() {
      currentNote.content = contentController.text;
    });

    if (widget.existingNote == null) {
      await NotesDatabaseService.db.addNoteInDB(currentNote);
    } else {
      await NotesDatabaseService.db.updateNoteInDB(currentNote);
    }

    // 메모 리스트 새롭게 받아오기
    widget.triggerRefetch();
    // 홈화면 이동
    Navigator.pop(context);
  }

  void _deleteNote() async {
    if (widget.existingNote != null) {
      await NotesDatabaseService.db.deleteNoteInDB(currentNote);
      widget.triggerRefetch();
    }
    Navigator.pop(context);
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
              style: Theme.of(context).textTheme.bodyMedium,
              controller: contentController,
              decoration: InputDecoration(
                hintText: 'Enter Content',
              ),
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 10,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              alignment: WrapAlignment.center, // 중앙 정렬
              children: [
                if (widget.existingNote != null)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red1,
                      foregroundColor: white1,
                    ),
                    onPressed: _deleteNote,
                    child: const Text('Delete'),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue1,
                    foregroundColor: white1,
                  ),
                  onPressed: _saveNote,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
