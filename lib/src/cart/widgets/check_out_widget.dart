import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_event.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_state.dart';
import 'package:fluffyn_e_commerce/core/util/my_snack_bar.dart';
import 'package:fluffyn_e_commerce/model/cart_item_model.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart' as auth;

class CheckOutWidget extends StatefulWidget {
  const CheckOutWidget(this.items, this.products, {super.key});
  final List<ProductsModel> products;
  final List<CartItemModel> items;

  @override
  State<CheckOutWidget> createState() => _CheckOutWidgetState();
}

class _CheckOutWidgetState extends State<CheckOutWidget> {
  List<int> checkList = [];
  List<bool> isChecked = [];
  @override
  void initState() {
    for (var i in widget.items) {
      checkList.add(i.productId);
      isChecked.add(true);
    }
    super.initState();
  }

  double calculateTotal() {
    double total = 0;
    for (int i = 0; i < widget.items.length; i++) {
      if (checkList.contains(widget.items[i].productId)) {
        total += widget.items[i].quantity * widget.products[i].price;
      }
    }
    return total;
  }

  String getEmail() {
    final s = context.read<AuthBloc>().state;
    return (s is auth.SuccessState) ? s.email : "";
  }

  @override
  Widget build(BuildContext context) {
    final double total = calculateTotal();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: isChecked[index],
                  onChanged: (bool? newValue) {
                    if (newValue == null || !newValue) {
                      checkList.removeWhere(
                        (element) => element == widget.items[index].productId,
                      );
                    } else {
                      checkList.add(widget.items[index].productId);
                    }
                    setState(() {
                      isChecked[index] = newValue!;
                    });
                  },
                ),
                title: Text(widget.products[index].title),
                trailing: Image.network(
                  widget.products[index].image,
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                subtitle: Row(
                  children: [
                    Text(
                      "₹${widget.products[index].price}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Quantity : ${widget.items[index].quantity}",
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            const Text("Total:"),
            Text(
              "₹${total}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
                letterSpacing: 0.5,
              ),
            ),
            const Spacer(),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is FailureState) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      MySnackBar.showSnackBar(context,
                          state.failure.messages ?? "Something went wrong!!!");
                    },
                  );
                }
                return ElevatedButton(
                  onPressed: (state is SuccessState && total > 0)
                      ? () {
                          List<double> prices = [];
                          for (int i in checkList) {
                            prices.add(widget.products
                                .where(
                                  (e) => e.id == i,
                                )
                                .first
                                .price);
                          }
                          context.read<CartBloc>().add(
                                CheckOutEvent(widget.items, checkList,
                                    getEmail(), prices),
                              );
                          Navigator.of(context).pop();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button background color
                    foregroundColor: Colors.white, // Text and icon color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                    ),
                    elevation: 5, // Shadow depth
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Place Order"),
                );
              },
            )
          ],
        )
      ],
    );
  }
}
