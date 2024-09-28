abstract class SplashState {}

class SplashStateInitial extends SplashState {}

class SplashStateLoading extends SplashState {}

class SplashStateSuccess extends SplashState {}

class SplashStateFail extends SplashState {
  final String message;

  SplashStateFail(this.message);
}
