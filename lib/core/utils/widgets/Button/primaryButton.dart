import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/styles/app_typography.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.radius,
  });

  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    final w = width ?? AppSizes.primaryButtonWidth;
    final h = (height ?? AppSizes.primaryButtonHeight) * (AppSize.isDesktop ? 1.25 : 1.0);
    final r = (radius ?? AppSizes.primaryButtonCornerRadius);
    final textSize = AppSizes.primaryButtonTextSize * (AppSize.isDesktop ? 1.25 : 1.0);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        foregroundColor: AppColors.primaryButtonText,
        backgroundColor: AppColors.primaryButtonBackground,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fixedSize: Size(w, h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(r > 8 ? 8 : r)),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        textScaler: const TextScaler.linear(1.0),
        style: TextStyle(
          fontSize: textSize,
          color: AppColors.primaryButtonText,
          fontFamily: AppTypography.robotoMedium,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
