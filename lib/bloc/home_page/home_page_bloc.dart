import 'package:fluffyn_e_commerce/bloc/home_page/home_page_event.dart';
import 'package:fluffyn_e_commerce/bloc/home_page/home_page_state.dart';
import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:fluffyn_e_commerce/core/http_requests/get_request.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(InitialState()) {
    on<GetDataEvent>(
      (event, emit) async {
        emit(LoadingState());
        try {
          final result =
              await GetRequest.getRequest("https://fakestoreapi.com/products");
          result.fold(
            (l) {
              final List list = l;
              final List<ProductsModel> products = [];
              for (var i in list) {
                products.add(
                  ProductsModel.fromJson(i),
                );
              }
              emit(
                SuccessState(products),
              );
            },
            (r) {},
          );
        } catch (error) {
          emit(
            FailureState(
              Failure("Something went wrong!!"),
            ),
          );
        }
      },
    );
  }
}
