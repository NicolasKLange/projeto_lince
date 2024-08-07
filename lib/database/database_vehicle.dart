import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Vehicle {
  final int? id;
  final String brand;
  final String model;
  final String licensePlate;
  final String year;
  final String rentalCost;
  final List<String>? photos; // Alterado para lista de caminhos de imagens

  Vehicle({
    this.id,
    required this.brand,
    required this.model,
    required this.licensePlate,
    required this.year,
    required this.rentalCost,
    this.photos,
  });

  Vehicle copyWith({
    int? id,
    String? brand,
    String? model,
    String? licensePlate,
    String? year,
    String? rentalCost,
    List<String>? photos,
  }) {
    return Vehicle(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      licensePlate: licensePlate ?? this.licensePlate,
      year: year ?? this.year,
      rentalCost: rentalCost ?? this.rentalCost,
      photos: photos ?? this.photos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'licensePlate': licensePlate,
      'year': year,
      'rentalCost': rentalCost,
      'photos': photos != null ? photos!.join(',') : null, // Convertendo lista para string
    };
  }

  static Vehicle fromMap(Map<String, dynamic> map) {
    return Vehicle(
      id: map['id'],
      brand: map['brand'],
      model: map['model'],
      licensePlate: map['licensePlate'],
      year: map['year'],
      rentalCost: map['rentalCost'],
      photos: map['photos'] != null ? (map['photos'] as String).split(',') : null, // Convertendo string para lista
    );
  }
}


class DatabaseVehicle {
  static final DatabaseVehicle instance = DatabaseVehicle._init();

  static Database? _database;

  DatabaseVehicle._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('vehicles.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE vehicles (
  id $idType,
  brand $textType,
  model $textType,
  licensePlate $textType,
  year $textType,
  rentalCost $textType,
  photos TEXT
)
''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute('ALTER TABLE vehicles ADD COLUMN photos TEXT');
    }
  }

  Future<Vehicle> create(Vehicle vehicle) async {
    final db = await instance.database;

    final id = await db.insert('vehicles', vehicle.toMap());
    return vehicle.copyWith(id: id);
  }

  Future<Vehicle> readVehicle(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      'vehicles',
      columns: ['id', 'brand', 'model', 'licensePlate', 'year', 'rentalCost', 'photos'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Vehicle.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Vehicle>> readAllVehicles() async {
    final db = await instance.database;

    const orderBy = 'brand ASC';
    final result = await db.query('vehicles', orderBy: orderBy);

    return result.map((json) => Vehicle.fromMap(json)).toList();
  }

  Future<int> update(Vehicle vehicle) async {
    final db = await instance.database;

    return db.update(
      'vehicles',
      vehicle.toMap(),
      where: 'id = ?',
      whereArgs: [vehicle.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      'vehicles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}