import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/model/usuario.dart';

class RegistroRepository{

  Dio dio = Dio();

  Future<void> registro(Usuario usuarioCadastro) async{
    
    try{

      Response response = await dio.post('http://10.0.2.2:8082/usuario/salvar', data: {
        "id":0,
        "nome": usuarioCadastro.getNome(),
        "cpf": usuarioCadastro.getCpf(),
        "telefone": usuarioCadastro.getTelefone(),
        "email": usuarioCadastro.getEmail(),
        "senha": usuarioCadastro.getSenha()
      });

    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
  }
}