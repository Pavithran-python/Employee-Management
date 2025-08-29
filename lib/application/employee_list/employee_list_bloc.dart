import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management/domain/usecases/get_all_employees.dart';
import 'package:management/domain/usecases/set_employee_status.dart';
import 'employee_list_event.dart';
import 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  EmployeeListBloc({
    required GetAllEmployees getAllEmployees,
    required SetEmployeeStatus setEmployeeStatus,
  })  : _getAll = getAllEmployees,
        _setStatus = setEmployeeStatus,
        super(const EmployeeListInitial()) {
    on<LoadEmployeeList>(_onLoad);
    on<SoftDeleteEmployee>(_onSoftDelete);
    on<UndoDeleteEmployee>(_onUndo);
  }

  final GetAllEmployees _getAll;
  final SetEmployeeStatus _setStatus;

  Future<void> _onLoad(
      LoadEmployeeList event,
      Emitter<EmployeeListState> emit,
      ) async {
    if (event.loader) emit(const EmployeeListLoading());
    try {
      final list = await _getAll(activeOnly: true);
      emit(EmployeeListLoaded(employeeList: list));
    } catch (e) {
      emit(EmployeeListError(message: e.toString()));
    }
  }

  Future<void> _onSoftDelete(
      SoftDeleteEmployee event,
      Emitter<EmployeeListState> emit,
      ) async {
    await _setStatus(id: event.employeeId, status: 0); // inactive
    add(const LoadEmployeeList(loader: false));
  }

  Future<void> _onUndo(
      UndoDeleteEmployee event,
      Emitter<EmployeeListState> emit,
      ) async {
    await _setStatus(id: event.employeeId, status: 1); // active
    add(const LoadEmployeeList(loader: false));
  }
}