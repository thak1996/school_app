import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:school_app/app/components/app_text.dart';
import 'package:school_app/app/components/app_text_form_field.dart';
import 'package:school_app/app/screens/public/recovery/recovery_controller.dart';
import 'package:school_app/app/screens/public/recovery/recovery_state.dart';
import 'package:school_app/app/service/auth_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RecoveryPage extends StatelessWidget {
  const RecoveryPage({super.key});

  Column header() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: const AppTextHeadlineMedium(
            "Recuperar Senha",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget footer(BuildContext context, RecoveryController controller) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            if (controller.getEmailError() != null) {
              controller.updateUI();
              return;
            }
            await controller.sendRecoveryCode();
            if (context.mounted) {
              if (controller.state is RecoveryStateSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      (controller.state as RecoveryStateSuccess).message ?? '',
                    ),
                  ),
                );
              }
            }
          },
          child: const AppTextBodyMedium("Enviar Código"),
        ),
        SizedBox(height: 16.h),
        TextButton(
          onPressed: () {
            Modular.to.pushNamed('/code');
          },
          child: const AppTextBodyMedium("Já possui um código?"),
        ),
      ],
    );
  }

  Widget body(BuildContext context, RecoveryController controller) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.2.sw),
          child: AppTextFormField(
            label: 'E-mail',
            isRequired: true,
            onChanged: (value) => controller.setEmail(value),
            errorMessage: controller.getEmailError(),
          ),
        ),
        if (controller.state is RecoveryStateFail)
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
            child: Align(
              alignment: Alignment.center,
              child: AppTextBodySmall(
                (controller.state as RecoveryStateFail).message,
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
      create: (_) => RecoveryController(AuthService()),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
          child: Consumer<RecoveryController>(
            builder: (context, controller, _) {
              return Stack(
                children: [
                  Opacity(
                    opacity:
                        controller.state is RecoveryStateLoading ? 0.5 : 1.0,
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
                  if (controller.state is RecoveryStateLoading)
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
