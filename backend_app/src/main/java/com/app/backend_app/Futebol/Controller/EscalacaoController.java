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
import org.springframework.web.bind.annotation.RestController;
import com.app.backend_app.Futebol.Model.Escalacao;
import com.app.backend_app.Futebol.Model.EscalacaoInput;
import com.app.backend_app.Futebol.Model.Jogador;
import com.app.backend_app.Futebol.Model.Rodada;
import com.app.backend_app.Futebol.Repository.EscalacaoRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/escalacao")
@Transactional
@Controller
public class EscalacaoController {

    @Autowired
    private EscalacaoRepository escalacaoRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<Escalacao> escalacao(@PathVariable Integer id) {

        try {
            Escalacao escalacao = escalacaoRepo.obterPorIdEscalacao(id);
            return ResponseEntity.ok(escalacao);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/{rodada}/{competicao}")
    public ResponseEntity<List<Escalacao>> escalacoesPorRodadaCompeticao(@PathVariable Integer rodada,
            @PathVariable Integer competicao) {

        List<Escalacao> lista = new ArrayList<Escalacao>();
        try {
            lista = escalacaoRepo.obterTodosEscalacoesPorRodadaCompeticao(rodada, competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<Escalacao> salvarEscalacao(@RequestBody EscalacaoInput escalacaoInput) throws SQLException {

        Escalacao escalacao = new Escalacao();

        escalacao.setFormacao(escalacaoInput.getFormacao());

        Rodada rodada = new Rodada();
        rodada.setId(escalacaoInput.getRodada());
        escalacao.setRodada(rodada);

        Jogador jogador = new Jogador();
        jogador.setId(escalacaoInput.getJogador());
        escalacao.setJogador(jogador);

        escalacao.setTipoPosicao(escalacaoInput.getTipoPosicao());

        try {
            if (escalacaoInput.getId() == 0) {
                escalacao = escalacaoRepo.salvarEscalacao(escalacao);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(escalacao);
    }
}
