import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class FormationRepository {
  Dio dio = Dio();
  
  Config config = Config();

  Future escalacoesPorRodadaCompeticao(int rodada, int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/escalacao/obtertodos/${rodada}/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
