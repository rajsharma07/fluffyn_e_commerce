import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_state.dart';
import 'package:fluffyn_e_commerce/core/util/my_snack_bar.dart';
import 'package:fluffyn_e_commerce/provider/selected_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({super.key});
  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(icon: Icon(Icons.add), label: "Products"),
    BottomNavigationBarItem(
        icon: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is FailureState) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  MySnackBar.showSnackBar(context,
                      state.failure.messages ?? "Something went wrong!!!");
                },
              );
            }
            return Badge(
              isLabelVisible:
                  (state is SuccessState && state.cartItemsList.isNotEmpty),
              label: (state is SuccessState && state.cartItemsList.isNotEmpty)
                  ? Text(
                      state.cartItemsList
                          .map(
                            (e) => e.quantity,
                          )
                          .reduce(
                            (value, element) => (value + element),
                          )
                          .toString(),
                    )
                  : null,
              child: const Icon(Icons.shopping_cart),
            );
          },
        ),
        label: "Cart"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
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
