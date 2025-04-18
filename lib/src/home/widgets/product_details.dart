import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:fluffyn_e_commerce/provider/selected_page_provider.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/display_rating.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/product_details_add_to_cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart' as auth;
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails(this.product, {super.key});
  final ProductsModel product;
  @override
  Widget build(BuildContext context) {
    final s = context.read<AuthBloc>().state;
    String email = (s is auth.SuccessState) ? s.email : "";

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.image,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "₹${product.price}",
                style: const TextStyle(
                  fontSize: 20, // Large enough to catch attention
                  fontWeight: FontWeight.bold, // Bold for emphasis
                  color: Colors.green, // Green suggests "value" or "offer"
                  letterSpacing: 0.5, // Slight spacing for a polished look
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              DisplayRating(product.rating),
              const SizedBox(
                height: 5,
              ),
              Text("Category : ${product.category}"),
              const SizedBox(
                height: 10,
              ),
              ProductDetailsAddToCartWidget(email, product.id),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<SelectedPageProvider>(context, listen: false)
                        .changePage(2);
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // Text color
                    backgroundColor: Colors.blueAccent, // Button background
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  child: const Text("Go To Cart"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("Description:"),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.5, // Line height
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
