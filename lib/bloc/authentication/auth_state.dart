import 'package:fluffyn_e_commerce/core/error/failures.dart';

abstract class AuthState {}

class SuccessState extends AuthState {
  String email;
  SuccessState(this.email);
}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class FailureState extends AuthState {
  Failures failure;
  FailureState(this.failure);
}
