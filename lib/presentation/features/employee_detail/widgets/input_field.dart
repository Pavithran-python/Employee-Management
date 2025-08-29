import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/styles/app_typography.dart';
import 'package:management/core/utils/widgets/Image/svgImage.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.controller,
    required this.hint,
    required this.prefixAsset,
    this.suffixAsset,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String hint;
  final String prefixAsset;
  final String? suffixAsset;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(width: AppSizes.textFieldOuterBorderSize, color: AppColors.textFieldBorder),
      borderRadius: BorderRadius.circular(AppSizes.textFieldOuterBorderRadius),
    );

    return SizedBox(
      height: AppSizes.textFieldEmployeeNameHeight * (AppSize.isDesktop ? 1.25 : 1.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        onTap: readOnly ? onTap : null,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.done,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        cursorColor: AppColors.appBarBackground,
        style: TextStyle(
          fontSize: AppSizes.textFieldTextSize / MediaQuery.of(context).textScaleFactor,
          color: AppColors.textFieldText,
          fontFamily: AppTypography.robotoRegular,
        ),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: AppSizes.textFieldHintTextSize / MediaQuery.of(context).textScaleFactor,
            color: AppColors.textFieldHint,
            fontFamily: AppTypography.robotoRegular,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SvgIcon(
              asset: prefixAsset,
              fit: BoxFit.scaleDown,
              width: AppSizes.employeeNameIconWidth,
              height: AppSizes.employeeNameIconHeight,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: (AppSizes.textFieldPrefixIconHorizontalPadding * 2) + AppSizes.employeeNameIconWidth,
            minHeight: AppSizes.textFieldEmployeeNameHeight,
          ),
          suffixIcon: suffixAsset == null
              ? null
              : Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SvgIcon(
              asset: suffixAsset!,
              fit: BoxFit.scaleDown,
              width: AppSizes.dropDownIconWidth,
              height: AppSizes.dropDownIconHeight,
            ),
          ),
          enabledBorder: border,
          disabledBorder: border,
          focusedBorder: readOnly
              ? border
              : OutlineInputBorder(
            borderSide: BorderSide(width: AppSizes.textFieldOuterBorderSize, color: AppColors.appBarBackground),
            borderRadius: BorderRadius.circular(AppSizes.textFieldOuterBorderRadius),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.textFieldHorizontalPadding),
        ),
      ),
    );
  }
}