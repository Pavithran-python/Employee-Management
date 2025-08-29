import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:management/core/assets/app_assets.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:management/core/utils/widgets/Image/svgImage.dart';

class AppBarWithTitle extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showDelete;
  final VoidCallback? onDelete;

  const AppBarWithTitle({
    super.key,
    required this.title,
    this.showDelete = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure scaling is initialized
    AppSize.init(context);

    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.statusBar,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColors.appBarBackground,
      elevation: 0,
      toolbarHeight: AppSizes.appBarHeight * (AppSize.isDesktop ? 1.25 : 1.0),
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.employeeSectionHorizontalPadding > 20
              ? 20
              : AppSizes.employeeSectionHorizontalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title text
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppSizes.appBarTextSize *
                      (AppSize.isDesktop ? 1.25 : 1.0),
                  color: AppColors.appBarTitleText,
                  fontFamily: AppTypography.robotoMedium,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Delete button if required
            if (showDelete)
              TextButton(
                onPressed: onDelete,
                style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: SvgIcon(asset: AppAssets.deleteEmployeeIcon, fit: BoxFit.fitHeight, width: AppSizes.deleteEmployeeIconWidth *
                    (AppSize.isDesktop ? 1.25 : 1.0), height: AppSizes.deleteEmployeeIconHeight *
                    (AppSize.isDesktop ? 1.25 : 1.0)),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppSizes.appBarHeight * (AppSize.isDesktop ? 1.25 : 1.0));
}
