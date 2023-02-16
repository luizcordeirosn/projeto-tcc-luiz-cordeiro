import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class ClassificationRepository {
  Dio dio = Dio();

  Config config = Config();

  Future classificacaoPorCompeticao(int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/classificacao/obtertodos/$competicao');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
