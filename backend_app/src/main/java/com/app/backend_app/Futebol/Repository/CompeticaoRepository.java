package com.app.backend_app.Futebol.Repository;

import com.app.backend_app.Futebol.Model.Competicao;

public interface CompeticaoRepository {

    Competicao salvarCompeticao(Competicao competicao);

    Competicao obterPorIdCompeticao(Integer id);

}