import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Manager {
  final int? id;
  final String name;
  final String phone;
  final String cpf;
  final String city;
  final String comission;
  final String state;

  Manager({this.id, required this.name, required this.phone, required this.cpf,
    required this.city, required this.comission, required this.state});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'cpf': cpf,
      'city': city,
      'comission': comission,
      'state': state,
    };
  }
}

class DatabaseManager {
  static final DatabaseManager _instance = DatabaseManager._internal();
  factory DatabaseManager() => _instance;
  DatabaseManager._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'manager_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE managers(id INTEGER PRIMARY KEY, name TEXT, phone TEXT, cpf TEXT, city TEXT, comission TEXT, state TEXT)',
        );
      },
    );
  }

  Future<void> insertManager(Manager manager) async {
    final db = await database;
    await db.insert(
      'managers',
      manager.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Manager>> getManagers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('managers');
    return List.generate(maps.length, (i) {
      return Manager(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phone: maps[i]['phone'],
        cpf: maps[i]['cpf'],
        city: maps[i]['city'],
        comission: maps[i]['comission'],
        state: maps[i]['state'],
      );
    });
  }

  Future<void> updateManager(Manager manager) async {
    final db = await database;
    await db.update(
      'managers',
      manager.toMap(),
      where: 'id = ?',
      whereArgs: [manager.id],
    );
  }

  Future<void> deleteManager(int id) async {
    final db = await database;
    await db.delete(
      'managers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}