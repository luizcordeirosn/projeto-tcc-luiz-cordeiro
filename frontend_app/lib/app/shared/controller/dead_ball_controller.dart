import 'package:frontend_liga_master/app/shared/repository/dead_ball_repository.dart';

class DeadBallController {
  DeadBallRepository deadBallRepository = DeadBallRepository();

  List batedoresFalta = [];
  List batedoresEscanteio = [];
  List batedoresPenalti = [];

  Future getBatedoresFalta(int time, int competicao) async {
    batedoresFalta.clear();
    List result = await deadBallRepository.bolaParadaFaltasPorTimeCompeticao(
        time, competicao);

    for (var i = 0; i < result.length; i++) {
      batedoresFalta.add(result[i]);
    }
    return batedoresFalta;
  }

  Future getBatedoresEscanteio(int time, int competicao) async {
    batedoresEscanteio.clear();
    List result = await deadBallRepository.bolaParadaEscanteiosPorTimeCompeticao(
        time, competicao);

    for (var i = 0; i < result.length; i++) {
      batedoresEscanteio.add(result[i]);
    }
    return batedoresEscanteio;
  }

  Future getBatedoresPenalti(int time, int competicao) async {
    batedoresPenalti.clear();
    List result = await deadBallRepository.bolaParadaPenaltisPorTimeCompeticao(
        time, competicao);

    for (var i = 0; i < result.length; i++) {
      batedoresPenalti.add(result[i]);
    }
    return batedoresPenalti;
  }
}
