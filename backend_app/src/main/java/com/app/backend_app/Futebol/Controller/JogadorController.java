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
import com.app.backend_app.Futebol.Model.Jogador;
import com.app.backend_app.Futebol.Model.JogadorInput;
import com.app.backend_app.Futebol.Model.Time;
import com.app.backend_app.Futebol.Repository.JogadorRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/jogador")
@Transactional
@Controller
public class JogadorController {

    @Autowired
    private JogadorRepository jogadorRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<Jogador> jogador(@PathVariable Integer id) {

        try {
            Jogador jogador = jogadorRepo.obterPorIdJogador(id);
            return ResponseEntity.ok(jogador);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/{time}")
    public ResponseEntity<List<Jogador>> jogadoresPorTime(@PathVariable Integer time){

        List<Jogador> lista = new ArrayList<Jogador>();
        try {
            lista = jogadorRepo.obterTodosJogadoresPorTime(time);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<Jogador> salvarConfronto(@RequestBody JogadorInput jogadorInput) throws SQLException {

        Jogador jogador = new Jogador();

        jogador.setNome(jogadorInput.getNome());
        jogador.setDataNascimento(jogadorInput.getDataNascimento());
        jogador.setNacionalidade(jogadorInput.getNacionalidade());
        jogador.setAltura(jogadorInput.getAltura());
        jogador.setPosicao(jogadorInput.getPosicao());
        jogador.setGols(jogadorInput.getGols());
        jogador.setAssistencias(jogadorInput.getAssistencias());

        Time time = new Time();
        time.setId(jogadorInput.getTime());
        jogador.setTime(time);

        try {
            if (jogadorInput.getId() == 0) {
                jogador = jogadorRepo.salvarJogador(jogador);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(jogador);
    }
}


