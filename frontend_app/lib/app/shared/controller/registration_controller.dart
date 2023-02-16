import '../model/user.dart';
import '../repository/registration_repository.dart';

class RegistroController{

  RegistroRepository registroRepository = RegistroRepository();

  Future<void> registro(Usuario usuarioCadastro) async{
    
    registroRepository.registro(usuarioCadastro);
  }
}