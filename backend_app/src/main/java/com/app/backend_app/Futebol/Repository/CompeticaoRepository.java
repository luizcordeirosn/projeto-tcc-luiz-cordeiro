package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.Competicao;

public interface CompeticaoRepository {

    Competicao salvarCompeticao(Competicao competicao);

    Competicao obterPorIdCompeticao(Integer id);

    List<Competicao> obterTodosCompeticoes();

}