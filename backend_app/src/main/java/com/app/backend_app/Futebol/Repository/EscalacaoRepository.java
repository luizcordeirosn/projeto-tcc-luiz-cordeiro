package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.Escalacao;

public interface EscalacaoRepository {
    
    Escalacao salvarEscalacao(Escalacao escalacao);

    Escalacao obterPorIdEscalacao(Integer id);
    
    List<Escalacao> obterTodosEscalacoesPorRodadaCompeticao(Integer rodada, Integer competicao);
}

