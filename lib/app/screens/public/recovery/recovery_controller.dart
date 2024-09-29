import 'package:flutter/material.dart';
import 'package:school_app/app/screens/public/recovery/recovery_model.dart';
import 'package:school_app/app/screens/public/recovery/recovery_state.dart';
import 'package:school_app/app/service/auth_service.dart';

class RecoveryController extends ChangeNotifier {
  RecoveryController(this._authService) : recoveryModel = RecoveryModel();

  final AuthService _authService;
  final RecoveryModel recoveryModel;
  RecoveryState _state = RecoveryStateInitial();

  RecoveryState get state => _state;

  void updateUI() => notifyListeners();

  void setEmail(String email) => recoveryModel.setEmail = email;
  void setCode(String code) => recoveryModel.setCode = code;

  String? getEmailError() => recoveryModel.getError('email');
  String? getCodeError() => recoveryModel.getError('code');

  Future<void> sendRecoveryCode() async {
    recoveryModel.validateEmail();
    if (recoveryModel.getError('email') != null) return;

    _changeState(RecoveryStateLoading());
    final result =
        await _authService.sendRecoveryCode(email: recoveryModel.email!);
    result.fold(
      (error) => _changeState(RecoveryStateFail(error.message)),
      (sucess) {
        _changeState(RecoveryStateSuccess(
            "Código enviado com sucesso! Código: $sucess"));
      },
    );
  }

  Future<void> verifyCode() async {
    recoveryModel.validateCode();
    if (recoveryModel.getError('code') != null) return;

    _changeState(RecoveryStateLoading());
    final result =
        await _authService.validateResetCode(code: recoveryModel.code!);
    result.fold(
      (error) => _changeState(RecoveryStateFail(error.message)),
      (success) =>
          _changeState(RecoveryStateSuccess("Código verificado com sucesso!")),
    );
  }

  void _changeState(RecoveryState newState) {
    _state = newState;
    notifyListeners();
  }
}
