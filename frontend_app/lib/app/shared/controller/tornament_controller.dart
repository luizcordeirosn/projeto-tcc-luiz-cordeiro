import 'package:frontend_liga_master/app/shared/repository/tornament_repository.dart';

class TornamentController {
  TornamentRepository competicaoRepository = TornamentRepository();

  List competicoes = [];

  Future getCompeticoes() async {
    competicoes.clear();
    List result = await competicaoRepository.competicoes() ?? [];

    for (var i = 0; i < result.length; i++) {
      competicoes.add(result[i]);
    }
    return competicoes;
  }
}
