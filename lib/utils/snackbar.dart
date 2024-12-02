import 'package:flutter/material.dart';
import 'package:item_expo_theme_package/item_expo_colors.dart';

void showSnackbar({
  required BuildContext context,
  required String message,
  required double marginBottom,
  Color colorSnack = ItemExpoColors.lightGray,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: marginBottom, left: 16, right: 16),
      duration: const Duration(seconds: 3),
      backgroundColor: colorSnack,
    ),
  );
}