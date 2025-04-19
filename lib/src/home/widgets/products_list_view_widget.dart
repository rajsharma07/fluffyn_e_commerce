import 'package:fluffyn_e_commerce/bloc/home_page/home_page_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/home_page/home_page_event.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsListViewWidget extends StatefulWidget {
  const ProductsListViewWidget(this.products, {super.key});
  final List<ProductsModel> products;
  @override
  State<ProductsListViewWidget> createState() => _ProductsListViewWidgetState();
}

class _ProductsListViewWidgetState extends State<ProductsListViewWidget> {
  void _refresh(BuildContext ctx) {
    ctx.read<HomePageBloc>().add(GetDataEvent());
  }

  String query = "";
  @override
  Widget build(BuildContext context) {
    List<ProductsModel> filteredList = widget.products
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search for products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {
                query = value;
              });
            },
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              _refresh(context);
            },
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return ProductTile(filteredList[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
