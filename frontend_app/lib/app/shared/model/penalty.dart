class Penalty{

  late int _id;
  late String _descricao;

  setId(int id){
    _id=id;
  }
  int getId(){
    return _id;
  }
  setDescricao(String descricao){
    _descricao=descricao;
  }
  String getDescricao(){
    return _descricao;
  }
}