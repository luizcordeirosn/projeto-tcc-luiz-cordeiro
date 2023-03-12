import 'package:frontend_liga_master/app/shared/repository/formation_repository.dart';

class FormationController {

  FormationRepository escalacaoController = FormationRepository();

  List escalacao = [];

  Future getEscalacao(int rodada, int competicao) async {
    escalacao.clear();
    List result = await escalacaoController.escalacoesPorRodadaCompeticao(rodada, competicao);

    for (var i = 0; i < result.length; i++) {
      escalacao.add(result[i]);
    }
    return escalacao;
  }
}