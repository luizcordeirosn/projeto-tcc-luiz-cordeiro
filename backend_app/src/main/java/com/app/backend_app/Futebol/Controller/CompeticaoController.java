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
import com.app.backend_app.Futebol.Model.Competicao;
import com.app.backend_app.Futebol.Model.CompeticaoInput;
import com.app.backend_app.Futebol.Repository.CompeticaoRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/competicao")
@Transactional
@Controller
public class CompeticaoController {

    @Autowired
    private CompeticaoRepository competicaRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<Competicao> competicao(@PathVariable Integer id) {

        try {
            Competicao competicao = competicaRepo.obterPorIdCompeticao(id);
            return ResponseEntity.ok(competicao);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos")
    public ResponseEntity<List<Competicao>> competicoes(){

        List<Competicao> lista = new ArrayList<Competicao>();
        try {
            lista = competicaRepo.obterTodosCompeticoes();
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<Competicao> salvarCompeticao(@RequestBody CompeticaoInput competicaoInput) throws SQLException {

        Competicao competicao = new Competicao();

        competicao.setTitulo(competicaoInput.getTitulo());

        try {
            if (competicaoInput.getId() == 0) {
                competicao = competicaRepo.salvarCompeticao(competicao);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(competicao);
    }
}
