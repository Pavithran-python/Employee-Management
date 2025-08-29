import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:management/application/employee/employee_bloc.dart';
import 'package:management/application/employee_list/employee_list_bloc.dart';
import 'package:management/application/employee_list/employee_list_event.dart';

import 'package:management/core/constants/app_sizes.dart';

import 'package:management/data/data_sources/local/database_provider.dart';
import 'package:management/data/data_sources/local/employee_local_datasource.dart';
import 'package:management/data/repositories/employee_repository_impl.dart';

import 'package:management/domain/repositories/employee_repository.dart';
import 'package:management/domain/usecases/get_all_employees.dart';
import 'package:management/domain/usecases/set_employee_status.dart';

import 'package:management/presentation/features/employee_list/pages/employee_list_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // init DB + repo
  final provider = DatabaseProvider();
  final dataSource = SqfliteEmployeeLocalDataSource(provider);
  final EmployeeRepository repo = EmployeeRepositoryImpl(dataSource);

  // init use cases
  final getAllEmployees = GetAllEmployees(repo);
  final setEmployeeStatus = SetEmployeeStatus(repo);

  FlutterNativeSplash.remove();

  runApp(
    MyApp(
      repo: repo,
      getAllEmployees: getAllEmployees,
      setEmployeeStatus: setEmployeeStatus,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.repo,
    required this.getAllEmployees,
    required this.setEmployeeStatus,
  });

  final EmployeeRepository repo;
  final GetAllEmployees getAllEmployees;
  final SetEmployeeStatus setEmployeeStatus;

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EmployeeRepository>.value(value: repo),
        RepositoryProvider<GetAllEmployees>.value(value: getAllEmployees),
        RepositoryProvider<SetEmployeeStatus>.value(value: setEmployeeStatus),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<EmployeeBloc>(
            create: (_) => EmployeeBloc(repo),
          ),
          BlocProvider<EmployeeListBloc>(
            create: (ctx) => EmployeeListBloc(
              getAllEmployees: ctx.read<GetAllEmployees>(),
              setEmployeeStatus: ctx.read<SetEmployeeStatus>(),
            )..add(LoadEmployeeList(loader: true)),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const EmployeeListScreen(),
        ),
      ),
    );
  }
}
