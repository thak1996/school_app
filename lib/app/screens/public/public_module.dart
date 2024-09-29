import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:school_app/app/screens/public/login/login_controller.dart';
import 'package:school_app/app/screens/public/login/login_page.dart';
import 'package:school_app/app/screens/public/recovery/recovery_code_page.dart';
import 'package:school_app/app/screens/public/recovery/recovery_controller.dart';
import 'package:school_app/app/screens/public/recovery/recovery_page.dart';
import 'package:school_app/app/screens/public/splash/splash_controller.dart';
import 'package:school_app/app/screens/public/splash/splash_page.dart';
import 'package:school_app/app/service/auth_service.dart';
import 'package:school_app/app/utils/secure_storage.dart';

class PublicModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<LoginController>(
      () => LoginController(const SecureStorageService(), AuthService()),
    );
    i.addLazySingleton(() => const FlutterSecureStorage());
    i.addLazySingleton<SplashController>(() => SplashController());
    i.addLazySingleton<RecoveryController>(
        () => RecoveryController(AuthService()));
  }

  @override
  void routes(r) {
    r.child("/", child: (context) => const SplashPage());
    r.child("/login", child: (context) => const LoginPage());
    r.child("/recovery", child: (context) => const RecoveryPage());
    r.child("/code", child: (context) => const RecoveryCodePage());
  }
}
