package com.app.backend_app.Futebol.Controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.app.backend_app.Futebol.Model.OpcaoJogador;
import com.app.backend_app.Futebol.Model.OpcaoJogadorInput;
import com.app.backend_app.Futebol.Model.Jogador;
import com.app.backend_app.Futebol.Model.Rodada;
import com.app.backend_app.Futebol.Model.VariavelApp;
import com.app.backend_app.Futebol.Repository.OpcaoJogadorRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/opcaojogador")
@Transactional
@Controller
public class OpcaoJogadorController {

    @Autowired
    private OpcaoJogadorRepository opcaoJogadorRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<OpcaoJogador> opcaojogador(@PathVariable Integer id) {

        try {
            OpcaoJogador opcaojogador = opcaoJogadorRepo.obterPorIdOpcaoJogador(id);
            return ResponseEntity.ok(opcaojogador);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/tipoposicao")
    public ResponseEntity<List<VariavelApp>> tiposPosicao() {

        List<VariavelApp> lista = new ArrayList<VariavelApp>();

        VariavelApp goleiro = new VariavelApp();
        VariavelApp lateral = new VariavelApp();
        VariavelApp zagueiro = new VariavelApp();
        VariavelApp meioCampo = new VariavelApp();
        VariavelApp atacante = new VariavelApp();

        goleiro.setValor(1);
        goleiro.setDescricao("Goleiro");

        lateral.setValor(2);
        lateral.setDescricao("Lateral");

        zagueiro.setValor(3);
        zagueiro.setDescricao("Zagueiro");

        meioCampo.setValor(4);
        meioCampo.setDescricao("Meio Campo");

        atacante.setValor(5);
        atacante.setDescricao("Atacante");

        try {
            lista.add(goleiro);
            lista.add(lateral);
            lista.add(zagueiro);
            lista.add(meioCampo);
            lista.add(atacante);

            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @GetMapping(value = "/obtertodos/{rodada}/{competicao}")
    public ResponseEntity<List<OpcaoJogador>> opcoesJogadorPorRodadaCompeticao(@PathVariable Integer rodada,
            @PathVariable Integer competicao) {

        List<OpcaoJogador> lista = new ArrayList<OpcaoJogador>();
        try {
            lista = opcaoJogadorRepo.obterTodosOpcoesJogadorPorRodadaCampeonato(rodada, competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @GetMapping(value = "/obtertodos/posicao/{rodada}/{competicao}")
    public ResponseEntity<List<OpcaoJogador>> opcoesJogadorPosicaoPorRodadaCompeticao(@PathVariable Integer rodada,
            @PathVariable Integer competicao, @RequestParam String posicao) {

        List<OpcaoJogador> lista = new ArrayList<OpcaoJogador>();
        try {
            lista = opcaoJogadorRepo.obterTodosOpcoesJogadorPosicaoPorRodadaCampeonato(rodada, competicao, posicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<OpcaoJogador> salvarConfronto(@RequestBody OpcaoJogadorInput opcaoJogadorInput)
            throws SQLException {

        OpcaoJogador opcaojogador = new OpcaoJogador();

        Jogador jogador = new Jogador();
        jogador.setId(opcaoJogadorInput.getJogador());
        opcaojogador.setJogador(jogador);

        Rodada rodada = new Rodada();
        rodada.setId(opcaoJogadorInput.getRodada());
        opcaojogador.setRodada(rodada);

        opcaojogador.setBoaPontuacao(opcaoJogadorInput.getBoaPontuacao());
        opcaojogador.setPosicao(opcaoJogadorInput.getPosicao());

        try {
            if (opcaoJogadorInput.getId() == 0) {
                opcaojogador = opcaoJogadorRepo.salvarOpcaoJogador(opcaojogador);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(opcaojogador);
    }
}
