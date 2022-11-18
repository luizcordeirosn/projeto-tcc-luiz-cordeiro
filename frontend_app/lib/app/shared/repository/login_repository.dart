import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoginRepository {

  Dio dio = Dio();

  List usuarioLogado = [];

  Future<void> login (String email, String senha) async {

    try {

      usuarioLogado.clear();
      //Response response = await dio.post('http://www.google.com/',data:{"userId": userId},);
      Response response = await dio.get('http://10.0.2.2:8082/usuario/verificar?email=${email}&senha=${senha}');

      usuarioLogado.add(response.data['id']);
      usuarioLogado.add(response.data['nome']);
      usuarioLogado.add(response.data['telefone']);
      usuarioLogado.add(response.data['email']);
      usuarioLogado.add(response.data['senha']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
