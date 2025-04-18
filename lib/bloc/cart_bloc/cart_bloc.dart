import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_event.dart';
import 'package:fluffyn_e_commerce/bloc/cart_bloc/cart_state.dart';
import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:fluffyn_e_commerce/core/storage/sqflite_db/database_cart_handling.dart';
import 'package:fluffyn_e_commerce/model/cart_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(InitialState()) {
    on<AddToCartEvent>(addToCartEventHandler);

    on<AddItemEvent>(addItemEventHandler);

    on<RemoveItemEvent>(removeItemEventHandler);

    on<GetCartDataEvent>(getCartDataEventHandler);

    on<DeleteFromCartEvent>(deleteFromCartEventHandler);

    on<EmitSuccessEvent>(emitSuccessEventHandler);
  }

  void addItemEventHandler(AddItemEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingState());
      await incrementProductQuantity(event.productId, event.email);
      event.items.where(
        (element) {
          return element.productId == event.productId;
        },
      ).forEach(
        (element) {
          element.quantity++;
        },
      );
      emit(SuccessState(event.items));
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
          event.items,
        ),
      );
    }
  }

  void removeItemEventHandler(
      RemoveItemEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingState());
      await decrementProductQuantity(event.productId, event.email);
      bool isEmpty = false;
      event.items.where(
        (element) {
          return element.productId == event.productId;
        },
      ).forEach(
        (element) {
          element.quantity--;
          if (element.quantity == 0) {
            isEmpty = true;
          }
        },
      );
      if (isEmpty) {
        event.items.removeWhere(
          (element) => element.productId == event.productId,
        );
      }
      emit(SuccessState(event.items));
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
          event.items,
        ),
      );
    }
  }

  void getCartDataEventHandler(
      GetCartDataEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingState());
      final result = await getCompleteCart(event.email);
      emit(SuccessState(result));
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
          [],
        ),
      );
    }
  }

  void addToCartEventHandler(
      AddToCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingState());
      await addToCart(
        CartItemModel(
            productId: event.productId, userId: event.email, quantity: 1),
      );
      event.items.add(
        CartItemModel(
            productId: event.productId, userId: event.email, quantity: 1),
      );
      emit(SuccessState(event.items));
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
          event.items,
        ),
      );
    }
  }

  void deleteFromCartEventHandler(
      DeleteFromCartEvent event, Emitter<CartState> emit) async {
    try {
      emit(LoadingState());
      await removeCartData(event.productId, event.email);
      event.items.removeWhere(
        (element) => element.productId == event.productId,
      );
      emit(SuccessState(event.items));
    } catch (error) {
      emit(
        FailureState(
          Failure("Something went wrong!!!"),
          event.items,
        ),
      );
    }
  }

  void emitSuccessEventHandler(
      EmitSuccessEvent event, Emitter<CartState> emit) {
    emit(SuccessState(event.cartItemsList));
  }
}
