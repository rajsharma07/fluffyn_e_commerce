import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_event.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_state.dart';
import 'package:fluffyn_e_commerce/core/util/my_snack_bar.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/product_view_number_of_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsAddToCartWidget extends StatelessWidget {
  const ProductDetailsAddToCartWidget(this.email, this.productId, {super.key});
  final int productId;
  final String email;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is FailureState) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              MySnackBar.showSnackBar(
                  context, state.failure.messages ?? "Something went wrong!!!");
            },
          );
        }
        if (state is SuccessState) {
          if (state.cartItemsList
              .where(
                (element) => element.productId == productId,
              )
              .isEmpty) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color.fromARGB(255, 168, 105, 22), // Button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 4, // Shadow
                ),
                onPressed: () {
                  context.read<CartBloc>().add(
                        AddToCartEvent(email, productId, state.cartItemsList),
                      );
                },
                child: const Text(
                  "Add to Card",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color
                  ),
                ),
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProductViewNumberOfItem(
                  state.cartItemsList
                      .where(
                        (element) => element.productId == productId,
                      )
                      .first
                      .quantity,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(
                          RemoveItemEvent(
                              email, productId, state.cartItemsList),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent, // Red background
                    foregroundColor: Colors.white, // White text
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text("Remove"),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<CartBloc>().add(
                          AddItemEvent(email, productId, state.cartItemsList));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Positive action color
                      foregroundColor: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Smooth corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text("Add"))
              ],
            );
          }
        }
        return const IconButton(
          onPressed: null,
          icon: Icon(Icons.shopping_cart),
        );
      },
    );
  }
}
