import 'package:flutter_modular/flutter_modular.dart';
import 'package:school_app/app/screens/private/private_module.dart';
import 'package:school_app/app/screens/public/public_module.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module("/", module: PublicModule());
    r.module("/private-module", module: PrivateModule());
  }
}
