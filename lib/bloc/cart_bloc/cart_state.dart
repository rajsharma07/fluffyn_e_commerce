import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:fluffyn_e_commerce/model/cart_item_model.dart';

abstract class CartState {}

class SuccessState extends CartState {
  List<CartItemModel> cartItemsList;
  SuccessState(this.cartItemsList);
}

class InitialState extends CartState {}

class LoadingState extends CartState {}

class FailureState extends CartState {
  Failure failure;
  List<CartItemModel> cartItemsList;
  FailureState(this.failure, this.cartItemsList);
}
