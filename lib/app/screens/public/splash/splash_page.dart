import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:school_app/app/components/app_text.dart';
import 'package:school_app/app/screens/public/splash/splash_controller.dart';
import 'package:school_app/app/screens/public/splash/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  Widget _buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlutterLogo(size: 150.spMax),
        SizedBox(height: 16.h),
        const AppTextBodyMedium('Bem-vindo à minha aplicação!'),
        SizedBox(height: 16.h),
        const CircularProgressIndicator(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashController(),
      child: Scaffold(
        body: Center(
          child: Consumer<SplashController>(
            builder: (context, controller, _) {
              switch (controller.state) {
                case SplashStateSuccess():
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Modular.to.pushReplacementNamed('/private-module/');
                  });
                  return _buildLoading();
                case SplashStateFail():
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Modular.to.pushReplacementNamed('/login');
                  });
                  return _buildLoading();
                case SplashStateLoading():
                default:
                  return _buildLoading();
              }
            },
          ),
        ),
      ),
    );
  }
}
