import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/constants/app_strings.dart';
import 'package:management/core/utils/app_date_utils.dart';
import 'package:management/core/utils/widgets/Button/calenderTabButton.dart';

class CalendarTopWidget extends StatelessWidget {
  const CalendarTopWidget({
    super.key,
    required this.employeeJoinedCalendar,
    required this.selectedDate,
    required this.startDate,
    required this.activeTab,
    required this.onPickedQuick,
  });

  /// true => Today / Next Monday / Next Tuesday / After 1 week
  /// false => No date / Today
  final bool employeeJoinedCalendar;

  final DateTime? selectedDate;
  final DateTime startDate;
  final int activeTab;

  /// (pickedDateOrNull, newActiveTab)
  final void Function(DateTime?, int) onPickedQuick;

  @override
  Widget build(BuildContext context) {
    final corner = Radius.circular(
      AppSizes.calenderPopUpBorderRadius > 25
          ? 25
          : AppSizes.calenderPopUpBorderRadius,
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.calendarTopBackground,
        borderRadius: BorderRadius.vertical(top: corner),
      ),
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        top: AppSizes.calenderTopWidgetTopPadding,
        bottom: AppSizes.calenderTopWidgetTopPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (employeeJoinedCalendar) ...[
            // Row 1: Today / Next Monday
            _row(
              [
                _btn(
                  text: AppStrings.tabButtonTodayText,
                  active: activeTab == 1,
                  onTap: () => onPickedQuick(DateTime.now(), 1),
                ),
                _spacer(),
                _btn(
                  text: AppStrings.tabButtonNextMondayText,
                  active: activeTab == 2,
                  onTap: () {
                    final base = selectedDate ?? DateTime.now();
                    final dt =
                    base.add(Duration(days: AppDateUtils.daysUntilNextMonday(base)));
                    onPickedQuick(dt, 2);
                  },
                ),
              ],
            ),
            SizedBox(height: AppSizes.calenderTabButtonBetweenPadding),

            // Row 2: Next Tuesday / After 1 week
            _row(
              [
                _btn(
                  text: AppStrings.tabButtonNextTuesdayText,
                  active: activeTab == 3,
                  onTap: () {
                    final base = selectedDate ?? DateTime.now();
                    final dt =
                    base.add(Duration(days: AppDateUtils.daysUntilNextTuesday(base)));
                    onPickedQuick(dt, 3);
                  },
                ),
                _spacer(),
                _btn(
                  text: AppStrings.tabButtonWeekText,
                  active: activeTab == 4,
                  onTap: () {
                    final base = selectedDate ?? DateTime.now();
                    onPickedQuick(base.add(const Duration(days: 7)), 4);
                  },
                ),
              ],
            ),
          ] else ...[
            // End-date mode: No date / Today
            _row(
              [
                _btn(
                  text: AppStrings.tabButtonNoDateText,
                  active: activeTab == 2,
                  onTap: () => onPickedQuick(null, 2),
                ),
                _spacer(),
                _btn(
                  text: AppStrings.tabButtonTodayText,
                  active: activeTab == 1,
                  onTap: () {
                    // keep the same guard as your worked code
                    if (DateTime.now().isAfter(startDate)) {
                      onPickedQuick(DateTime.now(), 1);
                    }
                  },
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // helpers
  Widget _row(List<Widget> children) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(children: children),
  );

  Widget _spacer() =>
      SizedBox(width: AppSizes.paddingBetweenCalenderText);

  Widget _btn({
    required String text,
    required bool active,
    required VoidCallback onTap,
  }) {
    return CalendarTabButton(
      text: text,
      active: active,
      onPressed: onTap,
      width: AppSizes.calenderTapButtonWidth,
      height: AppSizes.calenderTapButtonHeight,
      radius: AppSizes.calenderTapButtonRadius,
    );
  }
}
