import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:school_app/app/screens/public/login/login_controller.dart';
import 'package:school_app/app/screens/public/login/login_page.dart';
import 'package:school_app/app/screens/public/splash/splash_controller.dart';
import 'package:school_app/app/screens/public/splash/splash_page.dart';
import 'package:school_app/app/service/auth_service.dart';
import 'package:school_app/app/utils/secure_storage.dart';

class PublicModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<LoginController>(
      () => LoginController(
        const SecureStorageService(),
        AuthService(),
      ),
    );
    i.addLazySingleton(() => const FlutterSecureStorage());
    i.addLazySingleton<SplashController>(() => SplashController());
  }

  @override
  void routes(r) {
    r.child("/", child: (context) => const SplashPage());
    r.child("/login", child: (context) => const LoginPage());
  }
}
