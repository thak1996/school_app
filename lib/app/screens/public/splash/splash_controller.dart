import 'package:flutter/material.dart';
import 'package:school_app/app/screens/public/splash/splash_state.dart';

class SplashController extends ChangeNotifier {
  SplashController() {
    checkLogin();
  }

  SplashState _state = SplashStateInitial();

  SplashState get state => _state;

  Future<void> checkLogin() async {
    _changeState(SplashStateLoading());
    await Future.delayed(const Duration(seconds: 2));
    _changeState(SplashStateFail('Erro ao verificar login'));
  }

  void _changeState(SplashState newState) {
    _state = newState;
    notifyListeners();
  }
}
