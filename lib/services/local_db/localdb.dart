
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoomato/models/restaurant.dart';

class LocalDB {
  LocalDB._();
  static final LocalDB localDb = LocalDB._();
  static String _tableName = 'Bookmark';
  static Database _database;

  Future<Database> get database async {
    print("database getter callig started____________________$_database");
    if (_database != null) return _database;

    _database = await initDB();
    print("database getter ____________________$_database");
    return _database;
  }

  initDB() async {
    print("init of DBProvider ++++++++++++++++++");
    return await openDatabase(
      join(await getDatabasesPath(), "$_tableName.db"),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Bookmark(
          id TEXT PRIMARY KEY, name TEXT, url TEXT, restaurantLocation BLOB,
          timings TEXT, average_cost_for_two TEXT, currency TEXT,highlights TEXT,
          thumb TEXT, cuisines TEXT, all_reviews_count INTEGER,is_delivering_now INTEGER,
          phone_numbers TEXT)
        ''');
      },
      version: 1,
    );
  }

  Future<List<Restaurant>> getAllBookmarks() async{
    final db = await database;
    final result = await  db.query(_tableName);
    if(result.length == 0) return null;
    return result.map((e) => Restaurant.fromJsonOfLocalDB(e)).toList();
  }

  Future<List<String>> getIds() async{
    final db = await database;
    final result = await  db.query(_tableName);
    return result.map((e) => e["id"].toString()).toList();
  }

  Future<void> deleteBookmark(String id) async {
    final db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> addBookmark(Restaurant restaurant) async{
    final db = await database;
    final ids = await getIds();
    if(ids.contains(restaurant.id)) {
      print("already exist");
      return;
    }
    final id =await db.insert(_tableName, restaurant.toMapForDb());
    print("$id ===== id result form db");
  }

}