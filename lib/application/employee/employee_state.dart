part of 'employee_bloc.dart';

@immutable
sealed class EmployeeState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final Employee employee;
  EmployeeLoaded({required this.employee});
}

class EmployeeSaving extends EmployeeState {}

/// Emitted after create/update succeeds.
/// [id] is the row id (for create) or the entity id (for update).
class EmployeeSaved extends EmployeeState {
  final int? id;
  final int? affected;
  EmployeeSaved({this.id, this.affected});
}

/// Emitted after status change (soft delete/restore).
class EmployeeStatusSet extends EmployeeState {
  final int id;
  final int status;
  final int affected;
  EmployeeStatusSet({required this.id, required this.status, required this.affected});
}

class EmployeeError extends EmployeeState {
  final String message;
  EmployeeError({required this.message});
}
