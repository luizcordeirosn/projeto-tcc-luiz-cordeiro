import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class RoundRepository {
  Dio dio = Dio();

  Config config = Config();

  Future rodadasPorCompeticao(int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/rodada/obtertodos/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}