import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_event.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_state.dart';
import 'package:fluffyn_e_commerce/model/cart_item_model.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:fluffyn_e_commerce/src/cart/widgets/cart_items_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductsModel> products = [];

  @override
  Widget build(BuildContext context) {
    List<CartItemModel> items = [];
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final s = context.read<CartBloc>().state;
        items = (s is SuccessState) ? s.cartItemsList : [];
        context.read<CartBloc>().add(
              GetProductsDetailsEvent(items, products),
            );
      },
    );
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SuccessState) {
          return CartItemsListWidget(items, products);
        } else {
          return Center(
            child: TextButton(
              onPressed: () {
                context.read<CartBloc>().add(
                      GetProductsDetailsEvent(items, products),
                    );
              },
              child:
                  const Text("Something went wrong, click here to try again"),
            ),
          );
        }
      },
    );
  }
}
