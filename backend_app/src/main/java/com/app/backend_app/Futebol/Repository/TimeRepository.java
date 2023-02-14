package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.Competicao;
import com.app.backend_app.Futebol.Model.Time;

public interface TimeRepository {

    Time salvarTime(Time time);

    Time obterPorIdTime(Integer id);

    List<Time> obterTodosTimesPorCompeticao(Integer competicao);
    
}
