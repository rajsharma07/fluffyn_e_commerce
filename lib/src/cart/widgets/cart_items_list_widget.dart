import 'package:fluffyn_e_commerce/model/cart_item_model.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:fluffyn_e_commerce/provider/selected_page_provider.dart';
import 'package:fluffyn_e_commerce/src/cart/widgets/cart_item_view_widget.dart';
import 'package:fluffyn_e_commerce/src/cart/widgets/check_out_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemsListWidget extends StatelessWidget {
  const CartItemsListWidget(this.items, this.products, {super.key});
  final List<ProductsModel> products;
  final List<CartItemModel> items;
  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (int i = 0; i < items.length; i++) {
      if (items[i].productId != products[i].id) {
        products.removeAt(i);
      }
      total += items[i].quantity * products[i].price;
    }
    return (items.isEmpty)
        ? Center(
            child: TextButton(
              onPressed: () {
                Provider.of<SelectedPageProvider>(context, listen: false)
                    .changePage(0);
              },
              child: const Text(
                "Cart is Emprty\nClick Here to View Products ",
                textAlign: TextAlign.center,
              ),
            ),
          )
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return CartItemViewWidget(
                        items, products[index], items[index].quantity);
                  },
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Total: ',
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  Text(
                    '₹$total',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          showBottomSheet(
                            enableDrag: true,
                            showDragHandle: true,
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.7),
                            context: context,
                            builder: (context) {
                              return CheckOutWidget(items, products);
                            },
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                        label: const Text(
                          "CheckOut",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        )),
                  )
                ],
              )
            ],
          );
  }
}
