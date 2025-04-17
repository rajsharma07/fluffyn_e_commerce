import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class MySnackBar {
  static void showSnackBar(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
