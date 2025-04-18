import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';

abstract class HomePageState {}

class SuccessState extends HomePageState {
  List<ProductsModel> products;
  SuccessState(this.products);
}

class InitialState extends HomePageState {}

class LoadingState extends HomePageState {}

class FailureState extends HomePageState {
  Failure failure;
  FailureState(this.failure);
}
