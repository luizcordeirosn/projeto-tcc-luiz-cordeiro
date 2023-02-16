package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.BolaParada;

public interface BolaParadaRepository {
    
    BolaParada salvarBolaParada(BolaParada bolaParada);

    BolaParada obterPorIdBolaParada(Integer id);
    
    List<BolaParada> obterTodosBolaParadaFaltasPorTimeCompeticao(Integer time, Integer competicao);

    List<BolaParada> obterTodosBolaParadaEscanteiosPorTimeCompeticao(Integer time, Integer competicao);

    List<BolaParada> obterTodosBolaParadaPenaltisPorTimeCompeticao(Integer time, Integer competicao);
}
