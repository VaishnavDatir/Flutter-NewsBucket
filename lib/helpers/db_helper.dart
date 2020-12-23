import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, "savedNews.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE user_savedNews(title TEXT PRIMARY KEY, desc TEXT, imageurl TEXT,newsurl TEXT, sourcename TEXT, author TEXT )");
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> delete(String table, String titlestring) async {
    final db = await DBHelper.database();
    db.delete(table, where: 'title = ?', whereArgs: [titlestring]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<bool> isStored(String table, String titlestring) async {
    final db = await DBHelper.database();
    List<Map<String, dynamic>> res =
        await db.query(table, where: "title =?", whereArgs: [titlestring]);
    if (res.length > 0) {
      return true;
    } else {
      return false;
    }
  }
}
