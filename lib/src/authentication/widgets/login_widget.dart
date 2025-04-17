import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_event.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart';
import 'package:fluffyn_e_commerce/core/util/my_snack_bar.dart';
import 'package:fluffyn_e_commerce/provider/auth_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";

  void loginUser() {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      context.read<AuthBloc>().add(LogInEvent(email, password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          const Text(
            "Login",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Email"),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            onSaved: (newValue) {
              email = newValue!;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Password"),
            ),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 8) {
                return 'Password must be at least 8 characters long';
              }
              return null;
            },
            onSaved: (newValue) {
              password = newValue!;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is FailureState) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (timeStamp) {
                    MySnackBar.showSnackBar(
                      context,
                      state.failure.messages ?? "Something went wrong!!",
                    );
                  },
                );
              }
              return ElevatedButton(
                onPressed: (state is LoadingState) ? null : loginUser,
                child: (state is LoadingState)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const Text("Login"),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              Provider.of<AuthPageProvider>(context, listen: false).change(1);
            },
            child: const Text("Dont't have an account? Register"),
          )
        ],
      ),
    );
  }
}
