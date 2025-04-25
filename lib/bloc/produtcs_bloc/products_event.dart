import 'package:fluffyn_e_commerce/model/products_model.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {
  String email;
  GetProductsEvent(this.email);
}

class AddProductEvent extends ProductsEvent {
  String email;
  ProductsModel product;
  AddProductEvent(this.email, this.product);
}

class RemoveProductEvent extends ProductsEvent {
  String email;
  int id;
  RemoveProductEvent(this.email, this.id);
}

class UpdateProductEvent extends ProductsEvent {
  ProductsModel product;
  String email;
  UpdateProductEvent(this.email, this.product);
}
