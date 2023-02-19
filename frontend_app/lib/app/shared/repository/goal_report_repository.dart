import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class GoalReportRepository{

  Dio dio = Dio();
  
  Config config = Config();

  Future relatoriosGolPorRodadaCompeticao(int rodada, int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/relatoriogol/obtertodos/${rodada}/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}