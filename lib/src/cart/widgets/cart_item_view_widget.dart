import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_event.dart';
import 'package:fluffyn_e_commerce/model/cart_item_model.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/product_view_number_of_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart' as auth;

class CartItemViewWidget extends StatelessWidget {
  const CartItemViewWidget(this.items, this.product, this.quantity,
      {super.key});
  final List<CartItemModel> items;
  final ProductsModel product;
  final int quantity;
  @override
  Widget build(BuildContext context) {
    final s = context.read<AuthBloc>().state;
    final String email = (s is auth.SuccessState) ? s.email : "";
    return ListTile(
      title: Text(
        product.title,
        textAlign: TextAlign.justify,
      ),
      leading: Image.network(
        product.image,
        width: MediaQuery.of(context).size.width * 0.15,
      ),
      trailing: ProductViewNumberOfItem(quantity),
      subtitle: Row(
        children: [
          Text(
            "₹${product.price}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              context.read<CartBloc>().add(
                    RemoveItemEvent(email, product.id, items),
                  );
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              elevation: 2,
            ),
            icon: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 5,
          ),
          IconButton(
            onPressed: () {
              context
                  .read<CartBloc>()
                  .add(AddItemEvent(email, product.id, items));
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.green.shade50,
              foregroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              elevation: 2,
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
