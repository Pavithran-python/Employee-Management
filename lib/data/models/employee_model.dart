
import 'package:management/core/constants/employee_status.dart';
import 'package:management/core/utils/app_date_utils.dart';
import 'package:management/data/data_sources/local/database_provider.dart';
import 'package:management/domain/entities/employee.dart';

class EmployeeModel {
  final int? employeeId;
  final String employeeName;
  final String employeeRole;
  final DateTime? employeeJoinedDate;
  final DateTime? employeeEndDate;
  final int employeeStatus; // 1 active, 0 inactive

  const EmployeeModel({
    required this.employeeId,
    required this.employeeName,
    required this.employeeRole,
    required this.employeeJoinedDate,
    required this.employeeEndDate,
    required this.employeeStatus,
  });


  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    final rawJoin = map[DatabaseProvider.colJoin] as String?;
    final rawEnd = map[DatabaseProvider.colEnd] as String?;
    final joinDt = (rawJoin == null || rawJoin.trim().isEmpty)
        ? null
        : AppDateUtils.parseDMMMYYYY(rawJoin);
    final endDt = (rawEnd == null || rawEnd.trim().isEmpty)
        ? null
        : AppDateUtils.parseDMMMYYYY(rawEnd);

    return EmployeeModel(
      employeeId: map[DatabaseProvider.colId] as int?,
      employeeName: (map[DatabaseProvider.colName] as String?) ?? '',
      employeeRole: (map[DatabaseProvider.colRole] as String?) ?? '',
      employeeJoinedDate: joinDt,
      employeeEndDate: endDt,
      employeeStatus: (map[DatabaseProvider.colStatus] as int?) ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseProvider.colName: employeeName,
      DatabaseProvider.colRole: employeeRole,
      DatabaseProvider.colJoin: AppDateUtils.formatDMMMYYYY(employeeJoinedDate),
      DatabaseProvider.colEnd: employeeEndDate == null
          ? ''
          : AppDateUtils.formatDMMMYYYY(employeeEndDate),
      DatabaseProvider.colStatus: employeeStatus,
    };
  }


  Employee toEntity() {
    return Employee(
      id: employeeId,
      name: employeeName,
      role: employeeRole,
      joinedDate: employeeJoinedDate,
      endDate: employeeEndDate,
      status: EmployeeStatusHelper.fromInt(employeeStatus),
    );
  }

  factory EmployeeModel.fromEntity(Employee e) {
    return EmployeeModel(
      employeeId: e.id,
      employeeName: e.name,
      employeeRole: e.role,
      employeeJoinedDate: e.joinedDate,
      employeeEndDate: e.endDate,
      employeeStatus: EmployeeStatusHelper.toInt(e.status),
    );
  }

  EmployeeModel copyWith({
    int? employeeId,
    String? employeeName,
    String? employeeRole,
    DateTime? employeeJoinedDate,
    DateTime? employeeEndDate,
    int? employeeStatus,
  }) {
    return EmployeeModel(
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      employeeRole: employeeRole ?? this.employeeRole,
      employeeJoinedDate: employeeJoinedDate ?? this.employeeJoinedDate,
      employeeEndDate: employeeEndDate ?? this.employeeEndDate,
      employeeStatus: employeeStatus ?? this.employeeStatus,
    );
  }
}
