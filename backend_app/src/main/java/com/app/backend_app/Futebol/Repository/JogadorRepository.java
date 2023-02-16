package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.Jogador;

public interface JogadorRepository {
    
    Jogador salvarJogador(Jogador confronto);

    Jogador obterPorIdJogador(Integer id);
    
    List<Jogador> obterTodosJogadoresPorTimeCompeticao(Integer time, Integer competicao);
}
