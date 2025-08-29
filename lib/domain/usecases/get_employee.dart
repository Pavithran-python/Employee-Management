

import 'package:management/domain/entities/employee.dart';
import 'package:management/domain/repositories/employee_repository.dart';

class GetEmployee {
  GetEmployee(this._repo);
  final EmployeeRepository _repo;

  Future<Employee?> call(int id) => _repo.getById(id);
}
