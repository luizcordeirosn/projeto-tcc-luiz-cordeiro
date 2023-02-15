import 'package:frontend_liga_master/app/shared/repository/round_repository.dart';

class RoundController {

  RoundRepository rodadaRepository = RoundRepository();

  List rodadas = [];

  Future getRodadas(int competicao) async {
    rodadas.clear();
    List result = await rodadaRepository.rodadasPorCompeticao(competicao);

    for (var i = 0; i < result.length; i++) {
      rodadas.add(result[i]);
    }
    return rodadas;
  }
}
