import 'package:fluffyn_e_commerce/bloc/produtcs_bloc/products_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/produtcs_bloc/products_event.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:fluffyn_e_commerce/src/products_listing/widgets/product_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductWidget extends StatefulWidget {
  const AddProductWidget(this.ctx, this.email, this.id, {super.key});
  final int id;
  final String email;
  final BuildContext ctx;
  @override
  State<AddProductWidget> createState() => _AddProductState();
}

class _AddProductState extends State<AddProductWidget> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  double price = 0.0;
  String category = "";
  String? titleValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a title';
    }
    if (value.trim().length < 3) {
      return 'Title must be at least 3 characters long';
    }
    if (value.trim().length > 100) {
      return 'Title cannot be more than 100 characters';
    }
    return null;
  }

  String? priceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the price';
    }

    final parsedPrice = double.tryParse(value.trim());
    if (parsedPrice == null) {
      return 'Enter a valid number';
    }

    if (parsedPrice <= 0) {
      return 'Price must be greater than 0';
    }

    return null;
  }

  void addProduct() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      context.read<ProductsBloc>().add(
            AddProductEvent(
              widget.email,
              ProductsModel(
                id: widget.id,
                title: title,
                price: price,
                description: description,
                category: category,
                image: "",
                rating: Rating(0, 0),
              ),
            ),
          );
    }
    widget.ctx.read<ProductsBloc>().add(
          GetProductsEvent(widget.email),
        );
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ProductImageWidget(widget.id.toString()),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Product Title',
                    hintText: 'Enter product name',
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                  ),
                  validator: titleValidator,
                  onSaved: (newValue) {
                    title = newValue!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: 'Enter product price',
                    prefixIcon: const Icon(Icons.currency_rupee_sharp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                  ),
                  validator: priceValidator,
                  onSaved: (newValue) {
                    price = double.parse(newValue!);
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter product description',
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a description';
                    }
                    if (value.trim().length < 10) {
                      return 'Description must be at least 10 characters long';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    description = newValue!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    hintText: 'Enter product category',
                    prefixIcon: const Icon(Icons.category),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    category = newValue!;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: addProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 24),
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: const Text('Add Product'),
                ),
              ],
            ),
          )),
    );
  }
}
