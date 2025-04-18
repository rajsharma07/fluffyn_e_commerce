import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      actions: [
        IconButton(
            onPressed: () {
              ctx.read<AuthBloc>().add(LogoutEvent());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ))
      ],
      backgroundColor: Colors.blue,
      title: const Text(
        "Fluffyn E-Com",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
      ),
    );
  }
}
