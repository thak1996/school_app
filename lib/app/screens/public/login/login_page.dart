import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:school_app/app/components/app_text.dart';
import 'package:school_app/app/components/app_text_form_field.dart';
import 'package:school_app/app/screens/public/login/login_controller.dart';
import 'package:school_app/app/screens/public/login/login_model.dart';
import 'package:school_app/app/screens/public/login/login_state.dart';
import 'package:school_app/app/service/auth_service.dart';
import 'package:school_app/app/utils/secure_storage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Column header() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: const AppTextHeadlineMedium(
            "Login",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget footer(BuildContext context, LoginController controller) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            List<String> validationErrors = controller.loginModel.validateAll();
            controller.updateUI();
            if (validationErrors.isNotEmpty) return;
            await controller.login();
            if (controller.state is LoginStateSuccess) {
              Modular.to.pushReplacementNamed('/private-module/');
            }
          },
          child: const AppTextBodyMedium("Entrar"),
        ),
        SizedBox(height: 16.h),
        TextButton(
          onPressed: () => Modular.to.pushNamed('/recovery'),
          child: const AppTextBodyMedium("Recuperar Senha"),
        ),
      ],
    );
  }

  Widget body(BuildContext context, LoginController controller) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.2.sw),
          child: AppTextFormField(
            label: 'E-mail',
            isRequired: true,
            onChanged: (value) => controller.loginModel.setEmail = value,
            errorMessage: controller.loginModel.getError(FieldType.email),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.2.sw),
          child: AppTextFormField(
            label: 'Senha',
            isRequired: true,
            isPassword: true,
            onChanged: (value) => controller.loginModel.setPassword = value,
            errorMessage: controller.loginModel.getError(FieldType.password),
          ),
        ),
        if (controller.state is LoginStateFail)
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
            child: Align(
              alignment: Alignment.center,
              child: AppTextBodySmall(
                (controller.state as LoginStateFail).message,
                color: Colors.red,
              ),
            ),
          ),
        SizedBox(height: 0.05.sh),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(
        const SecureStorageService(),
        AuthService(),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
          child: Consumer<LoginController>(
            builder: (context, controller, _) {
              return Stack(
                children: [
                  Opacity(
                    opacity: controller.state is LoginStateLoading ? 0.5 : 1.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        header(),
                        body(context, controller),
                        footer(context, controller),
                      ],
                    ),
                  ),
                  if (controller.state is LoginStateLoading)
                    SizedBox(
                      height: 1.sh,
                      width: 1.sw,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
