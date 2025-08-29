import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart' as p;

class DatabaseProvider {
  DatabaseProvider({this.dbName = 'employee_list_db', this.version = 1});

  final String dbName;
  final int version;

  static const String employeeTable = 'employees';
  static const String colId = 'employeeId';
  static const String colName = 'employeeName';
  static const String colRole = 'employeeRole';
  static const String colJoin = 'employeeJoinDate';
  static const String colEnd = 'employeeEndDate';
  static const String colStatus = 'employeeStatus';

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, dbName);
    return openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $employeeTable (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colName TEXT,
        $colRole TEXT,
        $colJoin TEXT,
        $colEnd TEXT,
        $colStatus INTEGER
      )
    ''');
  }
}
