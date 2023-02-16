import 'package:frontend_liga_master/app/shared/repository/round_repository.dart';
import 'package:frontend_liga_master/app/shared/repository/soccer_team_repository.dart';

class SoccerTeamController {
  SoccerTeamRepository soccerTeamRepository = SoccerTeamRepository();

  List times = [];

  Future getTimes(int competicao) async {
    times.clear();
    List result = await soccerTeamRepository.timesPorCompeticao(competicao);

    for (var i = 0; i < result.length; i++) {
      times.add(result[i]);
    }
    return times;
  }
}
