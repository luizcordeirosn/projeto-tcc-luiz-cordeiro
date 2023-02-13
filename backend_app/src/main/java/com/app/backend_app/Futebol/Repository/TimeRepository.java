package com.app.backend_app.Futebol.Repository;

import com.app.backend_app.Futebol.Model.Competicao;
import com.app.backend_app.Futebol.Model.Time;

public interface TimeRepository {

    Time salvarTime(Time time);

    public Time salvarTimePorCompeticao(Time time, Competicao competicao);

    Time obterPorIdTime(Integer id);
    
}
