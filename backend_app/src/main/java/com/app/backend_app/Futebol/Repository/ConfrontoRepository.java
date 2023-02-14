package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.Confronto;

public interface ConfrontoRepository {
    
    Confronto salvarConfronto(Confronto confronto);

    Confronto obterPorIdConfronto(Integer id);
    
    List<Confronto> obterTodosConfrontosPorRodada(Integer rodada);
}
