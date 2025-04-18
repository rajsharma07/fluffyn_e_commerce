import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_event.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_state.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart' as auth;
import 'package:fluffyn_e_commerce/src/home/widgets/product_view_number_of_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTileAddToCartButtonWidget extends StatelessWidget {
  const ProductTileAddToCartButtonWidget(this.product, {super.key});
  final ProductsModel product;
  @override
  Widget build(BuildContext context) {
    final s = context.read<AuthBloc>().state;
    String email = (s is auth.SuccessState) ? s.email : "";

    return Builder(builder: (context) {
      return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is SuccessState) {
          if (state.cartItemsList
              .where(
                (element) => element.productId == product.id,
              )
              .isEmpty) {
            return IconButton(
              onPressed: () {
                context.read<CartBloc>().add(
                    AddToCartEvent(email, product.id, state.cartItemsList));
              },
              icon: const Icon(Icons.add_shopping_cart),
            );
          } else {
            return ProductViewNumberOfItem(state.cartItemsList
                .where(
                  (element) => element.productId == product.id,
                )
                .first
                .quantity);
          }
        }
        return const IconButton(
            onPressed: null, icon: Icon(Icons.shopping_cart));
      });
    });
  }
}
