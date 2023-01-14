import '../repository/login_repository.dart';

class LoginController{

  LoginRepository loginRepository = LoginRepository();

  List usuarioLogado = [];
  
  Future<void> login (String email, String senha) async {

    loginRepository.login(email, senha);
    usuarioLogado = loginRepository.usuarioLogado;
  }
}