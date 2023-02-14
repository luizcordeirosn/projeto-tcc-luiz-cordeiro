package com.app.backend_app.Futebol.Model;

public class Classificacao {
    
    private Integer id;
    private Competicao competicao;
    private Integer posicao;
    private Time time;
    private Integer pontos;
    private Integer numJogos;
    private Integer numVitorias;
    private Integer numEmpates;
    private Integer numDerrotas;
    private Integer golsPro;
    private Integer golsContra;
    private Integer saldoGol;
    private String resultadosRecentes;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Competicao getCompeticao() {
        return competicao;
    }
    public void setCompeticao(Competicao competicao) {
        this.competicao = competicao;
    }
    public Integer getPosicao() {
        return posicao;
    }
    public void setPosicao(Integer posicao) {
        this.posicao = posicao;
    }
    public Time getTime() {
        return time;
    }
    public void setTime(Time time) {
        this.time = time;
    }
    public Integer getPontos() {
        return pontos;
    }
    public void setPontos(Integer pontos) {
        this.pontos = pontos;
    }
    public Integer getNumJogos() {
        return numJogos;
    }
    public void setNumJogos(Integer numJogos) {
        this.numJogos = numJogos;
    }
    public Integer getNumVitorias() {
        return numVitorias;
    }
    public void setNumVitorias(Integer numVitorias) {
        this.numVitorias = numVitorias;
    }
    public Integer getNumEmpates() {
        return numEmpates;
    }
    public void setNumEmpates(Integer numEmpates) {
        this.numEmpates = numEmpates;
    }
    public Integer getNumDerrotas() {
        return numDerrotas;
    }
    public void setNumDerrotas(Integer numDerrotas) {
        this.numDerrotas = numDerrotas;
    }
    public Integer getGolsPro() {
        return golsPro;
    }
    public void setGolsPro(Integer golsPro) {
        this.golsPro = golsPro;
    }
    public Integer getGolsContra() {
        return golsContra;
    }
    public void setGolsContra(Integer golsContra) {
        this.golsContra = golsContra;
    }
    public Integer getSaldoGol() {
        return saldoGol;
    }
    public void setSaldoGol(Integer saldoGol) {
        this.saldoGol = saldoGol;
    }
    public String getResultadosRecentes() {
        return resultadosRecentes;
    }
    public void setResultadosRecentes(String resultadosRecentes) {
        this.resultadosRecentes = resultadosRecentes;
    }

}
