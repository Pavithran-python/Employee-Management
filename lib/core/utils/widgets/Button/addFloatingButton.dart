import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/utils/widgets/Image/svgImage.dart';

class AddFloatingButton extends StatelessWidget {
  const AddFloatingButton({
    super.key,
    required this.onTap,
    required this.iconAsset, // pass your AppAssets.addEmployeeIcon
  });

  final VoidCallback onTap;
  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    // clamp to 50 like original behavior
    final double box = (AppSizes.addEmployeeIconBackgroundWidth > 50)
        ? 50
        : AppSizes.addEmployeeIconBackgroundWidth;

    return SizedBox(
      width: box,
      height: box,
      child: FloatingActionButton(
        onPressed: onTap,
        elevation: 2,
        splashColor: Colors.white,
        backgroundColor: AppColors.addEmployeeIconBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            (AppSizes.addEmployeeIconBackgroundCornerRadius > 10)
                ? 10
                : AppSizes.addEmployeeIconBackgroundCornerRadius,
          ),
        ),
        child: SvgIcon(
          asset: iconAsset,
          fit: BoxFit.scaleDown,
          width: AppSizes.addEmployeeIconWidth,
          height: AppSizes.addEmployeeIconHeight,
        ),
      ),
    );
  }
}
