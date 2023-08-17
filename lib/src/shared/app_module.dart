import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_template/src/features/home/home_module.dart';
import 'package:app_template/src/features/perfil/perfil_module.dart';

import 'package:app_template/src/shared/infrastructure/http/custom_dio.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => CustomDio()),
    // Bind.lazySingleton(
    //   (i) => AuthRepository(
    //     i.get<Dio>(),
    //   ),
    // ),
    // Bind.lazySingleton(
    //   (i) => LogRepository(),
    // ),
    // Bind.lazySingleton(
    //   (i) => AppDrawerStore(
    //     i<IAuthRepository>(),
    //   ),
    // ),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: HomeModule(),
      transition: TransitionType.fadeIn,
    ),
    ModuleRoute(
      '/perfil',
      module: PerfilModule(),
      transition: TransitionType.fadeIn,
    ),
   
  ];
}
