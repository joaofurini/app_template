// import 'package:app_template/src/features/home/domain/model/propostas_model.dart';
// import 'package:app_template/src/features/home/domain/usecases/getUsers.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:mobx/mobx.dart';

// class HomeStore with Store {
// late GetUsersUseCase getUsersUseCase = Modular.get<GetUsersUseCase>();

// @observable
// List<Post>? posts;
// @observable
// bool loading = false;

// Future<void> getUsers() async {
//   loading = true;
//   posts = await getUsersUseCase.call();

//   loading = false;

//   print(posts);
// }
// }

import 'package:app_template/src/features/home/domain/model/propostas_model.dart';
import 'package:app_template/src/features/home/domain/usecases/getUsers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'home_store.g.dart';

// This is the class used by rest of your codebase
class HomeStore = _HomeStore with _$HomeStore;

// The store-class
abstract class _HomeStore with Store {
  late GetUsersUseCase getUsersUseCase = Modular.get<GetUsersUseCase>();

  @observable
  Post? firstPost;

  @observable
  List<Post>? posts;

  @observable
  bool loading = false;

  Future<void> getPosts() async {
    loading = true;
    posts = await getUsersUseCase.call();
    firstPost = posts?[0];
    loading = false;
  }
}
