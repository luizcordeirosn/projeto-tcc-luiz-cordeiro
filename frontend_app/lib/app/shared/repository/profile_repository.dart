import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../model/usuario.dart';

class ProfileRepository {
  Dio dio = Dio();

  List usuarioAtualizado = [];

  Future<void> usuario(int id) async {
    try {
      usuarioAtualizado.clear();

      Response response = await dio.get('http://10.0.2.2:8082/usuario/$id');

      usuarioAtualizado.add(response.data['id']);
      usuarioAtualizado.add(response.data['nome']);
      usuarioAtualizado.add(response.data['cpf']);
      usuarioAtualizado.add(response.data['telefone']);
      usuarioAtualizado.add(response.data['email']);
      usuarioAtualizado.add(response.data['senha']);
      usuarioAtualizado.add(response.data['planoAtivo']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> atualizarUsuario(Usuario usuarioCadastro, int id) async {
    try {
      usuarioAtualizado.clear();

      Response response =
          await dio.post('http://10.0.2.2:8082/usuario/salvar', data: {
        "id": id,
        "nome": usuarioCadastro.getNome(),
        "cpf": usuarioCadastro.getCpf(),
        "telefone": usuarioCadastro.getTelefone(),
        "email": usuarioCadastro.getEmail(),
        "senha": usuarioCadastro.getSenha()
      });
      usuario(response.data['id']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
