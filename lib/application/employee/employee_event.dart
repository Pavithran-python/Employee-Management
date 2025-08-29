part of 'employee_bloc.dart';

@immutable
abstract class EmployeeEvent {}

/// Load for detail screen. If [id] is null, returns an empty template.
class EmployeeLoadRequested extends EmployeeEvent {
  final int? id;
  EmployeeLoadRequested({this.id});
}

/// Create a new employee.
class EmployeeCreateRequested extends EmployeeEvent {
  final Employee employee;
  EmployeeCreateRequested({required this.employee});
}

/// Update an existing employee.
class EmployeeUpdateRequested extends EmployeeEvent {
  final Employee employee;
  EmployeeUpdateRequested({required this.employee});
}

/// Soft-delete / archive / restore by setting [status] (int).
class EmployeeSetStatusRequested extends EmployeeEvent {
  final int id;
  final int status; // use EmployeeStatusHelper.toInt(...)
  EmployeeSetStatusRequested({required this.id, required this.status});
}
