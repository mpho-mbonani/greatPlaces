import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> databaseConnection() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, locationLatitude REAL, locationLongitude REAL, address TEXT)',
      );
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    // might wanna move this to global variable level to access from any method within class
    final dbConnection = await DbHelper.databaseConnection();
    dbConnection.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final dbConnection = await DbHelper.databaseConnection();
    return dbConnection.query(table);
  }
}
