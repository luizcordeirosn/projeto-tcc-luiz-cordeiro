import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MatchRepository {
  Dio dio = Dio();

  Future confrontosPorRodadaCompeticao(int rodada, int competicao) async {
    try {
      Response response = await dio
          .get('http://10.0.2.2:8082/confronto/obtertodos/${rodada}/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
