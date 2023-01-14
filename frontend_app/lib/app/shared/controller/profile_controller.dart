import '../model/usuario.dart';
import '../repository/profile_repository.dart';

class ProfileController {

  ProfileRepository profileRepository = ProfileRepository();

  List usuarioAtualizado = [];

  Future<void> usuario(int id) async {
    profileRepository.usuario(id);
    usuarioAtualizado = profileRepository.usuarioAtualizado;
  }

   Future<void> atualizarUsuario(Usuario usuarioCadastro, int id) async{
    
    profileRepository.atualizarUsuario(usuarioCadastro, id);
    usuarioAtualizado = profileRepository.usuarioAtualizado;
  }
}
