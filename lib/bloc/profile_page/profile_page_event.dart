import 'package:fluffyn_e_commerce/model/user_model.dart';

abstract class ProfilePageEvent {}

class GetUserDataEvent extends ProfilePageEvent {
  String email;
  GetUserDataEvent(this.email);
}

class UpdateUserEvent extends ProfilePageEvent {
  UserModel user;
  UpdateUserEvent(this.user);
}
