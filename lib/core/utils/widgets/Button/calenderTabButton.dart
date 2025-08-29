import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/styles/app_typography.dart';

class CalendarTabButton extends StatelessWidget {
  const CalendarTabButton({
    super.key,
    required this.text,
    required this.active,
    required this.onPressed,
    this.width,
    this.height,
    this.radius,
  });

  final String text;
  final bool active;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);

    final w = width ?? AppSizes.calenderTapButtonWidth;
    final h = (height ?? AppSizes.calenderTapButtonHeight) * (AppSize.isDesktop ? 1.5 : 1.0);
    final r = (radius ?? AppSizes.calenderTapButtonRadius);
    final textSize = AppSizes.primaryButtonTextSize * (AppSize.isDesktop ? 1.25 : 1.0);

    final bg = active ? AppColors.primaryButtonBackground : AppColors.secondaryButtonBackground;
    final fg = active ? AppColors.primaryButtonText : AppColors.secondaryButtonText;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        foregroundColor: fg,
        backgroundColor: bg,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fixedSize: Size(w, h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(r > 8 ? 8 : r)),
        ),
      ),
      child: Text(
        text,
        textScaler: const TextScaler.linear(1.0),
        style: TextStyle(
          fontSize: textSize,
          color: fg,
          fontFamily: AppTypography.robotoMedium,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
