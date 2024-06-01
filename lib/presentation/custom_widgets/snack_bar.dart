import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(BuildContext context, String message,
      {String? actionLabel,
      VoidCallback? onAction,
      Color backgroundColor = Colors.blue,
      Color textColor = Colors.white,
      Color actionColor = Colors.yellow,
      Duration duration = const Duration(seconds : 3)}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: actionColor,
              onPressed: onAction ?? () {},
            )
          : null,
    );

    // Show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
