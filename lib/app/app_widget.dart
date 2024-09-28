import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({
    super.key,
    this.savedThemeMode,
  });
  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1280, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, widget) {
        return AdaptiveTheme(
          debugShowFloatingThemeButton: false,
          initial: savedThemeMode ?? AdaptiveThemeMode.dark,
          light: ThemeData.light(),
          dark: ThemeData.dark(),
          builder: (theme, darkTheme) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'School App',
            darkTheme: darkTheme,
            theme: ThemeData(primaryColor: Colors.blue),
            routerDelegate: Modular.routerDelegate,
            routeInformationParser: Modular.routeInformationParser,
          ),
        );
      },
    );
  }
}
