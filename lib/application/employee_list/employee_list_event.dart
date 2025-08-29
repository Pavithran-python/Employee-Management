import 'package:flutter/cupertino.dart';

@immutable
abstract class EmployeeListEvent {
  const EmployeeListEvent();
}

class LoadEmployeeList extends EmployeeListEvent {
  const LoadEmployeeList({required this.loader});
  final bool loader;
}

class SoftDeleteEmployee extends EmployeeListEvent {
  const SoftDeleteEmployee({required this.employeeId});
  final int employeeId;
}

class UndoDeleteEmployee extends EmployeeListEvent {
  const UndoDeleteEmployee({required this.employeeId});
  final int employeeId;
}