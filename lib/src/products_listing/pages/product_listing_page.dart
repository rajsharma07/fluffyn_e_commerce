import 'package:fluffyn_e_commerce/bloc/authentication/auth_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/produtcs_bloc/products_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/produtcs_bloc/products_event.dart';
import 'package:fluffyn_e_commerce/bloc/produtcs_bloc/products_state.dart';
import 'package:fluffyn_e_commerce/core/storage/sqflite_db/database_product_handling.dart';
import 'package:fluffyn_e_commerce/core/util/my_snack_bar.dart';
import 'package:fluffyn_e_commerce/provider/local_image_provider.dart';
import 'package:fluffyn_e_commerce/src/products_listing/widgets/add_product_widget.dart';
import 'package:fluffyn_e_commerce/src/products_listing/widgets/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/authentication/auth_state.dart' as auth;
import 'package:provider/provider.dart';

class ProductListingPage extends StatelessWidget {
  const ProductListingPage({super.key});
  String getEmail(BuildContext ctx) {
    final s = ctx.read<AuthBloc>().state;
    return (s is auth.SuccessState) ? s.email : "";
  }

  @override
  Widget build(BuildContext context) {
    final String email = getEmail(context);
    return BlocProvider(
      create: (context) => ProductsBloc()..add(GetProductsEvent(email)),
      child: Scaffold(
        floatingActionButton:
            BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
          return FloatingActionButton(
            onPressed: () async {
              int id = await getNewId();
              id++;
              final ctx = context;
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => ProductsBloc(),
                        child: AddProductWidget(ctx, email, id),
                      );
                    },
                  );
                },
              );
            },
            tooltip: 'Add Product',
            child: const Icon(Icons.add),
          );
        }),
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is FailureState) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  MySnackBar.showSnackBar(context,
                      state.failure.messages ?? "Something went wrong!!!");
                },
              );
              return Center(
                child: TextButton(
                  onPressed: () {
                    context.read<ProductsBloc>().add(
                          GetProductsEvent(email),
                        );
                  },
                  child: const Text("Click here to Try again!!"),
                ),
              );
            } else if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessState) {
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(state.products[index].title),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              final ctx = context;
                              showBottomSheet(
                                context: context,
                                enableDrag: true,
                                showDragHandle: true,
                                builder: (context) {
                                  return BlocProvider(
                                    create: (context) => ProductsBloc(),
                                    child: EditProductWidget(
                                      ctx,
                                      email,
                                      state.products[index],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ),
                      leading: ChangeNotifierProvider(
                        create: (context) => LocalImageProvider(
                          state.products[index].id.toString(),
                        ),
                        child: Consumer<LocalImageProvider>(
                          builder: (context, value, child) {
                            return value.getImage() == null
                                ? const Text("NA")
                                : Image.file(value.getImage()!);
                          },
                        ),
                      ),
                      subtitle: Text("₹${state.products[index].price}"),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<ProductsBloc>().add(
                                RemoveProductEvent(
                                  email,
                                  state.products[index].id,
                                ),
                              );
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: Text("Products"),
            );
          },
        ),
      ),
    );
  }
}
