abstract class RecoveryState {}

class RecoveryStateInitial extends RecoveryState {}

class RecoveryStateLoading extends RecoveryState {}

class RecoveryStateSuccess extends RecoveryState {
  final String? message;

  RecoveryStateSuccess([this.message]);
}

class RecoveryStateFail extends RecoveryState {
  final String message;

  RecoveryStateFail(this.message);
}
