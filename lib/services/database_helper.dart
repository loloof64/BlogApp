import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:vlog_app/data/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    final notesDbExists = _database
        ?.select(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='notes';",
        )
        .isNotEmpty;
    if (notesDbExists != true) {
      await createTable(_database!);
    }
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, filePath);
    return sqlite3.open(path);
  }

  Future<void> createTable(Database db) async {
    db.execute('''
      CREATE TABLE IF NOT EXISTS notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        creationDate TEXT NOT NULL,
        modificationDate TEXT NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Note note) async {
    final db = await instance.database;
    db.execute(
      'INSERT INTO notes (creationDate, modificationDate, title, content) VALUES (?, ?, ?, ?)',
      [note.creationDate, note.modificationDate, note.title, note.content],
    );
    return db.lastInsertRowId;
  }

  Future<List<Note>> getNotes() async {
    final db = await instance.database;
    final result = db.select('SELECT * FROM notes');
    return result.map((row) => Note.fromMap(row)).toList();
  }

  Future<void> update(Note note) async {
    final db = await instance.database;
    return db.execute(
      'UPDATE notes SET creationDate = ?, modificationDate = ?, title = ?, content = ? WHERE id = ?',
      [
        note.creationDate,
        note.modificationDate,
        note.title,
        note.content,
        note.id
      ],
    );
  }

  Future<void> delete(int id) async {
    final db = await instance.database;
    return db.execute('DELETE FROM notes WHERE id = ?', [id]);
  }
}
