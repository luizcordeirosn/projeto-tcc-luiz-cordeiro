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
import com.app.backend_app.Futebol.Model.Rodada;
import com.app.backend_app.Futebol.Model.RodadaInput;
import com.app.backend_app.Futebol.Model.Competicao;
import com.app.backend_app.Futebol.Repository.RodadaRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/rodada")
@Transactional
@Controller
public class RodadaController {

    @Autowired
    private RodadaRepository rodadaRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<Rodada> rodada(@PathVariable Integer id) {

        try {
            Rodada rodada = rodadaRepo.obterPorIdRodada(id);
            return ResponseEntity.ok(rodada);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/{competicao}")
    public ResponseEntity<List<Rodada>> rodadasPorCompeticao(@PathVariable Integer competicao){

        List<Rodada> lista = new ArrayList<Rodada>();
        try {
            lista = rodadaRepo.obterTodosRodadasPorCompeticao(competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<Rodada> salvarRodada(@RequestBody RodadaInput rodadaInput) throws SQLException {

        Rodada rodada = new Rodada();

        rodada.setTitulo(rodadaInput.getTitulo());

        Competicao competicao = new Competicao();
        competicao.setId(rodadaInput.getCompeticao());
        rodada.setCompeticao(competicao);

        try {
            if (rodadaInput.getId() == 0) {
                rodada = rodadaRepo.salvarRodada(rodada);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(rodada);
    }
}
