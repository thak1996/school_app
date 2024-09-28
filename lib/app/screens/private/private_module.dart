import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/service/auth_service.dart';
import 'home/home_controller.dart';

import 'home/home_page.dart';

class PrivateModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<HomeController>(() => HomeController(AuthService()));
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const HomePage());
  }
}
