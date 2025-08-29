import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management/application/employee/employee_bloc.dart';

import 'package:management/application/employee_list/employee_list_bloc.dart';
import 'package:management/application/employee_list/employee_list_event.dart';
import 'package:management/application/employee_list/employee_list_state.dart';

import 'package:management/core/assets/app_assets.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/constants/app_strings.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:management/core/constants/employee_status.dart';

import 'package:management/core/utils/widgets/AppBar/AppBarWithTitle.dart';
import 'package:management/core/utils/widgets/Button/addFloatingButton.dart';
import 'package:management/core/utils/widgets/Message/messageBoxWidget.dart';
import 'package:management/core/utils/widgets/Text/AppText.dart';

import 'package:management/domain/entities/employee.dart';

import 'package:management/presentation/features/employee_list/widgets/employee_list_view.dart';
import 'package:management/presentation/features/employee_list/widgets/empty_list_view.dart';
import 'package:management/presentation/features/employee_detail/page/employee_detail_screen.dart';

/// Stateless page – uses AppSize/AppSizes for responsive dims
class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  void _reload(BuildContext context) {
    context.read<EmployeeListBloc>().add(LoadEmployeeList(loader: false));
  }

  void _deleteEmployee(BuildContext context, Employee e) {
    context.read<EmployeeBloc>().add(
      EmployeeSetStatusRequested(
        id: e.id!,
        status: EmployeeStatusHelper.toInt(EmployeeStatus.inactive),
      ),
    );

    showMessageSnackBar(
      context,
      message: AppStrings.employeeListScreenEmployeeDeletedText,
      actionText: AppStrings.messageBoxUndoText,
      onAction: () => _undoDeleteEmployee(context, e),
    );

    _reload(context);
  }

  void _undoDeleteEmployee(BuildContext context, Employee e) {
    context.read<EmployeeBloc>().add(
      EmployeeSetStatusRequested(
        id: e.id!,
        status: EmployeeStatusHelper.toInt(EmployeeStatus.active),
      ),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    _reload(context);
  }

  Future<void> _openDetail(BuildContext context, Employee? e) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Detail screen now loads itself via EmployeeLoadRequested in initState,
    // so no need to dispatch anything here.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EmployeeDetailScreen(employeeId: e?.id),
      ),
    );

    if (!context.mounted) return;

    if (result == AppStrings.createdData) {
      showMessageSnackBar(
        context,
        message: AppStrings.createSuccessMessage,
        actionText: AppStrings.messageBoxDismissText,
        onAction: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      );
      _reload(context);
    } else if (result == AppStrings.updatedData) {
      showMessageSnackBar(
        context,
        message: AppStrings.updateSuccessMessage,
        actionText: AppStrings.messageBoxDismissText,
        onAction: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      );
      _reload(context);
    } else if (result == AppStrings.deletedData && e != null) {
      // if you want to soft-delete on return, uncomment:
      _deleteEmployee(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return Scaffold(
      backgroundColor: AppColors.employeeListScreenBackground,
      appBar: const AppBarWithTitle(
        title: AppStrings.appBarEmployeeListScreenTitle,
        showDelete: false,
      ),
      body: BlocBuilder<EmployeeListBloc, EmployeeListState>(
        builder: (context, state) {
          if (state is EmployeeListLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.appBarBackground),
            );
          } else if (state is EmployeeListLoaded) {
            final employees = state.employeeList;

            // Split by current (no endDate) vs previous (has endDate)
            final current = <Employee>[];
            final previous = <Employee>[];
            for (final e in employees) {
              if (e.endDate == null) {
                current.add(e);
              } else {
                previous.add(e);
              }
            }

            return EmployeeListBody(
              current: current,
              previous: previous,
              onTapEmployee: (e) => _openDetail(context, e),
              onDismissEmployee: (e) => _deleteEmployee(context, e),
            );
          } else if (state is EmployeeListError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.employeeSectionHorizontalPadding),
                child: AppText(
                  text: state.message ?? 'Something went wrong',
                  size: AppSizes.employeeListScreenEmptyContentTextSize,
                  color: AppColors.deleteEmployeeIconBackground,
                  align: TextAlign.center,
                  fontFamily: AppTypography.robotoMedium,
                ),
              ),
            );
          }
          // Initial / empty
          return const EmptyEmployeeListView();
        },
      ),
      floatingActionButton: AddFloatingButton(
        onTap: () => _openDetail(context, null),
        iconAsset: AppAssets.addEmployeeIcon,
      ),
    );
  }
}
