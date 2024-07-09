import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'database_client.dart';
import 'database_vehicle.dart';

class Rent {
  final int? rentId;
  final int clientId;
  final int vehicleId;
  final String startDate;
  final String endDate;
  final double totalCost;

  Rent({
    this.rentId,
    required this.clientId,
    required this.vehicleId,
    required this.startDate,
    required this.endDate,
    required this.totalCost,
  });

  Rent copyWith({
    int? rentId,
    int? clientId,
    int? vehicleId,
    String? startDate,
    String? endDate,
    double? totalCost,
  }) {
    return Rent(
      rentId: rentId ?? this.rentId,
      clientId: clientId ?? this.clientId,
      vehicleId: vehicleId ?? this.vehicleId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalCost: totalCost ?? this.totalCost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'rentId': rentId,
      'clientId': clientId,
      'vehicleId': vehicleId,
      'startDate': startDate,
      'endDate': endDate,
      'totalCost': totalCost,
    };
  }

  static Rent fromMap(Map<String, dynamic> map) {
    return Rent(
      rentId: map['rentId'],
      clientId: map['clientId'],
      vehicleId: map['vehicleId'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      totalCost: map['totalCost'],
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
    const rentIdType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const intType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE rents (
  rentId $rentIdType,
  clientId $intType,
  vehicleId $intType,
  startDate $textType,
  endDate $textType,
  totalCost $doubleType
)
''');
  }

  Future<Rent> create(Rent rent) async {
    final db = await instance.database;

    final rentId = await db.insert('rents', rent.toMap());
    return rent.copyWith(rentId: rentId);
  }

  Future<Rent> readRent(int rentId) async {
    final db = await instance.database;

    final maps = await db.query(
      'rents',
      columns: ['rentId', 'clientId', 'vehicleId', 'startDate', 'endDate', 'totalCost'],
      where: 'rentId = ?',
      whereArgs: [rentId],
    );

    if (maps.isNotEmpty) {
      return Rent.fromMap(maps.first);
    } else {
      throw Exception('RentId $rentId not found');
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
      where: 'rentId = ?',
      whereArgs: [rent.rentId],
    );
  }

  Future<int> delete(int rentId) async {
    final db = await instance.database;

    return await db.delete(
      'rents',
      where: 'rentId = ?',
      whereArgs: [rentId],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
