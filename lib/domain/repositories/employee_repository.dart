

import 'package:management/domain/entities/employee.dart';

abstract class EmployeeRepository {
  Future<int> create(Employee employee);
  Future<Employee?> getById(int id);
  Future<List<Employee>> getAll({bool activeOnly});
  Future<int> update(Employee employee);
  Future<int> setStatus({required int id, required int status});
}
