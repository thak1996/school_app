abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {
  final String? message;

  LoginStateSuccess([this.message]);
}

class LoginStateFail extends LoginState {
  final String message;

  LoginStateFail(this.message);
}
