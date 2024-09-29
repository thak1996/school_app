import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:school_app/app/screens/public/login/login_model.dart';
import 'package:school_app/app/screens/public/login/login_state.dart';
import 'package:school_app/app/service/auth_service.dart';
import 'package:school_app/app/utils/secure_storage.dart';

class LoginController extends ChangeNotifier {
  LoginController(this._secureStorageService, this._authService);

  final LoginModel loginModel = LoginModel();

  final SecureStorageService _secureStorageService;
  final AuthService _authService;
  LoginState _state = LoginStateInitial();

  LoginState get state => _state;

  bool validateFields() {
    loginModel.validateAll();
    notifyListeners();
    return loginModel.validateAll().isEmpty;
  }

  Future<void> login() async {
    if (!validateFields()) return;
    _changeState(LoginStateLoading());
    final result = await _authService.login(
      email: loginModel.email!,
      password: loginModel.password!,
    );
    return result.fold(
      (error) => _changeState(LoginStateFail(error.message)),
      (sucess) async {
        await _secureStorageService.write(
          key: "CURRENT_USER",
          value: jsonEncode(sucess.toJson()),
        );
        _changeState(LoginStateSuccess());
      },
    );
  }

  void _changeState(LoginState newState) {
    _state = newState;
    notifyListeners();
  }

  void updateUI() => notifyListeners();
}
