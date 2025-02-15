import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../data/models.dart';

class NotesDatabaseService {
  static final NotesDatabaseService db = NotesDatabaseService._();
  Database? _database;

  NotesDatabaseService._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Notes (id INTEGER PRIMARY KEY, title TEXT, content TEXT, date TEXT, isImportant INTEGER);',
        );
      },
    );
  }

  Future<List<NotesModel>> getNotesFromDB() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Notes');
    return List.generate(maps.length, (i) => NotesModel.fromMap(maps[i]));
  }

  Future<void> updateNoteInDB(NotesModel updatedNote) async {
    final db = await database;
    await db.update('Notes', updatedNote.toMap(),
        where: 'id = ?', whereArgs: [updatedNote.id]);
  }

  Future<void> deleteNoteInDB(NotesModel noteToDelete) async {
    final db = await database;
    await db.delete('Notes', where: 'id = ?', whereArgs: [noteToDelete.id]);
  }

  Future<NotesModel> addNoteInDB(NotesModel newNote) async {
    final db = await database;
    int id = await db.insert('Notes', {
      'title': newNote.title,
      'content': newNote.content,
      'date': newNote.date.toIso8601String(),
      'isImportant': newNote.isImportant ? 1 : 0
    });
    return newNote;
  }
}
