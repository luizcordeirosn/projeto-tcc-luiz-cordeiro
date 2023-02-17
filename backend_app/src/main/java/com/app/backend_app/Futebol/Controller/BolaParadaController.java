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
import com.app.backend_app.Futebol.Model.BolaParada;
import com.app.backend_app.Futebol.Model.BolaParadaInput;
import com.app.backend_app.Futebol.Model.Jogador;
import com.app.backend_app.Futebol.Model.VariavelApp;
import com.app.backend_app.Futebol.Repository.BolaParadaRepository;
import com.app.backend_app.util.exceptions.DomainException;

@RestController
@RequestMapping(value = "/bolaparada")
@Transactional
@Controller
public class BolaParadaController {

    @Autowired
    private BolaParadaRepository bolaParadaRepo;

    @GetMapping(value = "/{id}")
    public ResponseEntity<BolaParada> bolaParada(@PathVariable Integer id) {

        try {
            BolaParada bolaParada = bolaParadaRepo.obterPorIdBolaParada(id);
            return ResponseEntity.ok(bolaParada);
        } catch (Exception e) {
            System.out.println("Erro - " + e.getMessage());
            return ResponseEntity.ok(null);
        }

    }

    @GetMapping(value = "/obtertodos/tipobolaparada")
    public ResponseEntity<List<VariavelApp>> tiposBolaParada() {

        List<VariavelApp> lista = new ArrayList<VariavelApp>();

        VariavelApp falta = new VariavelApp();
        VariavelApp escanteio = new VariavelApp();
        VariavelApp penalti = new VariavelApp();

        falta.setValor(1);
        falta.setDescricao("Falta");

        escanteio.setValor(2);
        escanteio.setDescricao("Escanteio");

        penalti.setValor(3);
        penalti.setDescricao("Pênalti");

        try {
            lista.add(falta);
            lista.add(escanteio);
            lista.add(penalti);

            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @GetMapping(value = "/obtertodos/falta/{time}/{competicao}")
    public ResponseEntity<List<BolaParada>> faltasPorTimeCompeticao(@PathVariable Integer time,
            @PathVariable Integer competicao) {

        List<BolaParada> lista = new ArrayList<BolaParada>();
        try {
            lista = bolaParadaRepo.obterTodosBolaParadaFaltasPorTimeCompeticao(time, competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @GetMapping(value = "/obtertodos/escanteio/{time}/{competicao}")
    public ResponseEntity<List<BolaParada>> escanteiosPorTimeCompeticao(@PathVariable Integer time,
            @PathVariable Integer competicao) {

        List<BolaParada> lista = new ArrayList<BolaParada>();
        try {
            lista = bolaParadaRepo.obterTodosBolaParadaEscanteiosPorTimeCompeticao(time, competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @GetMapping(value = "/obtertodos/penalti/{time}/{competicao}")
    public ResponseEntity<List<BolaParada>> penaltisPorTimeCompeticao(@PathVariable Integer time,
            @PathVariable Integer competicao) {

        List<BolaParada> lista = new ArrayList<BolaParada>();
        try {
            lista = bolaParadaRepo.obterTodosBolaParadaPenaltisPorTimeCompeticao(time, competicao);
            return ResponseEntity.ok(lista);
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }
    }

    @PostMapping(value = "/salvar")
    public ResponseEntity<BolaParada> salvarConfronto(@RequestBody BolaParadaInput bolaParadaInput) throws SQLException {

        BolaParada bolaParada = new BolaParada();

        Jogador jogador = new Jogador();
        jogador.setId(bolaParadaInput.getJogador());
        bolaParada.setJogador(jogador);

        bolaParada.setTipo(bolaParadaInput.getTipo());

        try {
            if (bolaParadaInput.getId() == 0) {
                bolaParada = bolaParadaRepo.salvarBolaParada(bolaParada);
            }
        } catch (Exception e) {
            throw new DomainException("Erro base de dados: " + e.getMessage());
        }

        return ResponseEntity.ok(bolaParada);
    }
}
