package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.Classificacao;

public interface ClassificacaoRepository {

    Classificacao salvarClassificacao(Classificacao classificacao);

    Classificacao obterPorIdClassificacao(Integer id);
    
    List<Classificacao> obterTodosClassificacaoPorCompeticao(Integer competicao);

}
