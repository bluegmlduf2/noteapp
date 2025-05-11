import 'package:flutter/material.dart';
import '../data/models.dart';
import '../data/colors.dart';
import '../component/timePicker.dart';
import '../component/dayButtons.dart';
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
  late TextEditingController titleController;
  late TextEditingController contentController;
  bool isExpanded = false; // 펼쳐짐 여부 상태

  @override
  void initState() {
    super.initState();
    currentNote = widget.existingNote ??
        NotesModel(
            title: '',
            content: '',
            isImportant: false,
            startDate: null,
            endDate: null,
            date: DateTime.now(),
            days: []);

    titleController = TextEditingController(text: currentNote.title);
    contentController = TextEditingController(text: currentNote.content);
  }

  void _saveNote() async {
    if (titleController.text.isEmpty) {
      return;
    }
    // 저장한 메모의 상태저장
    setState(() {
      currentNote.title = titleController.text;
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
      appBar: AppBar(
        title: const Text(
          'Edit Note',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: blue1,
            size: 20,
          ), // iOS 스타일의 뒤로가기 아이콘
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter Title',
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Content",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: 'Enter Content',
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null, // 자동 확장
                ),
              ]),
              const SizedBox(height: 20),
              Card(
                color: gray1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  title: Text(
                    "Timer Setting",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  shape: Border(),
                  initiallyExpanded: isExpanded,
                  onExpansionChanged: (expanded) {
                    setState(() {
                      isExpanded = expanded;
                    });
                  },
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TimePicker(label: 'Start time'),
                              TimePicker(label: 'End time'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          DayButtons(),
                        ])),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16,
                alignment: WrapAlignment.center, // 중앙 정렬
                children: [
                  if (widget.existingNote != null)
                    OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: red1,
                        side: BorderSide(color: red1, width: 1), // 보더 색상 및 두께
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _deleteNote,
                      child: const Text('Delete'),
                    ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blue1,
                        foregroundColor: white1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: _saveNote,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
