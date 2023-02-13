package com.app.backend_app.Futebol.Repository;

import com.app.backend_app.Futebol.Model.Time;

public interface TimeRepository {

    Time salvarTime(Time time);

    Time obterPorIdTime(Integer id);
    
}
