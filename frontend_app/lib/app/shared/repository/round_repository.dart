import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RoundRepository {
  Dio dio = Dio();

  Future rodadasPorCompeticao(int competicao) async {
    try {
      Response response = await dio
          .get('http://10.0.2.2:8082/rodada/obtertodos/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}