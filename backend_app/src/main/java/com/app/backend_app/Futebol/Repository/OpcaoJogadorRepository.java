package com.app.backend_app.Futebol.Repository;

import java.util.List;
import com.app.backend_app.Futebol.Model.OpcaoJogador;

public interface OpcaoJogadorRepository {
    
    OpcaoJogador salvarOpcaoJogador(OpcaoJogador opcaoJogadorRodada);

    OpcaoJogador obterPorIdOpcaoJogador(Integer id);
    
    List<OpcaoJogador> obterTodosOpcoesJogadorPorRodadaCampeonato(Integer rodada, Integer competicao);

    List<OpcaoJogador> obterTodosOpcoesJogadorPosicaoPorRodadaCampeonato(Integer rodada, Integer competicao, String posicao);

}
