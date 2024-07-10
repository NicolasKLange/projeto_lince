import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Rent {
  final int? id;
  final int clientId;
  final int vehicleId;
  final String startDate;
  final String endDate;

  Rent({
    this.id,
    required this.clientId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
  });

  Rent copyWith({
    int? id,
    int? clientId,
    int? vehicleId,
    String? startDate,
    String? endDate,
  }) {
    return Rent(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      vehicleId: vehicleId ?? this.vehicleId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clientId': clientId,
      'vehicleId': vehicleId,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  static Rent fromMap(Map<String, dynamic> map) {
    return Rent(
      id: map['id'],
      clientId: map['clientId'],
      vehicleId: map['vehicleId'],
      startDate: map['startDate'],
      endDate: map['endDate'],
    );
  }
}

class DatabaseRent {
  static final DatabaseRent instance = DatabaseRent._init();

  static Database? _database;

  DatabaseRent._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('rents.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE rents (
  id $idType,
  clientId $intType,
  vehicleId $intType,
  startDate $textType,
  endDate $textType
)
''');
  }

  Future<Rent> create(Rent rent) async {
    final db = await instance.database;

    final id = await db.insert('rents', rent.toMap());
    return rent.copyWith(id: id);
  }

  Future<Rent> readRent(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'rents',
      columns: ['id', 'clientId', 'vehicleId', 'startDate', 'endDate'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Rent.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Rent>> readAllRents() async {
    final db = await instance.database;

    const orderBy = 'startDate ASC';
    final result = await db.query('rents', orderBy: orderBy);

    return result.map((json) => Rent.fromMap(json)).toList();
  }

  Future<int> update(Rent rent) async {
    final db = await instance.database;

    return db.update(
      'rents',
      rent.toMap(),
      where: 'id = ?',
      whereArgs: [rent.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'rents',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
