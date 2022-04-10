import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:great_places_app/models/place.dart';

class DatabaseHelper {
  static const _databasename = 'places.db';
  static const _databaseversion = 1;
  static const tableName = "great_places";
  static const columnid = 'id';
  static const columnTitle = "title";
  static const columnImage = "image";
  static const columnlatitude = "latitude";
  static const columnlongitude = "longitude";
  static const columnaddress = "address";

  static final instance = DatabaseHelper._init();
  DatabaseHelper._init();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase(_databasename);
    return _database!;
  }

  Future<Database> _initDatabase(String filepath) async {
    var dbpath = await getDatabasesPath();
    var path = join(dbpath, filepath);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    db.execute('''CREATE TABLE $tableName(
      $columnid INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnTitle TEXT NOT NULL ,
      $columnImage TEXT NOT NULL ,
      $columnlatitude TEXT ,
      $columnlongitude TEXT ,
      $columnaddress TEXT 
    )''');
  }

  Future<int> create(Place place) async {
    final db = await instance.database;
    final id = await db!.insert(tableName, place.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id; //generates and returns an id
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await instance.database;
    final maps = await db!.query(tableName);
    return maps;
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db!.delete(tableName, where: '$columnid = ?', whereArgs: [id]);
  }
}
