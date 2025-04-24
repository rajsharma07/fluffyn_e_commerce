import 'package:fluffyn_e_commerce/core/error/failures.dart';
import 'package:fluffyn_e_commerce/model/user_model.dart';

abstract class ProfilePageState {}

class SuccessState extends ProfilePageState {
  final UserModel user;
  SuccessState(this.user);
}

class LoadingState extends ProfilePageState {}

class FailureState extends ProfilePageState {
  Failure failure;
  FailureState(this.failure);
}
