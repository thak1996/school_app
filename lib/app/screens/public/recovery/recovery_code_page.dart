import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:school_app/app/components/app_text.dart';
import 'package:school_app/app/components/app_text_form_field.dart';
import 'package:school_app/app/screens/public/recovery/recovery_controller.dart';
import 'package:school_app/app/screens/public/recovery/recovery_state.dart';
import 'package:school_app/app/service/auth_service.dart';
import 'package:school_app/app/widgets/minimal_app_bar.dart';

class RecoveryCodePage extends StatelessWidget {
  const RecoveryCodePage({super.key});

  Column header() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: const AppTextHeadlineMedium(
            "Verificar Código",
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
            controller.updateUI();
            await controller.verifyCode();
            if (controller.state is RecoveryStateSuccess) {
              Modular.to.pushReplacementNamed('/login');
            }
          },
          child: const AppTextBodyMedium("Verificar Código"),
        ),
        SizedBox(height: 16.h),
        TextButton(
          onPressed: () => Modular.to.pop(),
          child: const AppTextBodyMedium("Voltar"),
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
            label: 'Código',
            isRequired: true,
            onChanged: (value) => controller.setCode(value),
            errorMessage: controller.getCodeError(),
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
        appBar: MinimalAppBar(onBack: () => Navigator.of(context).pop()),
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
