import 'package:flutter/material.dart';
import 'package:school_app/app/models/user_model.dart';
import 'package:school_app/app/screens/private/home/home_state.dart';
import 'package:school_app/app/service/auth_service.dart';

class HomeController extends ChangeNotifier {
  HomeController(this._authFirebase) {
    getCurrentUserInfo();
  }

  final AuthService _authFirebase;
  UserModel _currentUser = UserModel.empty();
  HomeState _state = HomeStateInitial();

  UserModel get currentUser => _currentUser;

  Future<void> signOut() async => _authFirebase.signOut();

  HomeState get state => _state;

  Future<void> getCurrentUserInfo() async {
    _changeState(HomeStateLoading());
    final result = await _authFirebase.getUser();
    result.fold(
      (error) => _changeState(HomeStateFail(error.message)),
      (success) {
        _currentUser = UserModel.fromMap(success.toMap());
        _changeState(HomeStateSuccess());
      },
    );
  }

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }
}
