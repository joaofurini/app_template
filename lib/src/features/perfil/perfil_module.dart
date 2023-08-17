import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_template/src/features/perfil/perfil_store.dart';
import 'package:app_template/src/features/perfil/view/perfil_screen.dart';

import 'package:app_template/src/shared/views/root_layout.dart';

class PerfilModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => PerfilStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => RootLayout(
        currentIndex: 1,
        child: ProfilePage(),
      ),
    ),
  ];
}
