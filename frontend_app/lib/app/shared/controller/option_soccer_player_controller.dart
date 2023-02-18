import 'package:frontend_liga_master/app/shared/repository/option_soccer_player_repository.dart';

class OptionSoccerPlayerController {
  OptionSoccerPlayerRepository optionSoccerPlayerRepository = OptionSoccerPlayerRepository();

  List opcoesJogador = [];
  List opcoesJogadorPosicao = [];
  List tiposPosicao = [];

  Future getTiposPosicao() async {
    tiposPosicao.clear();
    List result = await optionSoccerPlayerRepository.tiposPosicao();

    for (var i = 0; i < result.length; i++) {
      tiposPosicao.add(result[i]);
    }
    return tiposPosicao;
  }

  Future getOpcoesJogador(int rodada, int competicao) async {
    opcoesJogador.clear();
    List result = await optionSoccerPlayerRepository.opcoesJogadorPorRodadaCompeticao(
        rodada, competicao);

    for (var i = 0; i < result.length; i++) {
      opcoesJogador.add(result[i]);
    }
    return opcoesJogador;
  }

  Future getOpcoesJogadorPosicao(int time, int competicao, String posicao) async {
    opcoesJogadorPosicao.clear();
    List result = await optionSoccerPlayerRepository.opcoesJogadorPosicaoPorRodadaCompeticao(
        time, competicao, posicao);

    for (var i = 0; i < result.length; i++) {
      opcoesJogadorPosicao.add(result[i]);
    }
    return opcoesJogadorPosicao;
  }
}
