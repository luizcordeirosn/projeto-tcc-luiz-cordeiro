import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class OptionSoccerPlayerRepository{

  Dio dio = Dio();

  Config config = Config();

  Future tiposPosicao() async {
    try {
      Response response = await dio
          .get('${config.path}/opcaojogador/obtertodos/tipoposicao');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future opcoesJogadorPorRodadaCompeticao(int rodada, int competicao) async {
    try {
      Response response = await dio
          .get('${config.path}/opcaojogador/obtertodos/${rodada}/${competicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future opcoesJogadorPosicaoPorRodadaCompeticao(int rodada, int competicao, String posicao) async {
    try {
      Response response = await dio
          .get('${config.path}/opcaojogador/obtertodos/posicao/${rodada}/${competicao}?posicao=${posicao}');

      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}