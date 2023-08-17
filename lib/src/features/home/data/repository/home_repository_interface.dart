import 'package:app_template/src/features/home/domain/model/propostas_model.dart';

abstract class IHomeRepository {
  Future<List<Post>> fetchData();
}
