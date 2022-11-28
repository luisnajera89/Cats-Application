import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import '../models/cat_model.dart';

class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database; 
  Future<Database> get database async=> _database??= await _initDatabase();

  Future<Database>_initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'planets.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async{
    db.execute(
      '''
      CREATE TABLE planets(
        id INTEGER PRIMARY KEY,
        Description TEXT,
        Type TEXT,
        Size TEXT,
        Image TEXT,
        Name TEXT
      )
      '''
    );
  }

  Future<int>add(Planet planet) async {
    Database db = await instance.database;
    return await db.insert('planets', planet.toMap());
  }

  Future<int>delete(int id)async{
    Database db = await instance.database;
    return await db.delete('planets',where: 'id=?', whereArgs: [id]);
  }

  Future<int>update(Planet planet) async {
    Database db = await instance.database;
    return await db.update('planets', planet.toMap(), where: 'id = ?', whereArgs: [planet.id]);
  }

  Future<List<Planet>>getPlanets() async {
    Database db = await instance.database;
    var planets = await db.query('planets', orderBy: 'Description');
    
    List<Planet>planetsList = 
      planets.isNotEmpty? planets.map((e) => Planet.formMap(e)).toList():[];
    return planetsList;

  }
}

  