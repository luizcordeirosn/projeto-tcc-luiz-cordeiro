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
import com.app.backend_app.Futebol.Model.Time;
import com.app.backend_app.Futebol.Model.TimeInput;
import com.app.backend_app.Futebol.Repository.CompeticaoRepository;
import com.app.backend_app.Futebol.Repository.TimeRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/time")
@Transactional
@Controller
public class TimeController {

    @Autowired
    private TimeRepository timeRepo;

    @Autowired
    private CompeticaoRepository competicaoRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<Time> time(@PathVariable Integer id) {

        try {
            Time time = timeRepo.obterPorIdTime(id);
            return ResponseEntity.ok(time);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/{competicao}")
    public ResponseEntity<List<Time>> rodadasPorCompeticao(@PathVariable Integer competicao){

        List<Time> lista = new ArrayList<Time>();
        try {
            lista = timeRepo.obterTodosTimesPorCompeticao(competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<Time> salvarTime(@RequestBody TimeInput timeInput) throws SQLException {

        Time time = new Time();

        time.setTitulo(timeInput.getTitulo());

        try {
            if (timeInput.getId() == 0) {
                time = timeRepo.salvarTime(time);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(time);
    }

    @PostMapping(value = "/salvar/timecompeticao/{timeid}/{competicaoid}")
    public ResponseEntity<Time> salvarTime(@PathVariable Integer timeid, @PathVariable Integer competicaoid)
            throws SQLException {

        try {

            Time time = timeRepo.obterPorIdTime(timeid);
            Competicao competicao = competicaoRepo.obterPorIdCompeticao(competicaoid);

            timeRepo.salvarTimePorCompeticao(time, competicao);

            return ResponseEntity.ok(time);

        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }
}
