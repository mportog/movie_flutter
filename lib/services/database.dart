import 'dart:io';

import 'package:path/path.dart';
import 'package:sity_movies/models/favorite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "test.db";
  static final _databaseVersion = 1;

  static final table = 'favorites';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnTitle = 'title';
  static final columnPoster = 'poster';
  static final columnImdbId = 'imdbId';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL, $columnTitle TEXT NOT NULL, $columnPoster TEXT NOT NULL, $columnImdbId TEXT NOT NULL)');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  getFavoriteByName(String name) async {
    final db = await database;
    var res =await  db.query("favorites", where: "name = ?", whereArgs: [name]);
    return res;
  }

  getAllFavorite() async {
    final db = await instance.database;
    var res = await db.query("favorites");
    List<Favorite> list =
    res.isNotEmpty ? res.map((c) => Favorite.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryById(int id) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table WHERE $columnId= $id');
  }

  Future<List<Map<String, dynamic>>> queryLastId() async {
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT _id FROM $table   WHERE   _id = (SELECT MAX(_id)  FROM $table)');
    return result;}

  Future<List<Map<String, dynamic>>> queryByNameRows(String name) async {
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT * FROM $table WHERE $columnName = $name');
    return result;}

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }


}