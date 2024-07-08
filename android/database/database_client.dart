import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class Client {
  final int? id;
  final String name;
  final String phone;
  final String cnpj;

  Client({
    this.id,
    required this.name,
    required this.phone,
    required this.cnpj
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'cnpj': cnpj,
    };
  }
}

class DatabaseClient {
  static final DatabaseClient _instance = DatabaseClient._internal();
  factory DatabaseClient() => _instance;
  DatabaseClient._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var path = join(await getDatabasesPath(), 'client_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE clients('
              'id INTEGER PRIMARY KEY, '
              'name TEXT, '
              'phone TEXT, '
              'cnpj TEXT)',
        );
      },
    );
  }

  Future<void> insertClient(Client client) async {
    final db = await database;
    await db.insert(
      'clients',
      client.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Client>> getClients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('clients');
    return List.generate(maps.length, (i) {
      return Client(
        id: maps[i]['id'],
        name: maps[i]['name'],
        phone: maps[i]['phone'],
        cnpj: maps[i]['cnpj'],
      );
    });
  }

  Future<void> updateClient(Client client) async {
    final db = await database;
    await db.update(
      'clients',
      client.toMap(),
      where: 'id = ?',
      whereArgs: [client.id],
    );
  }

  Future<void> deleteClient(int id) async {
    final db = await database;
    await db.delete(
      'clients',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<Client?> getClientByCnpj(String cnpj) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'clients',
      where: 'cnpj = ?',
      whereArgs: [cnpj],
    );

    if (maps.isNotEmpty) {
      return Client(
        id: maps.first['id'],
        name: maps.first['name'],
        phone: maps.first['phone'],
        cnpj: maps.first['cnpj'],
      );
    } else {
      return null;
    }
  }
}