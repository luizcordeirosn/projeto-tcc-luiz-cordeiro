package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.RelatorioGol;

public interface RelatorioGolRepository {
    
    RelatorioGol salvarRelatorioGol(RelatorioGol relatorioGol);

    RelatorioGol obterPorIdRelatorioGol(Integer id);

    List<RelatorioGol> obterTodosRelatoriosGolPorRodadaCompeticao(Integer rodada, Integer competicao);
}
