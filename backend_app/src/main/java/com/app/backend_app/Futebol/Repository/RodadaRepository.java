package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.Rodada;

public interface RodadaRepository {
    
    List<Rodada> obterTodosRodadasPorCompeticao(Integer competicao);
    
    Rodada obterPorIdRodada(Integer id);

    Rodada salvarRodada(Rodada rodada);

}
