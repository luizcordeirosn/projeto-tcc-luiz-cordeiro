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
import com.app.backend_app.Futebol.Model.Classificacao;
import com.app.backend_app.Futebol.Model.ClassificacaoInput;
import com.app.backend_app.Futebol.Model.Time;
import com.app.backend_app.Futebol.Model.Competicao;
import com.app.backend_app.Futebol.Repository.ClassificacaoRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/classificacao")
@Transactional
@Controller
public class ClassificacaoController {

    @Autowired
    private ClassificacaoRepository classificacaoRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<Classificacao> classificacao(@PathVariable Integer id) {

        try {
            Classificacao classificacao = classificacaoRepo.obterPorIdClassificacao(id);
            return ResponseEntity.ok(classificacao);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/{competicao}")
    public ResponseEntity<List<Classificacao>> classificacaoPorCompeticao(@PathVariable Integer competicao) {

        List<Classificacao> lista = new ArrayList<Classificacao>();
        try {
            lista = classificacaoRepo.obterTodosClassificacaoPorCompeticao(competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<Classificacao> salvarClassificacao(@RequestBody ClassificacaoInput classificacaoInput)
            throws SQLException {

        Classificacao classificacao = new Classificacao();

        Competicao competicao = new Competicao();
        competicao.setId(classificacaoInput.getCompeticao());
        classificacao.setCompeticao(competicao);

        classificacao.setPosicao(classificacaoInput.getPosicao());

        Time time = new Time();
        time.setId(classificacaoInput.getTime());
        classificacao.setTime(time);

        classificacao.setPontos(classificacaoInput.getPontos());
        classificacao.setNumJogos(classificacaoInput.getNumJogos());
        classificacao.setNumVitorias(classificacaoInput.getNumVitorias());
        classificacao.setNumEmpates(classificacaoInput.getNumEmpates());
        classificacao.setNumDerrotas(classificacaoInput.getNumDerrotas());
        classificacao.setGolsPro(classificacaoInput.getGolsPro());
        classificacao.setGolsContra(classificacaoInput.getGolsContra());
        classificacao.setSaldoGol(classificacaoInput.getSaldoGol());
        classificacao.setResultadosRecentes(classificacaoInput.getResultadosRecentes());

        try {
            if (classificacaoInput.getId() == 0) {
                classificacao = classificacaoRepo.salvarClassificacao(classificacao);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(classificacao);
    }
}
