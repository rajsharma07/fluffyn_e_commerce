import 'package:fluffyn_e_commerce/provider/selected_page_provider.dart';
import 'package:fluffyn_e_commerce/src/skeleton/widgets/my_app_bar.dart';
import 'package:fluffyn_e_commerce/src/skeleton/widgets/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectedPageProvider(),
      child: Scaffold(
        appBar: MyAppBar.getAppBar(context),
        body: const Center(
          child: Text("Hello Welcome"),
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
