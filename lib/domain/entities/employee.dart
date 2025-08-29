

import 'package:management/core/constants/employee_status.dart';

class Employee {
  final int? id;
  final String name;
  final String role;
  final DateTime? joinedDate;
  final DateTime? endDate;
  final EmployeeStatus status;

  const Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.joinedDate,
    required this.endDate,
    required this.status,
  });

  Employee copyWith({
    int? id,
    String? name,
    String? role,
    DateTime? joinedDate,
    DateTime? endDate,
    EmployeeStatus? status,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      joinedDate: joinedDate ?? this.joinedDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }
}
