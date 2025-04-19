import 'package:fluffyn_e_commerce/bloc/home_page/home_page_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/home_page/home_page_event.dart';
import 'package:fluffyn_e_commerce/bloc/home_page/home_page_state.dart';
import 'package:fluffyn_e_commerce/core/util/my_snack_bar.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/products_list_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is FailureState) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              MySnackBar.showSnackBar(
                context,
                state.failure.messages ?? "Something went wrong!!",
              );
            },
          );
          return TextButton(
            onPressed: () {
              context.read<HomePageBloc>().add(GetDataEvent());
            },
            child: const Text("Error occured Click here to retry"),
          );
        } else if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SuccessState) {
          return ProductsListViewWidget(state.products);
        }
        return Center(
          child: TextButton(
            onPressed: () {
              context.read<HomePageBloc>().add(GetDataEvent());
            },
            child: const Text("Click Here to get Data"),
          ),
        );
      },
    );
  }
}
