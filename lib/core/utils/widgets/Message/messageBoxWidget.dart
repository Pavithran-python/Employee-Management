import 'package:flutter/material.dart';
import 'package:management/core/constants/app_colors.dart';
import 'package:management/core/constants/app_sizes.dart';
import 'package:management/core/styles/app_typography.dart';

SnackBar buildMessageSnackBar({
  required String message,
  required String actionText,
  required VoidCallback onAction,
}) {
  return SnackBar(
    duration: Duration(seconds: AppSizes.messageBoxMessageShowDurationSeconds),
    padding: EdgeInsets.zero,
    backgroundColor: AppColors.messageBoxBackground,
    content: SizedBox(
      height: AppSizes.messageBoxHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.messageBoxHorizontalPadding,
              ),
              child: Text(
                message,
                overflow: TextOverflow.ellipsis,
                textScaler: const TextScaler.linear(1.0),
                style: TextStyle(
                  fontSize: AppSizes.messageBoxMessageTextSize,
                  color: AppColors.messageBoxMessageText,
                  fontFamily: AppTypography.robotoRegular,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              minimumSize: Size.zero,
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.messageBoxHorizontalPadding,
              ),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              actionText,
              textScaler: const TextScaler.linear(1.0),
              style: TextStyle(
                fontSize: AppSizes.messageBoxUndoTextSize,
                color: AppColors.messageBoxUndo,
                fontFamily: AppTypography.robotoRegular,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showMessageSnackBar(
    BuildContext context, {
      required String message,
      required String actionText,
      required VoidCallback onAction,
    }) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      buildMessageSnackBar(
        message: message,
        actionText: actionText,
        onAction: onAction,
      ),
    );
}
