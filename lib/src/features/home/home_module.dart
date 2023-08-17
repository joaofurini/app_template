import 'package:app_template/src/features/home/data/repository/home_repository.dart';
import 'package:app_template/src/features/home/data/repository/home_repository_interface.dart';
import 'package:app_template/src/features/home/domain/usecases/getUsers.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:app_template/src/features/home/presentation/home_store.dart';

import 'package:app_template/src/features/home/presentation/view.dart';

import 'package:app_template/src/shared/infrastructure/http/custom_dio.dart';
import 'package:app_template/src/shared/views/root_layout.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => CustomDio()),
    Bind((i) => HomeRepository()),
    Bind(
      (i) => GetUsersUseCase(i.get<IHomeRepository>()),
    ),
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => RootLayout(
        currentIndex: 0,
        child: const HomeScreen(),
      ),
    ),
  ];
}
