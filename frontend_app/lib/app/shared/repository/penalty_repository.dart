import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class PenaltyRepository {
  Dio dio = Dio();

  Config config = Config();

  Future penaltisPorCompeticao(int competicao) async {
    try {
      Response response =
          await dio.get('${config.path}/penalti/obtertodos/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future penaltisCometidosAFavorPorCompeticao(
      int cometido, int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/penalti/obtertodos/${cometido}/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future cometido() async {
    try {
      Response response = await dio.get('${config.path}/penalti/cometido');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
