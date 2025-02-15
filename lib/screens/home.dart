import 'package:flutter/material.dart';
import '../component/cards.dart';
import '../screens/edit.dart';
import '../services/database.dart';
import '../data/models.dart';
import 'settings.dart';

class MyHomePage extends StatefulWidget {
  final Function(Brightness brightness) changeTheme;

  const MyHomePage({super.key, required this.changeTheme});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<NotesModel> notesList = [];
  bool isFlagOn = false;

  @override
  void initState() {
    super.initState();
    setNotesFromDB();
  }

  void _openNote(NotesModel note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotePage(
          existingNote: note,
          triggerRefetch: setNotesFromDB,
        ),
      ),
    );
  }

  // 메모 리스트 새롭게 받아오기
  Future<void> setNotesFromDB() async {
    List<NotesModel> fetchedNotes =
        await NotesDatabaseService.db.getNotesFromDB();
    setState(() {
      notesList = fetchedNotes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SettingsPage(changeTheme: widget.changeTheme)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EditNotePage(triggerRefetch: setNotesFromDB)),
        ),
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: notesList
            .map((note) =>
                NoteCardComponent(noteData: note, onTapAction: _openNote))
            .toList(),
      ),
    );
  }
}
