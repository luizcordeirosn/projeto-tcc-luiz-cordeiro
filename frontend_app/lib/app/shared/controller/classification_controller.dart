import 'package:frontend_liga_master/app/shared/repository/classification_repository.dart';

class ClassificationController {

  ClassificationRepository classificacaoRepository = ClassificationRepository();

  List classificacao = [];

  Future getClassificacao(int competicao) async {
    classificacao.clear();
    List result = await classificacaoRepository.classificacaoPorCompeticao(competicao);

    for (var i = 0; i < result.length; i++) {
      classificacao.add(result[i]);
    }
    return classificacao;
  }
}
