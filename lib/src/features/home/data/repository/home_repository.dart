import 'package:app_template/src/features/home/data/repository/home_repository_interface.dart';
import 'package:app_template/src/features/home/domain/model/propostas_model.dart';
import 'package:app_template/src/shared/infrastructure/http/custom_dio.dart';
import 'package:dio/dio.dart';

class HomeRepository implements IHomeRepository {
  CustomDio dio = new CustomDio();

  // @override
  // Future<Map<String, dynamic>> fetchData() async {
  //   var response = await dio.fetch(
  //       RequestOptions(baseUrl: 'https://jsonplaceholder.typicode.com/users'));
  //   print(response);
  //   return Map<String, dynamic>();
  // }
  @override
  Future<List<Post>> fetchData() async {
    var mockedResponse = [
      {'userId': 1, 'id': 3, 'title': 'teste', 'completed': true},
      {'userId': 1, 'id': 3, 'title': 'teste', 'completed': true},
    ];

    return Future.delayed(
      Duration(seconds: 2),
    ).then(
        (value) => mockedResponse.map((json) => Post.fromJson(json)).toList());
  }
}
