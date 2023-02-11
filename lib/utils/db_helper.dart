import 'package:matrimonycrud/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as p;

abstract class DBHelper {
  static Database? _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      var databasePath = await getDatabasesPath();
      String _path = p.join(databasePath, 'matrimonycrud.db');
      _db = await openDatabase(_path,
          version: _version, onCreate: onCreate, onUpgrade: onUpgrade);
    } catch (ex) {
      print(ex);
    }
  }

  static Future<List<Map<String, dynamic>>> getfav() async {
    return _db!.rawQuery("SELECT * from persons where IsFavorite = 1");
  }

  static Future<int> setfav(int n, int id) async {
    return await _db!
        .rawUpdate("UPDATE persons SET IsFavorite = $n WHERE id= $id");
  }

  static void onCreate(Database db, int version) async {
    String sqlQuery =
        'CREATE TABLE persons (id INTEGER PRIMARY KEY AUTOINCREMENT,personName STRING, age INTEGER, date STRING, contactNum STRING, email STRING, gender INTEGER, city STRING, state STRING, country STRING, IsFavorite INTEGER)';
    await db.execute(sqlQuery);
  }

  static void onUpgrade(Database db, int oldVersion, int version) async {
    if (oldVersion > version) {
      //
    }
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    return _db!.query(table);
  }

  static Future<int> insert(String table, Model model) async {
    return await _db!.insert(table, model.toJson());
  }

  static Future<int> update(String table, Model model) async {
    return await _db!.update(
      table,
      model.toJson(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  static Future<List<Map<String, dynamic>>> search(String a) async {
    String search = '\'%' + a + '%\'';
    return _db!.rawQuery(
        'SELECT * FROM persons where PersonName || City LIKE $search');
  }

  static Future<int> delete(String table, Model model) async {
    return await _db!.delete(
      table,
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }
}
