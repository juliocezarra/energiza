// lib/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'device.dart'; // Atualize a importação

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('devices.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE devices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        image TEXT,
        status REAL,  -- Mudança para REAL
        isOn INTEGER
      )
    ''');
  }

  Future<List<Device>> getDevices() async {
    final db = await instance.database;
    final maps = await db.query('devices');
    return maps.isNotEmpty
        ? maps.map((map) => Device.fromMap(map)).toList()
        : [];
  }

  Future<void> insertDevice(Device device) async {
    final db = await instance.database;
    await db.insert(
      'devices',
      device.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDevice(Device device) async {
    final db = await instance.database;
    await db.update(
      'devices',
      device.toMap(),
      where: 'id = ?',
      whereArgs: [device.id],
    );
  }

  Future<void> deleteDevice(int id) async {
    final db = await instance.database;
    await db.delete(
      'devices',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
