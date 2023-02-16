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
import com.app.backend_app.Futebol.Model.Penalti;
import com.app.backend_app.Futebol.Model.PenaltiInput;
import com.app.backend_app.Futebol.Model.Time;
import com.app.backend_app.Futebol.Repository.PenaltiRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/penalti")
@Transactional
@Controller
public class PenaltiController {

    @Autowired
    private PenaltiRepository penaltiRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<Penalti> penalti(@PathVariable Integer id) {

        try {
            Penalti penalti = penaltiRepo.obterPorIdPenalti(id);
            return ResponseEntity.ok(penalti);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/{competicao}")
    public ResponseEntity<List<Penalti>> penaltisPorCompeticao(@PathVariable Integer competicao) {

        List<Penalti> lista = new ArrayList<Penalti>();
        try {
            lista = penaltiRepo.obterTodosPenaltisPorCompeticao(competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<Penalti> salvarPenalti(@RequestBody PenaltiInput penaltiInput) throws SQLException {

        Penalti penalti = new Penalti();

        Time time = new Time();
        time.setId(penaltiInput.getTime());
        penalti.setTime(time);

        penalti.setNumPenaltis(penaltiInput.getNumPenaltis());
        penalti.setCometido(penaltiInput.isCometido());

        try {
            if (penaltiInput.getId() == 0) {
                penalti = penaltiRepo.salvarPenalti(penalti);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(penalti);
    }
}
