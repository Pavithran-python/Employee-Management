import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/constants/app_strings.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:management/core/utils/app_date_utils.dart';
import 'package:management/core/utils/widgets/Text/AppText.dart';
import 'package:management/domain/entities/employee.dart';

class EmployeeListTile extends StatelessWidget {
  const EmployeeListTile({
    required this.employee,
    required this.onTap,
  });

  final Employee employee;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    final from = employee.joinedDate != null ? (AppDateUtils.isToday(employee.joinedDate)?AppStrings.todayText:AppDateUtils.formatDMMMYYYY(employee.joinedDate)) : '';
    final hasEnd = employee.endDate != null;
    final rangeText = hasEnd
        ? '$from - ${(AppDateUtils.isToday(employee.endDate)?AppStrings.todayText:AppDateUtils.formatDMMMYYYY(employee.endDate))}'
        : '${AppStrings.employeeListviewFromText}${from.isEmpty ? AppStrings.todayText : from}';

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        color: AppColors.employeeListviewBackground,
        child: Padding(
          padding: EdgeInsets.all(
            (AppSize.isDesktop ? 20.w : AppSizes.employeeSectionHorizontalPadding)
                .clamp(0, 20.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: employee.name,
                size: AppSizes.employeeListviewEmployeeNameTextSize *
                    (AppSize.isDesktop ? 1.25 : 1.0),
                color: AppColors.employeeListviewNameText,
                align: TextAlign.start,
                fontFamily: AppTypography.robotoMedium,
              ),
              SizedBox(height: AppSizes.employeeListviewBetweenPaddingHeight),
              AppText(
                text: employee.role,
                size: AppSizes.employeeListviewEmployeeRoleTextSize *
                    (AppSize.isDesktop ? 1.25 : 1.0),
                color: AppColors.employeeListviewRoleText,
                align: TextAlign.start,
                fontFamily: AppTypography.robotoRegular,
              ),
              SizedBox(height: AppSizes.employeeListviewBetweenPaddingHeight),
              AppText(
                text: rangeText,
                size: AppSizes.employeeListviewEmployeeDateTextSize *
                    (AppSize.isDesktop ? 1.25 : 1.0),
                color: AppColors.employeeListviewDateText,
                align: TextAlign.start,
                fontFamily: AppTypography.robotoRegular,
              ),
            ],
          ),
        ),
      ),

    );
  }
}