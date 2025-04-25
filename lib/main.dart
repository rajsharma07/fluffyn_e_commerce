import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_event.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_event.dart';
import 'package:fluffyn_e_commerce/core/theme/app_theme.dart';
import 'package:fluffyn_e_commerce/src/authentication/pages/auth_page.dart';
import 'package:fluffyn_e_commerce/src/skeleton/skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: BlocProvider(
        create: (context) {
          return AuthBloc()
            ..add(
              InitializeEvent(),
            );
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is SuccessState) {
              return BlocProvider(
                  create: (context) => CartBloc()
                    ..add(
                      GetCartDataEvent(state.email),
                    ),
                  child: const Skeleton());
            } else {
              return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
