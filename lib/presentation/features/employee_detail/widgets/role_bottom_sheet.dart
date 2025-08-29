import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/constants/employee_roles.dart';
import 'package:management/core/styles/app_typography.dart';

Future<String?> showRoleBottomSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: false,
    enableDrag: true,
    backgroundColor: AppColors.employeeListviewBackground,
    barrierColor: AppColors.bottomSheetTransparent
        .withOpacity(AppSizes.bottomSheetTransparentColorOpacity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(
          AppSizes.bottomSheetCornerRadius > 25
              ? 25
              : AppSizes.bottomSheetCornerRadius,
        ),
      ),
    ),
    builder: (context) {
      final roles = EmployeeRoles.all;

      return ListView.builder(
        shrinkWrap: true,
        itemCount: roles.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final role = roles[index];
          final topRadius = Radius.circular(
            AppSizes.bottomSheetCornerRadius > 25
                ? 25
                : AppSizes.bottomSheetCornerRadius,
          );

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.employeeRoleListBackground,
                  borderRadius: index == 0
                      ? BorderRadius.only(
                    topLeft: topRadius,
                    topRight: topRadius,
                  )
                      : BorderRadius.zero,
                ),
                child: TextButton(
                  onPressed: () => Navigator.pop(context, role),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: index == 0
                          ? BorderRadius.only(
                        topLeft: topRadius,
                        topRight: topRadius,
                      )
                          : BorderRadius.zero,
                    ),
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: AppSizes.employeeRoleListviewHeight *
                        (AppSize.isDesktop ? 1.5 : 1.0),
                    child: Center(
                      child: Text(
                        role,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize:
                          AppSizes.employeeRoleListviewTextSize *
                              (AppSize.isDesktop ? 1.25 : 1.0),
                          color: AppColors.employeeRoleListText,
                          fontFamily: AppTypography.robotoRegular,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // spacing ONLY between items (not after last)
              if (index != roles.length - 1)
                Container(width: double.infinity,color:AppColors.bottomSheetBackground,height:  AppSizes.employeeRoleListviewGapPadding),
            ],
          );
        },
      );
    },
  );
}
