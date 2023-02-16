package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.Penalti;

public interface PenaltiRepository {

    Penalti salvarPenalti(Penalti penalti);

    Penalti obterPorIdPenalti(Integer id);

    List<Penalti> obterTodosPenaltisPorCompeticao(Integer competicao);
    
    List<Penalti> obterTodosPenaltisCometidosAFavorPorCompeticao(Boolean cometido, Integer competicao);

}
