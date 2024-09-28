abstract class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateSuccess extends HomeState {
  final String? message;

  HomeStateSuccess([this.message]);
}

class HomeStateFail extends HomeState {
  final String message;

  HomeStateFail(this.message);
}
