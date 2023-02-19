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
import com.app.backend_app.Futebol.Model.RelatorioGol;
import com.app.backend_app.Futebol.Model.RelatorioGolInput;
import com.app.backend_app.Futebol.Model.Confronto;
import com.app.backend_app.Futebol.Repository.RelatorioGolRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/relatoriogol")
@Transactional
@Controller
public class RelatorioGolController {

    @Autowired
    private RelatorioGolRepository relatorioGolRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<RelatorioGol> relatorioGol(@PathVariable Integer id) {

        try {
            RelatorioGol relatorioGol = relatorioGolRepo.obterPorIdRelatorioGol(id);
            return ResponseEntity.ok(relatorioGol);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/{rodada}/{competicao}")
    public ResponseEntity<List<RelatorioGol>> relatoriosGolPorRodadaCompeticao(@PathVariable Integer rodada,
            @PathVariable Integer competicao) {

        List<RelatorioGol> lista = new ArrayList<RelatorioGol>();
        try {
            lista = relatorioGolRepo.obterTodosRelatoriosGolPorRodadaCompeticao(rodada, competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<RelatorioGol> salvarRelatorioGol(@RequestBody RelatorioGolInput relatorioGolInput)
            throws SQLException {

        RelatorioGol relatorioGol = new RelatorioGol();

        Confronto confronto = new Confronto();
        confronto.setId(relatorioGolInput.getConfronto());
        relatorioGol.setConfronto(confronto);

        relatorioGol.setGolsMarcadosBPM(relatorioGolInput.getGolsMarcadosBPM());
        relatorioGol.setGolsMarcadosPM(relatorioGolInput.getGolsMarcadosPM());
        relatorioGol.setGolsMarcadosMM(relatorioGolInput.getGolsMarcadosMM());
        relatorioGol.setGolsMarcadosDM(relatorioGolInput.getGolsMarcadosDM());
        relatorioGol.setGolsMarcadosEM(relatorioGolInput.getGolsMarcadosEM());
        relatorioGol.setGolsSofridosBPM(relatorioGolInput.getGolsSofridosBPM());
        relatorioGol.setGolsSofridosPM(relatorioGolInput.getGolsSofridosPM());
        relatorioGol.setGolsSofridosMM(relatorioGolInput.getGolsSofridosMM());
        relatorioGol.setGolsSofridosDM(relatorioGolInput.getGolsSofridosDM());
        relatorioGol.setGolsSofridosEM(relatorioGolInput.getGolsSofridosEM());
        relatorioGol.setGolsMarcadosBPV(relatorioGolInput.getGolsMarcadosBPV());
        relatorioGol.setGolsMarcadosPV(relatorioGolInput.getGolsMarcadosPV());
        relatorioGol.setGolsMarcadosMV(relatorioGolInput.getGolsMarcadosMV());
        relatorioGol.setGolsMarcadosDV(relatorioGolInput.getGolsMarcadosDV());
        relatorioGol.setGolsMarcadosEV(relatorioGolInput.getGolsMarcadosEV());
        relatorioGol.setGolsSofridosBPV(relatorioGolInput.getGolsSofridosBPV());
        relatorioGol.setGolsSofridosPV(relatorioGolInput.getGolsSofridosPV());
        relatorioGol.setGolsSofridosMV(relatorioGolInput.getGolsSofridosMV());
        relatorioGol.setGolsSofridosDV(relatorioGolInput.getGolsSofridosDV());
        relatorioGol.setGolsSofridosEV(relatorioGolInput.getGolsSofridosEV());

        try {
            if (relatorioGolInput.getId() == 0) {
                relatorioGol = relatorioGolRepo.salvarRelatorioGol(relatorioGol);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(relatorioGol);
    }
}
