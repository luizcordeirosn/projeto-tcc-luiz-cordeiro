class Usuario{

  late String _nome;
  late String _cpf;
  late String _telefone;
  late String _email;
  late String _senha;

  setNome(String nome){
    _nome=nome;
  }
  String getNome(){
    return _nome;
  }
  setCpf(String cpf){
    _cpf=cpf;
  }
  String getCpf(){
    return _cpf;
  }
  setTelefone(String telefone){
    _telefone=telefone;
  }
  String getTelefone(){
    return _telefone;
  }
  setEmail(String email){
    _email=email;
  }
  String getEmail(){
    return _email;
  }
  setSenha(String senha){
    _senha=senha;
  }
  String getSenha(){
    return _senha;
  }
}