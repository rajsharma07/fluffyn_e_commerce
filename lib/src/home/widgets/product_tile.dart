import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/display_rating.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/product_details.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/product_tile_add_to_cart_button_widget.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.product, {super.key});
  final ProductsModel product;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        onTap: () {
          showBottomSheet(
            backgroundColor: const Color.fromARGB(255, 227, 227, 227),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.75),
            enableDrag: true,
            showDragHandle: true,
            context: context,
            builder: (context) {
              return ProductDetails(product);
            },
          );
        },
        leading: Image.network(
          product.image,
          width: MediaQuery.of(context).size.width * 0.2,
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.justify,
        ),
        trailing: ProductTileAddToCartButtonWidget(product),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category : ${product.category}"),
            Text(
              "₹${product.price}",
              style: const TextStyle(
                fontSize: 20, // Large enough to catch attention
                fontWeight: FontWeight.bold, // Bold for emphasis
                color: Colors.green, // Green suggests "value" or "offer"
                letterSpacing: 0.5, // Slight spacing for a polished look
              ),
            ),
            DisplayRating(product.rating),
          ],
        ),
      ),
    );
  }
}
