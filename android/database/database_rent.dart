import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Rent {
  final int? id;
  final int clientId;
  final int vehicleId;
  final String startDate;
  final String endDate;
  final double totalCost;

  Rent({
    this.id,
    required this.clientId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
    required this.totalCost,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'vehicleId': vehicleId,
      'startDate': startDate,
      'endDate': endDate,
      'totalCost': totalCost,
    };
  }

  static Rent fromMap(Map<String, dynamic> map) {
    return Rent(
      id: map['id'],
      clientId: map['clientId'],
      vehicleId: map['vehicleId'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      totalCost: map['totalCost'],
    );
  }
}

class DatabaseRent {
  static final DatabaseRent _instance = DatabaseRent._internal();
  factory DatabaseRent() => _instance;
  DatabaseRent._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var path = join(await getDatabasesPath(), 'rent_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE rents('
              'id INTEGER PRIMARY KEY, '
              'clientId INTEGER, '
              'vehicleId INTEGER, '
              'startDate TEXT, '
              'endDate TEXT, '
              'totalCost REAL)',
        );
      },
    );
  }

  Future<void> insertRent(Rent rent) async {
    final db = await database;
    await db.insert(
      'rents',
      rent.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Rent>> getRents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('rents');
    return List.generate(maps.length, (i) {
      return Rent.fromMap(maps[i]);
    });
  }

  Future<void> updateRent(Rent rent) async {
    final db = await database;
    await db.update(
      'rents',
      rent.toMap(),
      where: 'id = ?',
      whereArgs: [rent.id],
    );
  }

  Future<void> deleteRent(int id) async {
    final db = await database;
    await db.delete(
      'rents',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
