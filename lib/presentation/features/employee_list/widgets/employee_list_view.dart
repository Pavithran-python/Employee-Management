
import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/constants/app_strings.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:management/core/utils/widgets/Text/AppText.dart';
import 'package:management/domain/entities/employee.dart';

import 'delete_background.dart';
import 'employee_section_title.dart';
import 'employee_tile.dart';
import 'empty_list_view.dart';

class EmployeeListBody extends StatelessWidget {
  const EmployeeListBody({
    required this.current,
    required this.previous,
    required this.onTapEmployee,
    required this.onDismissEmployee,
  });

  final List<Employee> current;
  final List<Employee> previous;
  final ValueChanged<Employee> onTapEmployee;
  final ValueChanged<Employee> onDismissEmployee;

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    if (current.isEmpty && previous.isEmpty) {
      return const EmptyEmployeeListView();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (current.isNotEmpty)
            EmployeeSectionTitle(title: AppStrings.employeeSectionTitleCurrentEmployeeText),
          if (current.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              itemCount: current.length,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) =>
                  SizedBox(height: AppSizes.employeeListviewSeparatePadding),
              itemBuilder: (_, i) => Dismissible(
                key: Key('current_${current[i].id}'),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => onDismissEmployee(current[i]),
                background: const DeleteBackground(),
                child: EmployeeListTile(
                  employee: current[i],
                  onTap: () => onTapEmployee(current[i]),
                ),
              ),
            ),

          if (previous.isNotEmpty)
            EmployeeSectionTitle(title: AppStrings.employeeSectionTitlePreviousEmployeeText),
          if (previous.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              itemCount: previous.length,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) =>
                  SizedBox(height: AppSizes.employeeListviewSeparatePadding),
              itemBuilder: (_, i) => Dismissible(
                key: Key('previous_${previous[i].id}'),
                direction: DismissDirection.endToStart,
                onDismissed: (_) => onDismissEmployee(previous[i]),
                background: const DeleteBackground(),
                child: EmployeeListTile(
                  employee: previous[i],
                  onTap: () => onTapEmployee(previous[i]),
                ),
              ),
            ),

          // Swipe hint
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.employeeListviewBetweenPaddingHeight+AppSizes.employeeListviewBetweenPaddingHeight,
              horizontal: AppSizes.employeeSectionHorizontalPadding > 20
                  ? 20
                  : AppSizes.employeeSectionHorizontalPadding,
            ),
            child: AppText(
              text: AppStrings.employeeListScreenSwipeToDeleteText,
              size: AppSizes.employeeListScreenSwipeRightTextSize *
                  (AppSize.isDesktop ? 1.25 : 1.0),
              color: AppColors.employeeListScreenSwipeRightText,
              align: TextAlign.start,
              fontFamily: AppTypography.robotoRegular,
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}