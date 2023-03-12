package com.app.backend_app.Futebol.Model;

public class Escalacao {
    
    private Integer id;
    private String formacao;
    private Rodada rodada;
    private Jogador jogador;
    private Integer tipoPosicao;
    
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getFormacao() {
        return formacao;
    }
    public void setFormacao(String formacao) {
        this.formacao = formacao;
    }
    public Rodada getRodada() {
        return rodada;
    }
    public void setRodada(Rodada rodada) {
        this.rodada = rodada;
    }
    public Jogador getJogador() {
        return jogador;
    }
    public void setJogador(Jogador jogador) {
        this.jogador = jogador;
    }
    public Integer getTipoPosicao() {
        return tipoPosicao;
    }
    public void setTipoPosicao(Integer tipoPosicao) {
        this.tipoPosicao = tipoPosicao;
    }

}
