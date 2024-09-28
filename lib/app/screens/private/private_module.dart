import 'package:flutter_modular/flutter_modular.dart';
import 'home/home_controller.dart';

import 'home/home_page.dart';

class PrivateModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<HomeController>(() => HomeController());
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const HomePage());
  }
}
