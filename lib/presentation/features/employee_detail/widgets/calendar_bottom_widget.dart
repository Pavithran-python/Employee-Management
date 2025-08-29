import 'package:flutter/material.dart';
import 'package:management/core/assets/app_assets.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/constants/app_strings.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:management/core/utils/app_date_utils.dart';
import 'package:management/core/utils/widgets/Image/svgImage.dart';

// your shared buttons
import 'package:management/core/utils/widgets/Button/primaryButton.dart';
import 'package:management/core/utils/widgets/Button/secondaryButton.dart';

class CalendarBottomWidget extends StatelessWidget {
  const CalendarBottomWidget({
    super.key,
    required this.selectedDate,
    required this.onCancel,
    required this.onSave,
  });

  final DateTime? selectedDate;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final text = selectedDate == null
        ? AppStrings.tabButtonNoDateText
        : (AppDateUtils.isToday(selectedDate!)
        ? AppStrings.todayText
        : AppDateUtils.formatDMMMYYYY(selectedDate!));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.calendarBottomBackground,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppSizes.calenderPopUpBorderRadius),
        ),
      ),
      padding: EdgeInsets.all(AppSizes.calenderPopUpBorderRadius),
      child: Row(
        children: [
          // date pill
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgIcon(
                  asset: AppAssets.calenderIcon,
                  fit: BoxFit.scaleDown,
                  width: AppSizes.calenderIconWidth,
                  height: AppSizes.calenderIconHeight,
                ),
                SizedBox(width: AppSizes.paddingBetweenCalenderText),
                Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppSizes.calenderNoDateTextSize,
                      color: AppColors.calendarNoDateText,
                      fontFamily: AppTypography.robotoRegular,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SecondaryButton(
                text: AppStrings.secondaryButtonText,
                width: AppSizes.secondaryButtonWidth,
                height: AppSizes.secondaryButtonHeight,
                radius: AppSizes.secondaryButtonCornerRadius,
                onPressed: onCancel,
              ),
              SizedBox(width: AppSizes.paddingBetweenTwoButton),
              PrimaryButton(
                text: AppStrings.primaryButtonAddEmployeeText,
                width: AppSizes.primaryButtonWidth,
                height: AppSizes.primaryButtonHeight,
                radius: AppSizes.primaryButtonCornerRadius,
                onPressed: onSave,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
