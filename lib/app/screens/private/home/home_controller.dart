import 'package:flutter/material.dart';
import 'package:school_app/app/screens/private/home/home_state.dart';

class HomeController extends ChangeNotifier {
  HomeState _state = HomeStateInitial();

  HomeState get state => _state;

  Future<void> getCurrentUserInfo() async {
    _changeState(HomeStateLoading());
  }

  void _changeState(HomeState newState) {
    _state = newState;
    notifyListeners();
  }
}
