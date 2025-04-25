import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';

abstract class ProductsState {}

class SuccessState extends ProductsState {
  List<ProductsModel> products;
  SuccessState(this.products);
}

class InitialState extends ProductsState {}

class LoadingState extends ProductsState {}

class FailureState extends ProductsState {
  Failure failure;
  FailureState(this.failure);
}
