

import 'package:management/domain/entities/employee.dart';
import 'package:management/domain/repositories/employee_repository.dart';

class GetAllEmployees {
  GetAllEmployees(this._repo);
  final EmployeeRepository _repo;

  Future<List<Employee>> call({bool activeOnly = true}) => _repo.getAll(activeOnly: activeOnly);
}
