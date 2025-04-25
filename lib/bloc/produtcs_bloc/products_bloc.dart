import 'package:fluffyn_e_commerce/bloc/produtcs_bloc/products_event.dart';
import 'package:fluffyn_e_commerce/bloc/produtcs_bloc/products_state.dart';
import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:fluffyn_e_commerce/core/storage/sqflite_db/database_product_handling.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(InitialState()) {
    on<GetProductsEvent>(getProductsEventHandler);
    on<AddProductEvent>(addProductEventHandler);
    on<RemoveProductEvent>(removeProductEventhandler);
    on<UpdateProductEvent>(updateProductEvent);
  }

  Future<void> getProductsEventHandler(
      GetProductsEvent event, Emitter<ProductsState> emit) async {
    try {
      emit(LoadingState());
      emit(
        SuccessState(
          await getProducts(event.email),
        ),
      );
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
        ),
      );
    }
  }

  Future<void> addProductEventHandler(
      AddProductEvent event, Emitter<ProductsState> emit) async {
    try {
      emit(LoadingState());
      await addProduct(event.product, event.email);
      emit(
        SuccessState(
          await getProducts(event.email),
        ),
      );
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
        ),
      );
    }
  }

  Future<void> removeProductEventhandler(
      RemoveProductEvent event, Emitter<ProductsState> emit) async {
    try {
      emit(LoadingState());
      removeProduct(event.id, event.email);
      emit(
        SuccessState(
          await getProducts(event.email),
        ),
      );
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
        ),
      );
    }
  }

  Future<void> updateProductEvent(
      UpdateProductEvent event, Emitter<ProductsState> emit) async {
    try {
      emit(LoadingState());
      await updateProduct(event.product, event.email);
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
        ),
      );
    }
  }
}
