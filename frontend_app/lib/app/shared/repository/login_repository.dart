import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoginRepository {
  Dio dio = Dio();

  List usuarioLogado = [];

  Future<void> login(String email, String senha) async {
    try {
      usuarioLogado.clear();

      Response response = await dio.get(
          'https://8656-2804-14d-5492-82b5-d59c-c47c-d068-16ef.sa.ngrok.io/usuario/verificar?email=${email}&senha=${senha}');

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
