import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:management/domain/entities/employee.dart';
import 'package:management/domain/repositories/employee_repository.dart';
import 'package:management/core/constants/employee_status.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc(this._repo) : super(EmployeeInitial()) {
    // Create
    on<EmployeeCreateRequested>((event, emit) async {
      try {
        emit(EmployeeSaving());
        final id = await _repo.create(event.employee);
        emit(EmployeeSaved(id: id));
      } catch (e) {
        emit(EmployeeError(message: e.toString()));
      }
    });

    // Read (load by id OR empty template)
    on<EmployeeLoadRequested>((event, emit) async {
      try {
        emit(EmployeeLoading());
        if (event.id == null) {
          // Empty template for "Add"
          emit(EmployeeLoaded(employee: _emptyEmployee()));
        } else {
          final emp = await _repo.getById(event.id!);
          if (emp == null) {
            emit(EmployeeError(message: 'Employee not found (id: ${event.id})'));
          } else {
            emit(EmployeeLoaded(employee: emp));
          }
        }
      } catch (e) {
        emit(EmployeeError(message: e.toString()));
      }
    });

    // Update
    on<EmployeeUpdateRequested>((event, emit) async {
      try {
        emit(EmployeeSaving());
        final rows = await _repo.update(event.employee);
        emit(EmployeeSaved(id: event.employee.id, affected: rows));
      } catch (e) {
        emit(EmployeeError(message: e.toString()));
      }
    });

    // Soft delete / archive / restore (status change)
    on<EmployeeSetStatusRequested>((event, emit) async {
      try {
        emit(EmployeeSaving());
        final rows = await _repo.setStatus(id: event.id, status: event.status);
        emit(EmployeeStatusSet(id: event.id, status: event.status, affected: rows));
      } catch (e) {
        emit(EmployeeError(message: e.toString()));
      }
    });
  }

  final EmployeeRepository _repo;

  Employee _emptyEmployee() => Employee(
    id: null,
    name: '',
    role: '',
    joinedDate: null,
    endDate: null,
    status: EmployeeStatus.active, // default active
  );
}
