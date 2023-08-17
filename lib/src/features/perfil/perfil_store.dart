import 'package:mobx/mobx.dart';

part 'perfil_store.g.dart';

class PerfilStore = PerfilStoreBase with _$PerfilStore;

abstract class PerfilStoreBase with Store {
  @observable
  int counter = 0;

  Future<void> increment() async {
    counter = counter + 1;
  }
}
