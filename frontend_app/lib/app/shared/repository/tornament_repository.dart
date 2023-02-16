import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class TornamentRepository {
  Dio dio = Dio();

  Config config = Config();

  Future competicoes() async {
    try {
      Response response = await dio
          .get('${config.path}/competicao/obtertodos');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
