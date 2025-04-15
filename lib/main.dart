import 'package:fluffyn_e_commerce/core/theme/app_theme.dart';
import 'package:fluffyn_e_commerce/src/skeleton/skeleton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: const Skeleton(),
    );
  }
}
