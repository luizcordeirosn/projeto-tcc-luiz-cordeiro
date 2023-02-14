import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ClassificationRepository {
  Dio dio = Dio();

  Future classificacaoPorCompeticao(int competicao) async {
    try {
      Response response = await dio
          .get('http://10.0.2.2:8082/classificacao/obtertodos/$competicao');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
