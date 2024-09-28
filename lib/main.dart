import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/app_module.dart';
import 'package:school_app/app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(savedThemeMode: savedThemeMode),
    ),
  );
}
