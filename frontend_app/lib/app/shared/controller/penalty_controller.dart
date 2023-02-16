import 'package:frontend_liga_master/app/shared/repository/penalty_repository.dart';

class PenaltyController {
  PenaltyRepository penaltiRepository = PenaltyRepository();

  List penaltis = [];
  List penaltisCometidosAFavor = [];
  List cometido = [];

  Future getPenaltis(int competicao) async {
    penaltis.clear();
    List result = await penaltiRepository.penaltisPorCompeticao(competicao);

    for (var i = 0; i < result.length; i++) {
      penaltis.add(result[i]);
    }
    return penaltis;
  }

  Future getPenaltisCometidosAFavor(int cometido, int competicao) async {
    penaltisCometidosAFavor.clear();

    List result = await penaltiRepository.penaltisCometidosAFavorPorCompeticao(
        cometido, competicao);

    for (var i = 0; i < result.length; i++) {
      penaltisCometidosAFavor.add(result[i]);
    }
    return penaltisCometidosAFavor;
  }

  Future isCometido() async {
    cometido.clear();
    List result = await penaltiRepository.cometido();

    for (var i = 0; i < result.length; i++) {
      cometido.add(result[i]);
    }
    return cometido;
  }
}
