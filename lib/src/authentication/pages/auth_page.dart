import 'package:fluffyn_e_commerce/provider/auth_page_provider.dart';
import 'package:fluffyn_e_commerce/src/authentication/widgets/login_widget.dart';
import 'package:fluffyn_e_commerce/src/authentication/widgets/register_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  final pages = const [
    LoginWidget(),
    RegisterWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthPageProvider(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/logo.png"),
              const SizedBox(
                height: 20,
              ),
              Consumer<AuthPageProvider>(
                builder: (context, value, child) {
                  return pages[value.getPage()];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
