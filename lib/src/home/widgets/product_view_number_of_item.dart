import 'package:flutter/material.dart';

class ProductViewNumberOfItem extends StatelessWidget {
  const ProductViewNumberOfItem(this.count, {super.key});
  final int count;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            size: 30,
          ),
          onPressed: () {
            // Navigate to your cart screen
          },
        ),
        Positioned(
          right: 14,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Text(
              count
                  .toString(), // Replace this with your dynamic cart item count
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
