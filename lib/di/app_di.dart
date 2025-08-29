import 'package:management/data/data_sources/local/database_provider.dart';
import 'package:management/data/data_sources/local/employee_local_datasource.dart';
import 'package:management/data/repositories/employee_repository_impl.dart';
import 'package:management/domain/repositories/employee_repository.dart';
import 'package:management/domain/usecases/create_employee.dart';
import 'package:management/domain/usecases/get_all_employees.dart';
import 'package:management/domain/usecases/get_employee.dart';
import 'package:management/domain/usecases/set_employee_status.dart';
import 'package:management/domain/usecases/update_employee.dart';

class AppDI {
  AppDI._();

  // Data layer
  static final DatabaseProvider dbProvider = DatabaseProvider();
  static final EmployeeLocalDataSource employeeLocal =
  SqfliteEmployeeLocalDataSource(dbProvider);

  // Repositories
  static final EmployeeRepository employeeRepo = EmployeeRepositoryImpl(employeeLocal);

  // Use cases
  static final GetAllEmployees getAllEmployees = GetAllEmployees(employeeRepo);
  static final GetEmployee getEmployee = GetEmployee(employeeRepo);
  static final CreateEmployee createEmployee = CreateEmployee(employeeRepo);
  static final UpdateEmployee updateEmployee = UpdateEmployee(employeeRepo);
  static final SetEmployeeStatus setEmployeeStatus = SetEmployeeStatus(employeeRepo);
}
