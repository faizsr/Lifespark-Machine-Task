import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlerts {
  static SnackBar snackBar(String message) {
    return SnackBar(
      showCloseIcon: true,
      closeIconColor: Colors.black,
      margin: const EdgeInsets.all(20),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: CupertinoColors.destructiveRed,
      elevation: 0,
      content: Text(
        message,
        style: const TextStyle(color: Colors.black),
      ),
      duration: const Duration(seconds: 3),
    );
  }
}
