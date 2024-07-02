import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseImagem {
  static final DatabaseImagem _instance = DatabaseImagem._internal();
  static Database? _database;

  factory DatabaseImagem() {
    return _instance;
  }

  DatabaseImagem._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'veiculo_imagem.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE veiculos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        imagens TEXT
      )
    ''');
  }

  Future<int> insertVeiculo(String nome, List<String> imagens) async {
    final db = await database;
    return await db.insert(
      'veiculos',
      {
        'nome': nome,
        'imagens': imagens.join(','),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getVeiculos() async {
    final db = await database;
    return await db.query('veiculos');
  }
}
