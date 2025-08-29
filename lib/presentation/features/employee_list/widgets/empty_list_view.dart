
import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/constants/app_strings.dart';
import 'package:management/core/assets/app_assets.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:management/core/utils/widgets/Image/svgImage.dart';
import 'package:management/core/utils/widgets/Text/AppText.dart';

class EmptyEmployeeListView extends StatelessWidget {
  const EmptyEmployeeListView();

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    return Container(
      color: AppColors.employeeListScreenBackground,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgIcon(
            asset: AppAssets.emptyDataImage,
            fit: BoxFit.scaleDown,
            width: AppSizes.emptyDataIconWidth,
            height: AppSizes.emptyDataIconHeight,
          ),
          SizedBox(height: 12.h),
          AppText(
            text: AppStrings.employeeListScreenEmptyContentText,
            size: AppSizes.employeeListScreenEmptyContentTextSize,
            color: AppColors.employeeListScreenEmptyText,
            align: TextAlign.center,
            fontFamily: AppTypography.robotoMedium,
          ),
        ],
      ),
    );
  }
}
