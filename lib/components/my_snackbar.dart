import 'package:flutter/material.dart';

class MySnackbar {
  

  static void displayMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: EdgeInsets.all(6),
          height: 30,
          child: Text(message),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}