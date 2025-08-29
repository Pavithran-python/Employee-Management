import 'package:flutter/material.dart';
import 'package:management/core/assets/app_assets.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/utils/widgets/Image/svgImage.dart';

class DeleteBackground extends StatelessWidget {
  const DeleteBackground();

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: AppSizes.deleteEmployeeIconRightPadding),
      color: AppColors.deleteEmployeeIconBackground,
      child: SvgIcon(
        asset: AppAssets.deleteEmployeeIcon,
        fit: BoxFit.scaleDown,
        width: AppSizes.deleteEmployeeIconWidth,
        height: AppSizes.deleteEmployeeIconHeight,
      ),
    );
  }
}