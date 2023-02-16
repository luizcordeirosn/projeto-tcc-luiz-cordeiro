import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/config/config.dart';

class LoginRepository {
  Dio dio = Dio();

  Config config = Config();

  List usuarioLogado = [];

  Future<void> login(String email, String senha) async {
    try {
      usuarioLogado.clear();

      Response response = await dio.get(
          '${config.path}/usuario/verificar?email=${email}&senha=${senha}');

      usuarioLogado.add(response.data['id']);
      usuarioLogado.add(response.data['nome']);
      usuarioLogado.add(response.data['cpf']);
      usuarioLogado.add(response.data['telefone']);
      usuarioLogado.add(response.data['email']);
      usuarioLogado.add(response.data['senha']);
      usuarioLogado.add(response.data['planoAtivo']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
