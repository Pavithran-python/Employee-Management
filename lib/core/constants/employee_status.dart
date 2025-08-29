/// Employee active / inactive status codes.
enum EmployeeStatus {
  inactive,
  active,
}

class EmployeeStatusHelper {
  EmployeeStatusHelper._();

  static int toInt(EmployeeStatus status) {
    switch (status) {
      case EmployeeStatus.active:
        return 1;
      case EmployeeStatus.inactive:
        return 0;
    }
  }

  static EmployeeStatus fromInt(int value) {
    return value == 1 ? EmployeeStatus.active : EmployeeStatus.inactive;
  }

  static bool isActive(EmployeeStatus status) => status == EmployeeStatus.active;
}
