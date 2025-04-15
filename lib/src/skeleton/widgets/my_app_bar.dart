import 'package:flutter/material.dart';

class MyAppBar {
  static AppBar getAppBar(BuildContext ctx) {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/logo.png"),
        ),
      ),
      backgroundColor: Colors.blue,
      title: const Text(
        "Fluffyn E-Com",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
      ),
    );
  }
}
