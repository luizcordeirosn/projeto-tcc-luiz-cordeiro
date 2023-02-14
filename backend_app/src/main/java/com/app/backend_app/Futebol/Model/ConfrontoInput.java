package com.app.backend_app.Futebol.Model;

public class ConfrontoInput {
    
    private Integer id;
    private Integer rodada;
    private Integer timeMandante;
    private Integer timeVisitante;
    private String dataHora;
    private String resultado;
    
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Integer getRodada() {
        return rodada;
    }
    public void setRodada(Integer rodada) {
        this.rodada = rodada;
    }
    public Integer getTimeMandante() {
        return timeMandante;
    }
    public void setTimeMandante(Integer timeMandante) {
        this.timeMandante = timeMandante;
    }
    public Integer getTimeVisitante() {
        return timeVisitante;
    }
    public void setTimeVisitante(Integer timeVisitante) {
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
