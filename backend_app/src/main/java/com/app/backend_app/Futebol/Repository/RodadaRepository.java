package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.Rodada;

public interface RodadaRepository {

    Rodada salvarRodada(Rodada rodada);

    Rodada obterPorIdRodada(Integer id);
    
    List<Rodada> obterTodosRodadasPorCompeticao(Integer competicao);

}
