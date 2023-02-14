package com.app.backend_app.Futebol.Model;

public class Confronto {
    
    private Integer id;
    private Rodada rodada;
    private Time timeMandante;
    private Time timeVisitante;
    private String dataHora;
    private String resultado;
    
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Rodada getRodada() {
        return rodada;
    }
    public void setRodada(Rodada rodada) {
        this.rodada = rodada;
    }
    public Time getTimeMandante() {
        return timeMandante;
    }
    public void setTimeMandante(Time timeMandante) {
        this.timeMandante = timeMandante;
    }
    public Time getTimeVisitante() {
        return timeVisitante;
    }
    public void setTimeVisitante(Time timeVisitante) {
        this.timeVisitante = timeVisitante;
    }
    public String getDataHora() {
        return dataHora;
    }
    public void setDataHora(String dataHora) {
        this.dataHora = dataHora;
    }
    public String getResultado() {
        return resultado;
    }
    public void setResultado(String resultado) {
        this.resultado = resultado;
    }
}
