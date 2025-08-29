import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:management/core/utils/widgets/Text/AppText.dart';

class EmployeeSectionTitle extends StatelessWidget {
  const EmployeeSectionTitle({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return Container(
      height: AppSizes.employeeSectionHeight * (AppSize.isDesktop ? 1.25 : 1.0),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.employeeSectionHorizontalPadding > 20
            ? 20
            : AppSizes.employeeSectionHorizontalPadding,
      ),
      child: AppText(
        text: title,
        size: AppSizes.employeeSectionTitleTextSize *
            (AppSize.isDesktop ? 1.25 : 1.0),
        color: AppColors.employeeSectionTitleText,
        align: TextAlign.start,
        fontFamily: AppTypography.robotoMedium,
      ),
    );
  }
}