import 'package:frontend_liga_master/app/shared/repository/match_repository.dart';

class MatchController {

  MatchRepository confrontoRepository = MatchRepository();

  List confrontos = [];

  Future getConfrontos(int rodada, int competicao) async {
    confrontos.clear();
    List result = await confrontoRepository.confrontosPorRodadaCompeticao(rodada, competicao);

    for (var i = 0; i < result.length; i++) {
      confrontos.add(result[i]);
    }
    return confrontos;
  }
}
