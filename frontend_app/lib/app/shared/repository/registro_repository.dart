import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:frontend_liga_master/app/shared/model/usuario.dart';

class RegistroRepository{

  Dio dio = Dio();

  Future<void> registro(Usuario usuarioCadastro) async{
    
    try{
      //http://10.0.2.2:8082
      Response response = await dio.post('https://3af0-2804-14d-5492-82b5-c55e-5b76-dffe-2027.sa.ngrok.io/usuario/salvar', data: {
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