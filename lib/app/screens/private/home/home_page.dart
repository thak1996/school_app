import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:school_app/app/screens/private/home/home_controller.dart';
import 'package:school_app/app/service/auth_service.dart';
import 'package:school_app/app/widgets/toogle_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(AuthService()),
      child: Consumer<HomeController>(
        builder: (context, controller, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: const Text('Adaptive Theme Demo'),
              centerTitle: true,
              actions: const [
                ToogleTheme(),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Usuário: ${controller.currentUser.name}'),
                  Text('E-mail: ${controller.currentUser.email}'),
                  ElevatedButton(
                    onPressed: () {
                      controller.signOut();
                      Modular.to.pushNamed("/login");
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
