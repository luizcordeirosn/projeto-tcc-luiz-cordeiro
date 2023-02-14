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
import com.app.backend_app.Futebol.Model.Confronto;
import com.app.backend_app.Futebol.Model.ConfrontoInput;
import com.app.backend_app.Futebol.Model.Rodada;
import com.app.backend_app.Futebol.Model.Time;
import com.app.backend_app.Futebol.Repository.ConfrontoRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/confronto")
@Transactional
@Controller
public class ConfrontoController {

    @Autowired
    private ConfrontoRepository confrontoRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<Confronto> confronto(@PathVariable Integer id) {

        try {
            Confronto confronto = confrontoRepo.obterPorIdConfronto(id);
            return ResponseEntity.ok(confronto);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/{rodada}")
    public ResponseEntity<List<Confronto>> confrontosPorRodada(@PathVariable Integer rodada){

        List<Confronto> lista = new ArrayList<Confronto>();
        try {
            lista = confrontoRepo.obterTodosConfrontosPorRodada(rodada);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<Confronto> salvarConfronto(@RequestBody ConfrontoInput confrontoInput) throws SQLException {

        Confronto confronto = new Confronto();

        Rodada rodada = new Rodada();
        rodada.setId(confrontoInput.getRodada());
        confronto.setRodada(rodada);

        Time timeMandante = new Time();
        timeMandante.setId(confrontoInput.getTimeMandante());
        confronto.setTimeMandante(timeMandante);

        Time timeVisitante = new Time();
        timeVisitante.setId(confrontoInput.getTimeVisitante());
        confronto.setTimeVisitante(timeVisitante);

        confronto.setDataHora(confrontoInput.getDataHora());
        confronto.setResultado(confrontoInput.getResultado());

        try {
            if (confrontoInput.getId() == 0) {
                confronto = confrontoRepo.salvarConfronto(confronto);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(confronto);
    }
}

