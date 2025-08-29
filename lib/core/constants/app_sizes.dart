import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/// ─────────────────────────────────────────────────────────
/// AppSize: responsive scaler (call AppSize.init(context) once per build)
/// ─────────────────────────────────────────────────────────
class AppSize {
  AppSize._();

  /// Design reference (your original Figma/base size)
  static const double _designWidth = 428;
  static const double _designHeight = 926;

  static late MediaQueryData _mq;
  static late double _scaleW;
  static late double _scaleH;
  static late double _textScale;

  static Size get screenSize => _mq.size;
  static double get screenWidth => _mq.size.width;
  static double get screenHeight => _mq.size.height;

  /// Device detection using breakpoints (not orientation)
  static bool get isDesktop => screenWidth >= 1024;                 // Laptops & Desktops
  static bool get isTablet  => screenWidth >= 600 && screenWidth < 1024; // Tablets
  static bool get isMobile  => screenWidth < 600;                   // Phones

  /// Must be called before using any sizes (e.g., in your top-level widget build)
  static void init(BuildContext context) {
    _mq = MediaQuery.of(context);
    _scaleW = screenWidth / _designWidth;
    _scaleH = screenHeight / _designHeight;

    // use the smaller scale for text to keep balance across orientations
    _textScale = math.min(_scaleW, _scaleH);
  }

  /// Width-scaled
  static double w(double v) => v * _scaleW;

  /// Height-scaled
  static double h(double v) => v * _scaleH;

  /// Radius/shape-scaled (uses min scale)
  static double r(double v) => v * math.min(_scaleW, _scaleH);

  /// Font-scaled (independent from system text scale)
  static double sp(double v) => v * _textScale;
}

/// Syntactic sugar: 16.w, 12.h, 10.r, 14.sp
extension AppSizeNumX on num {
  double get w => AppSize.w(toDouble());
  double get h => AppSize.h(toDouble());
  double get r => AppSize.r(toDouble());
  double get sp => AppSize.sp(toDouble());
}

/// ─────────────────────────────────────────────────────────
/// AppSizes: all concrete tokens migrated from your SizeConfig
/// Use .w/.h/.r/.sp so everything is responsive
/// ─────────────────────────────────────────────────────────
class AppSizes {
  AppSizes._();

  // Screen (reference)
  static const double designScreenWidth = 428;
  static const double designScreenHeight = 926;

  // ───── Images / Icons ─────

  // Add Employee Icon
  static double get addEmployeeIconWidth => 18.w;
  static double get addEmployeeIconHeight => 18.h;
  static double get addEmployeeIconBackgroundWidth => 50.w;
  static double get addEmployeeIconBackgroundHeight => 50.h;
  static double get addEmployeeIconBackgroundCornerRadius => 8.r;

  // Calendar Icons
  static double get calenderIconWidth => 24.w;
  static double get calenderIconHeight => 24.h;
  static double get calenderArrowIconWidth => 24.w;
  static double get calenderArrowIconHeight => 24.h;

  // Delete Employee Icon
  static double get deleteEmployeeIconWidth => 25.68.w;
  static double get deleteEmployeeIconHeight => 24.h;
  static double get deleteEmployeeIconRightPadding => 17.1.w;

  // Dropdown Arrow Icon
  static double get dropDownIconWidth => 20.w;
  static double get dropDownIconHeight => 20.h;

  // Employee Name Icon
  static double get employeeNameIconWidth => 24.w;
  static double get employeeNameIconHeight => 24.h;

  // Employee Role Icon
  static double get employeeRoleIconWidth => 24.w;
  static double get employeeRoleIconHeight => 24.h;

  // Empty Data Icon
  static double get emptyDataIconWidth => 262.w;
  static double get emptyDataIconHeight => 219.h;

  // To Arrow Icon
  static double get toArrowIconWidth => 20.w;
  static double get toArrowIconHeight => 20.h;

  // ───── Message Box ─────
  static double get messageBoxHeight => 40.h;
  static double get messageBoxHorizontalPadding => 16.w;
  static double get messageBoxMessageTextSize => 15.sp;
  static double get messageBoxUndoTextSize => 15.sp;
  static const int messageBoxMessageShowDurationSeconds = 5;

  // ───── App Bar ─────
  static double get appBarHeight => 60.h;
  static double get appBarTextSize => 18.sp;
  static double get appBarHorizontalPadding => 16.w;

  // ───── Primary Button ─────
  static double get primaryButtonWidth => 73.w;
  static double get primaryButtonHeight => 40.h;
  static double get primaryButtonTextSize => 14.sp;
  static double get primaryButtonCornerRadius => 6.r;

  // ───── Secondary Button ─────
  static double get secondaryButtonWidth => 73.w;
  static double get secondaryButtonHeight => 40.h;
  static double get secondaryButtonTextSize => 14.sp;
  static double get secondaryButtonCornerRadius => 6.r;
  static double get paddingBetweenPrimarySecondaryButton => 16.w;

  // ───── Bottom Bar ─────
  static double get bottomBarHeight => 62.h;
  static double get bottomBarBlurRadiusHeight => 2.h;
  static double get bottomBarHorizontalPadding => 16.w;

  // ───── Employee Section Title ─────
  static double get employeeSectionHeight => 56.h;
  static double get employeeSectionTitleTextSize => 16.sp;
  static double get employeeSectionHorizontalPadding => 16.w;

  // ───── TextField Section ─────
  static double get textFieldHorizontalPadding => 16.w;
  static double get textFieldHorizontalInnerPadding => 12.w;
  static double get textFieldEmployeeNameWidth => 396.w;
  static double get textFieldEmployeeNameHeight => 40.h;
  static double get textFieldEmployeeRoleWidth => 396.w;
  static double get textFieldEmployeeRoleHeight => 40.h;
  static double get textFieldEmployeeDateWidth => 172.w;
  static double get textFieldEmployeeDateHeight => 40.h;
  static double get textFieldHintTextSize => 16.sp;
  static double get textFieldTextSize => 16.sp;
  static double get textFieldOuterBorderRadius => 4.r;
  static double get textFieldOuterBorderSize => 1.r;
  static double get textFieldPrefixIconHorizontalPadding => 8.w;
  static double get textFieldSuffixIconHorizontalPadding => 10.w;

  // ───── Employee ListView ─────
  static double get employeeListviewEmployeeNameTextSize => 16.sp;
  static double get employeeListviewEmployeeRoleTextSize => 14.sp;
  static double get employeeListviewEmployeeDateTextSize => 12.sp;
  static double get employeeListviewBetweenPaddingHeight => 6.h;
  static double get employeeListviewPadding => 16.w;
  static double get employeeListviewSeparatePadding => 1.h;

  // ───── Show Bottom Sheet ─────
  static const double bottomSheetTransparentColorOpacity = 0.4;
  static double get bottomSheetCornerRadius => 16.r;

  // ───── Employee Role ListView ─────
  static double get employeeRoleListviewHeight => 52.h;
  static double get employeeRoleListviewTextSize => 16.sp;
  static double get employeeRoleListviewGapPadding => 0.5.h;

  // ───── Employee List Screen ─────
  static double get employeeListScreenEmptyContentTextSize => 18.sp;
  static double get employeeListScreenSwipeRightTextSize => 15.sp;
  static double get employeeListScreenSwipeRightTextHorizontalPadding => 16.w;
  static double get employeeListScreenSwipeRightTextVerticalPadding => 12.h;

  // ───── Employee Detail Screen ─────
  static double get employeeDetailScreenHorizontalPadding => 16.w;
  static double get employeeDetailScreenTopTextFieldPadding => 24.h;

  // ───── Calendar Pop-Up ─────
  static const double calenderPopUpTransparentBackgroundColorOpacity = 0.4;
  static double get calenderPopUpWidthPadding => 32.w;
  static double get calenderPopUpBorderRadius => 16.r;
  /// multiplier for screen height when you want relative height
  static const double calenderPopUpHeightPaddingFactor = 0.75;

  // ───── Calendar Top Widget ─────
  static double get calenderTopWidgetTopPadding => 24.h;
  static double get calenderTapButtonWidth => 174.w;
  static double get calenderTapButtonHeight => 36.h;
  static double get calenderTapButtonRadius => 4.r;
  static double get calenderTabButtonBetweenPadding => 16.w;

  // ───── Calendar Bottom Widget ─────
  static double get paddingBetweenCalenderText => 12.h;
  static double get calenderNoDateTextSize => 16.sp;
  static double get paddingBetweenTwoButton => 16.w;

  // ───── Calendar Widget ─────
  static double get calenderHorizontalPadding => 16.w;
  static double get calenderHeaderHorizontalPadding => 75.w;
  static double get calenderHeaderVerticalPadding => 15.h;
  static double get calenderDateBorderWidth => 1.r;
  static double get dateTextSize => 15.sp;
  static double get rowWeekHeight => 37.h;
  static double get rowHeight => 42.h;

  // ───── Calendar Years ─────
  static const int calenderStartYear = 1900;
  static const int calenderEndYear = 2100;
}
