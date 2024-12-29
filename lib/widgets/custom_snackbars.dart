import 'package:flutter/material.dart';

class CustomSnackbars {
  final BuildContext context;

  CustomSnackbars(this.context);

  void success(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
