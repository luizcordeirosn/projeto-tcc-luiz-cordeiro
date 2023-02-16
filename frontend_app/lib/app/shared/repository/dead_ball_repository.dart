import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class DeadBallRepository{

  Dio dio = Dio();

  Config config = Config();

  Future bolaParadaFaltasPorTimeCompeticao(int time, int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/bolaparada/obtertodos/falta/${time}/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future bolaParadaEscanteiosPorTimeCompeticao(int time, int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/bolaparada/obtertodos/escanteio/${time}/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future bolaParadaPenaltisPorTimeCompeticao(int time, int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/bolaparada/obtertodos/penalti/${time}/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}