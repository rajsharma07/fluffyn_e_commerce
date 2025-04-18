import 'package:fluffyn_e_commerce/bloc/home_page/home_page_bloc.dart';
import 'package:fluffyn_e_commerce/bloc/home_page/home_page_event.dart';
import 'package:fluffyn_e_commerce/src/home/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomePageBloc()..add(GetDataEvent());
      },
      child: const ProductsList(),
    );
  }
}
