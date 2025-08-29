import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/constants/app_strings.dart';
import 'package:management/core/utils/widgets/Button/primaryButton.dart';
import 'package:management/core/utils/widgets/Button/secondaryButton.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({required this.onCancel, required this.onSave});
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset), // <— lift above keyboard
      child: Container(
        height: AppSizes.bottomBarHeight * (AppSize.isDesktop ? 1.25 : 1.0),
        decoration: BoxDecoration(
          color: AppColors.bottomBarBackground,
          boxShadow: [
            BoxShadow(
              color: AppColors.bottomBarShadow,
              blurRadius: AppSizes.bottomBarBlurRadiusHeight,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SecondaryButton(
              text: AppStrings.secondaryButtonText,
              onPressed: onCancel,
              width: AppSizes.secondaryButtonWidth,
              height: AppSizes.secondaryButtonHeight,
              radius: AppSizes.secondaryButtonCornerRadius,
            ),
            SizedBox(width: AppSizes.paddingBetweenPrimarySecondaryButton),
            PrimaryButton(
              text: AppStrings.primaryButtonAddEmployeeText,
              onPressed: onSave,
              width: AppSizes.primaryButtonWidth,
              height: AppSizes.primaryButtonHeight,
              radius: AppSizes.primaryButtonCornerRadius,
            ),
          ],
        ),
      ),
    );
  }
}