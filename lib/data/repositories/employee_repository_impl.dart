


import 'package:management/data/data_sources/local/employee_local_datasource.dart';
import 'package:management/domain/entities/employee.dart';
import 'package:management/domain/repositories/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  EmployeeRepositoryImpl(this._local);

  final EmployeeLocalDataSource _local;

  @override
  Future<int> create(Employee employee) => _local.create(employee);

  @override
  Future<Employee?> getById(int id) => _local.getById(id);

  @override
  Future<List<Employee>> getAll({bool activeOnly = true}) =>
      _local.getAll(activeOnly: activeOnly);

  @override
  Future<int> setStatus({required int id, required int status}) =>
      _local.setStatus(id: id, status: status);

  @override
  Future<int> update(Employee employee) => _local.update(employee);
}
