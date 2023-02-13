package com.app.backend_app.Competicao.Repository;

import com.app.backend_app.Competicao.Model.Competicao;

public interface CompeticaoRepository {

    Competicao obterPorIdCompeticao(Integer id);

    Competicao salvarCompeticao(Competicao competicao);

}