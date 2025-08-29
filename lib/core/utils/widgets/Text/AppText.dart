import 'package:flutter/material.dart';
import 'package:management/core/constants/app_sizes.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.align,
    required this.fontFamily,
    this.softWrap = true,
    this.maxLines,
    this.fontWeight,
  });

  final String text;
  final double size;     // design size -> use AppSizes tokens like AppSizes.employeeListviewEmployeeNameTextSize
  final Color color;
  final TextAlign align;
  final String fontFamily;
  final bool softWrap;
  final int? maxLines;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    AppSize.init(context);
    return Text(
      text,
      textAlign: align,
      softWrap: softWrap,
      overflow: softWrap ? null : TextOverflow.ellipsis,
      maxLines: maxLines,
      textScaler: const TextScaler.linear(1.0),
      style: TextStyle(
        fontSize: size,           // already scaled via AppSizes token you pass in
        color: color,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
