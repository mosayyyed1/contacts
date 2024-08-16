import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact.dart';

class DatabaseHelper {
  static Database? _db;
  final String tableName = 'contact';

  Future<Database?> get database async {
    if (_db == null) {
      _db = await initDatabase();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), 'contact.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDb,
    );
  }

  Future _onCreateDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      phone TEXT NOT NULL,
      imgUrl TEXT NOT NULL
    )
    ''');
  }

  Future<void> deleteContact(int id) async {
    final db = await database;
    await db!.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertContact(Contact contact) async {
    final db = await database;
    await db!.insert(tableName, contact.toMap());
  }

  Future<List<Contact>> getContacts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });
  }
}
