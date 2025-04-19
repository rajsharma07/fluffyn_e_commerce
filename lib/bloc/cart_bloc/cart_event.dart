import 'package:fluffyn_e_commerce/model/cart_item_model.dart';
import 'package:fluffyn_e_commerce/model/products_model.dart';

abstract class CartEvent {}

class GetCartDataEvent extends CartEvent {
  final String email;
  GetCartDataEvent(this.email);
}

class AddItemEvent extends CartEvent {
  final String email;
  final int productId;
  List<CartItemModel> items;
  AddItemEvent(this.email, this.productId, this.items);
}

class RemoveItemEvent extends CartEvent {
  final String email;
  final int productId;
  List<CartItemModel> items;
  RemoveItemEvent(
    this.email,
    this.productId,
    this.items,
  );
}

class AddToCartEvent extends CartEvent {
  final String email;
  final int productId;
  List<CartItemModel> items;
  AddToCartEvent(this.email, this.productId, this.items);
}

class EmitSuccessEvent extends CartEvent {
  final List<CartItemModel> cartItemsList;
  EmitSuccessEvent(this.cartItemsList);
}

class GetProductsDetailsEvent extends CartEvent {
  final List<CartItemModel> items;
  List<ProductsModel> products;
  GetProductsDetailsEvent(this.items, this.products);
}

class CheckOutEvent extends CartEvent {
  final List<CartItemModel> items;
  final List<int> checkList;
  final String email;
  final List<double> price;
  CheckOutEvent(this.items, this.checkList, this.email, this.price);
}
