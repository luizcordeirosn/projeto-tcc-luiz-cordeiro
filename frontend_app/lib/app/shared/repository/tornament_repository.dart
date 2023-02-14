import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TornamentRepository {
  Dio dio = Dio();

  Future competicoes() async {
    try {
      Response response = await dio
          .get('http://10.0.2.2:8082/competicao/obtertodos');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
