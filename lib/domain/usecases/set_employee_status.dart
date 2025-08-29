
import 'package:management/domain/repositories/employee_repository.dart';

class SetEmployeeStatus {
  SetEmployeeStatus(this._repo);
  final EmployeeRepository _repo;

  /// e.g. 1 = active, 0 = inactive (matches your constants)
  Future<int> call({required int id, required int status}) =>
      _repo.setStatus(id: id, status: status);
}
