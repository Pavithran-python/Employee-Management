import 'package:flutter/cupertino.dart';
import 'package:management/domain/entities/employee.dart';

@immutable
abstract class EmployeeListState {
  const EmployeeListState();
}

class EmployeeListInitial extends EmployeeListState {
  const EmployeeListInitial();
}

class EmployeeListLoading extends EmployeeListState {
  const EmployeeListLoading();
}

class EmployeeListLoaded extends EmployeeListState {
  const EmployeeListLoaded({required this.employeeList});
  final List<Employee> employeeList;
}

class EmployeeListError extends EmployeeListState {
  const EmployeeListError({required this.message});
  final String message;
}