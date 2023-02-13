package com.app.backend_app.Futebol.Repository;

import com.app.backend_app.Futebol.Model.Competicao;

public interface CompeticaoRepository {

    Competicao obterPorIdCompeticao(Integer id);

    Competicao salvarCompeticao(Competicao competicao);

}