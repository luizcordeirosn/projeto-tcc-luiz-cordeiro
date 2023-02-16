import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class SoccerPlayerRepository {
  Dio dio = Dio();

  Config config = Config();

  Future jogadoresPorTimeCompeticao(int time, int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/jogador/obtertodos/${time}/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
