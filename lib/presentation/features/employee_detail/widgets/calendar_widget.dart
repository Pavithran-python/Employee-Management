import 'package:flutter/material.dart';
import 'package:management/core/assets/app_assets.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:intl/intl.dart';
import 'package:management/core/utils/widgets/Image/svgImage.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
    required this.selectedDate,
    required this.startDate,
    required this.onDayPicked,
  });

  final DateTime? selectedDate;
  final DateTime startDate;
  final ValueChanged<DateTime> onDayPicked;

  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor;

    return Container(
      width: double.infinity,
      color: AppColors.calendarBackground,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.calenderHorizontalPadding),
      child: TableCalendar(
        availableGestures: AvailableGestures.none,
        sixWeekMonthsEnforced: true,
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(
          formatButtonShowsNext: false,
          formatButtonVisible: false,
          headerMargin: EdgeInsets.zero,
          headerPadding: EdgeInsets.only(
            left: AppSizes.calenderHeaderHorizontalPadding,
            right: AppSizes.calenderHeaderHorizontalPadding,
            bottom: AppSizes.calenderHeaderVerticalPadding,
          ),
          titleCentered: true,
          formatButtonPadding: EdgeInsets.zero,
          leftChevronMargin: EdgeInsets.zero,
          rightChevronMargin: EdgeInsets.zero,
          leftChevronPadding: EdgeInsets.zero,
          rightChevronPadding: EdgeInsets.zero,
          leftChevronIcon: SvgIcon(
            asset: AppAssets.calenderLeftArrowIcon,
            fit: BoxFit.scaleDown,
            width: AppSizes.calenderArrowIconWidth,
            height: AppSizes.calenderArrowIconHeight,
          ),
          rightChevronIcon: SvgIcon(
            asset: AppAssets.calenderRightArrowIcon,
            fit: BoxFit.scaleDown,
            width: AppSizes.calenderArrowIconWidth,
            height: AppSizes.calenderArrowIconHeight,
          ),
          titleTextFormatter: (d, _) => DateFormat('MMMM yyyy').format(d),
          titleTextStyle: TextStyle(
            fontSize: (18 + 0).toDouble(),
            fontFamily: AppTypography.robotoMedium,
            color: const Color(0xFF323238),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        currentDay: DateTime.now(),
        firstDay: startDate,
        lastDay: DateTime(AppSizes.calenderEndYear),
        focusedDay: selectedDate ?? startDate,
        daysOfWeekHeight: AppSizes.rowWeekHeight,
        rowHeight: AppSizes.rowHeight,
        calendarStyle: CalendarStyle(
          cellPadding: EdgeInsets.zero,
          tablePadding: EdgeInsets.zero,
          cellMargin: EdgeInsets.zero,
          markerMargin: EdgeInsets.zero,
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: selectedDate == null ? null : AppColors.calendarSelectedDate,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: AppSizes.calenderDateBorderWidth,
              color: AppColors.calendarSelectedDate,
            ),
          ),
          defaultTextStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: AppColors.calendarDefaultText,
          ),
          weekendTextStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: AppColors.calendarDefaultText,
          ),
          outsideTextStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: AppColors.calendarDisabledText,
          ),
          disabledTextStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: AppColors.calendarDisabledText,
          ),
          selectedTextStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: selectedDate == null
                ? AppColors.calendarDefaultText
                : AppColors.calendarUnselectedText,
          ),
          todayTextStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: AppColors.calendarSelectedDate,
          ),
          weekNumberTextStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: AppColors.calendarDefaultText,
          ),
          rangeEndTextStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: AppColors.calendarDisabledText,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: AppColors.calendarWeekTitle,
          ),
          weekendStyle: TextStyle(
            fontSize: _sz(AppSizes.dateTextSize, scale),
            fontFamily: AppTypography.robotoRegular,
            color: AppColors.calendarWeekTitle,
          ),
        ),
        selectedDayPredicate: (day) => isSameDay(selectedDate, day),
        onDaySelected: (sel, _) => onDayPicked(sel),
      ),
    );
  }

  double _sz(double base, double scale) => base / scale;
}
