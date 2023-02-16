import 'package:frontend_liga_master/app/shared/repository/soccer_player_repository.dart';

class SoccerPlayerController {
  SoccerPlayerRepository soccerPlayerRepository = SoccerPlayerRepository();

  List jogadores = [];

  Future getJogadores(int time, int competicao) async {
    jogadores.clear();
    List result = await soccerPlayerRepository.jogadoresPorTimeCompeticao(
        time, competicao);

    for (var i = 0; i < result.length; i++) {
      jogadores.add(result[i]);
    }
    return jogadores;
  }
}
