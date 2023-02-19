import 'package:frontend_liga_master/app/shared/repository/goal_report_repository.dart';

class GoalReportController{

  GoalReportRepository relatorioGolRepository = GoalReportRepository();

  List relatoriosGol = [];

  Future getRelatoriosGol(int rodada, int competicao) async {
    relatoriosGol.clear();
    List result = await relatorioGolRepository.relatoriosGolPorRodadaCompeticao(rodada, competicao);

    for (var i = 0; i < result.length; i++) {
      relatoriosGol.add(result[i]);
    }
    return relatoriosGol;
  }
}