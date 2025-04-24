abstract class ProfilePageEvent {}

class GetUserData extends ProfilePageEvent {
  String email;
  GetUserData(this.email);
}

class UpdatePhoneNumber extends ProfilePageEvent {
  String email;
  UpdatePhoneNumber(this.email);
}
