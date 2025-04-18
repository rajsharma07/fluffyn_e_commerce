abstract class AuthEvent {}

class LogInEvent extends AuthEvent {
  String email;
  String password;
  LogInEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  String email;
  String password;
  RegisterEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}

class InitializeEvent extends AuthEvent {}
