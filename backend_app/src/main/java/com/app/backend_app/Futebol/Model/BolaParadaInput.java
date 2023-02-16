package com.app.backend_app.Futebol.Model;

public class BolaParadaInput {
    
    private Integer id;
    private Integer jogador;
    private String tipo;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Integer getJogador() {
        return jogador;
    }
    public void setJogador(Integer jogador) {
        this.jogador = jogador;
    }
    public String getTipo() {
        return tipo;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
}
