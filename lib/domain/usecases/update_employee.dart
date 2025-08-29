

import 'package:management/domain/entities/employee.dart';
import 'package:management/domain/repositories/employee_repository.dart';

class UpdateEmployee {
  UpdateEmployee(this._repo);
  final EmployeeRepository _repo;

  Future<int> call(Employee employee) => _repo.update(employee);
}
