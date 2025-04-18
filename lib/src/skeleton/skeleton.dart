import 'package:fluffyn_e_commerce/provider/selected_page_provider.dart';
import 'package:fluffyn_e_commerce/src/cart/pages/cart_page.dart';
import 'package:fluffyn_e_commerce/src/home/pages/home_page.dart';
import 'package:fluffyn_e_commerce/src/products_listing/pages/product_listing_page.dart';
import 'package:fluffyn_e_commerce/src/profile/pages/profile_page.dart';
import 'package:fluffyn_e_commerce/src/skeleton/widgets/my_app_bar.dart';
import 'package:fluffyn_e_commerce/src/skeleton/widgets/my_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});
  final List<Widget> widgets = const [
    HomePage(),
    ProductListingPage(),
    CartPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SelectedPageProvider(),
      child: Scaffold(
        appBar: MyAppBar.getAppBar(context),
        body: Consumer<SelectedPageProvider>(
          builder: (context, value, child) {
            return widgets[value.getSelected()];
          },
        ),
        bottomNavigationBar: MyBottomNavigationBar(),
      ),
    );
  }
}
