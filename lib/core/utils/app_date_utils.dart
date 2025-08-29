import 'dart:core';

class AppDateUtils {
  AppDateUtils._();

  // Short month names used for format/parse (English).
  static const List<String> _monthsShort = <String>[
    'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
  ];

  /// Format a date as `d MMM, yyyy` (e.g., `5 Feb, 2024`).
  /// Returns empty string when `date` is null.
  static String formatDMMMYYYY(DateTime? date) {

    if (date == null) return '';
    final m = (date.month >= 1 && date.month <= 12) ? _monthsShort[date.month - 1] : '';
    final d = date.day.toString();
    final y = date.year.toString();
    return '$d $m, $y';
  }

  /// Parse a `d MMM, yyyy` string into a DateTime in local time.
  static DateTime? parseDMMMYYYY(String input) {
    if (input.trim().isEmpty) return null;

    // Normalize spaces and comma
    final norm = input.trim().replaceAll(RegExp(r'\s+'), ' ');
    final match = RegExp(r'^(\d{1,2})\s+([A-Za-z]{3}),\s*(\d{4})$').firstMatch(norm);
    if (match == null) return null;

    final day = int.tryParse(match.group(1)!);
    final monTxt = match.group(2)!.toLowerCase();
    final year = int.tryParse(match.group(3)!);
    if (day == null || year == null) return null;

    final monthIndex = _monthsShort.indexWhere((m) => m.toLowerCase() == monTxt);
    if (monthIndex < 0) return null;

    final month = monthIndex + 1;
    // Validate day range by constructing safely
    try {
      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }

  /// True if [date] is today (local).
  static bool isToday(DateTime? date, {DateTime? now}) {
    if (date == null) return false;
    final n = now ?? DateTime.now();
    return date.year == n.year && date.month == n.month && date.day == n.day;
  }

  /// Mirrors your `checkNextWeeCondition` logic:
  /// returns true if (now - [days]) > [date].
  static bool isBeforeNowMinusDays({
    required DateTime date,
    required int days,
    DateTime? now,
  }) {
    final n = now ?? DateTime.now();
    final threshold = n.subtract(Duration(days: days));
    return threshold.compareTo(date) > 0;
  }

  /// Days until the *next* Monday from [from] (Mon=1..Sun=7).
  static int daysUntilNextMonday(DateTime from) {
    final wd = from.weekday; // 1..7
    return (8 - wd) % 7 == 0 ? 7 : (8 - wd) % 7;
  }

  /// Days until the *next* Tuesday from [from] (Tue=2).
  static int daysUntilNextTuesday(DateTime from) {
    final wd = from.weekday; // 1..7
    if (wd == DateTime.monday) return 1;
    final delta = (9 - wd) % 7;
    return delta == 0 ? 7 : delta;
  }
}
