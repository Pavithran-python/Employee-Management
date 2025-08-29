import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';

import 'calendar_top_widget.dart';
import 'calendar_widget.dart';
import 'calendar_bottom_widget.dart';

/// Main Calendar popup (dialog) entry point, matching your 3-piece structure.
Future<void> showCalendarPopup({
  required BuildContext context,
  required DateTime? selectedDate,
  required bool employeeJoinedCalendar, // true => Today/Next Mon/Next Tue/ +1w, false => No date / Today
  required DateTime startDate,          // min date
  required ValueChanged<DateTime?> onSelected,
  int activeTab = 0,
}) {
  return showDialog(
    context: context,
    barrierColor: AppColors.calendarPopupTransparentBackground
        .withOpacity(AppSizes.calenderPopUpTransparentBackgroundColorOpacity),
    builder: (ctx) {
      DateTime? _selected = selectedDate;
      int _active = activeTab;

      return StatefulBuilder(builder: (ctx, setState) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(ctx).size.width -
                    AppSizes.calenderPopUpWidthPadding,
                decoration: BoxDecoration(
                  color: AppColors.calendarPopupTransparentBackground,
                  borderRadius: BorderRadius.circular(
                    AppSizes.calenderPopUpBorderRadius > 25
                        ? 25
                        : AppSizes.calenderPopUpBorderRadius,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CalendarTopWidget(
                      employeeJoinedCalendar: employeeJoinedCalendar,
                      selectedDate: _selected,
                      startDate: startDate,
                      activeTab: _active,
                      onPickedQuick: (DateTime? dt, int newActive) {
                        setState(() {
                          _active = newActive;
                          _selected = dt;
                        });
                      },
                    ),

                    CalendarWidget(
                      selectedDate: _selected,
                      startDate: startDate,
                      onDayPicked: (dt) => setState(() => _selected = dt),
                    ),

                    SizedBox(height: AppSizes.calenderPopUpHeightPaddingFactor),

                    CalendarBottomWidget(
                      selectedDate: _selected,
                      onCancel: () => Navigator.pop(ctx),
                      onSave: () {
                        onSelected(_selected);
                        Navigator.pop(ctx);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    },
  );
}

/// ✔️ Compatibility shim so existing calls keep working.
/// - `allowNoDate=false` -> employeeJoinedCalendar=true
/// - `allowNoDate=true`  -> employeeJoinedCalendar=false
Future<DateTime?> showCalendarSheet(
    BuildContext context, {
      required DateTime initial,
      DateTime? minDate,
      bool allowNoDate = false,
    }) async {
  DateTime? picked = initial;
  await showCalendarPopup(
    context: context,
    selectedDate: initial,
    employeeJoinedCalendar: !allowNoDate,
    startDate: minDate ?? DateTime(AppSizes.calenderStartYear),
    onSelected: (dt) => picked = dt,
    activeTab: 0,
  );
  return picked;
}
