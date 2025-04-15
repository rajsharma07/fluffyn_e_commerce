import 'package:fluffyn_e_commerce/provider/selected_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});
  final List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: "Products"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedPageProvider>(
      builder: (context, value, child) {
        return BottomNavigationBar(
          currentIndex: value.getSelected(),
          items: items,
          selectedItemColor: const Color.fromARGB(255, 4, 76, 117),
          unselectedItemColor: const Color.fromARGB(158, 10, 39, 128),
          onTap: (v) {
            value.changePage(v);
          },
        );
      },
    );
  }
}
