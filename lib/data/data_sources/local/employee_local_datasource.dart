import 'package:management/domain/entities/employee.dart';
import 'package:sqflite/sqflite.dart';
import 'database_provider.dart';
import 'package:management/data/models/employee_model.dart';

abstract class EmployeeLocalDataSource {
  Future<int> create(Employee employee);
  Future<Employee?> getById(int id);
  Future<List<Employee>> getAll({bool activeOnly = true});
  Future<int> update(Employee employee);
  Future<int> setStatus({required int id, required int status}); // soft delete/archive
}

class SqfliteEmployeeLocalDataSource implements EmployeeLocalDataSource {
  SqfliteEmployeeLocalDataSource(this._provider);
  final DatabaseProvider _provider;

  @override
  Future<int> create(Employee employee) async {
    final db = await _provider.database;
    final model = EmployeeModel.fromEntity(employee);
    return db.insert(DatabaseProvider.employeeTable, model.toMap());
  }

  @override
  Future<Employee?> getById(int id) async {
    final db = await _provider.database;
    final rows = await db.query(
      DatabaseProvider.employeeTable,
      where: '${DatabaseProvider.colId} = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return EmployeeModel.fromMap(rows.first).toEntity();
  }

  @override
  Future<List<Employee>> getAll({bool activeOnly = true}) async {
    final db = await _provider.database;
    final where = activeOnly ? '${DatabaseProvider.colStatus} = ?' : null;
    final whereArgs = activeOnly ? const [1] : null;

    final rows = await db.query(
      DatabaseProvider.employeeTable,
      where: where,
      whereArgs: whereArgs,
      orderBy: '${DatabaseProvider.colId} DESC',
    );
    return rows.map((m) => EmployeeModel.fromMap(m).toEntity()).toList();
  }

  @override
  Future<int> update(Employee employee) async {
    final db = await _provider.database;
    final model = EmployeeModel.fromEntity(employee);
    final id = model.employeeId;
    if (id == null) throw ArgumentError('update requires non-null id');

    return db.update(
      DatabaseProvider.employeeTable,
      model.toMap(),
      where: '${DatabaseProvider.colId} = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<int> setStatus({required int id, required int status}) async {
    final db = await _provider.database;
    return db.update(
      DatabaseProvider.employeeTable,
      {DatabaseProvider.colStatus: status},
      where: '${DatabaseProvider.colId} = ?',
      whereArgs: [id],
    );
  }
}

