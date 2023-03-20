package com.app.backend_app.Futebol.Model;

public class EscalacaoInput {
    
    private Integer id;
    private String formacao;
    private Integer rodada;
    private Integer jogador;
    private Integer tipoPosicao;
    private Boolean capitao;
    
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
    public Integer getRodada() {
        return rodada;
    }
    public void setRodada(Integer rodada) {
        this.rodada = rodada;
    }
    public Integer getJogador() {
        return jogador;
    }
    public void setJogador(Integer jogador) {
        this.jogador = jogador;
    }
    public Integer getTipoPosicao() {
        return tipoPosicao;
    }
    public void setTipoPosicao(Integer tipoPosicao) {
        this.tipoPosicao = tipoPosicao;
    }
    public Boolean getCapitao() {
        return capitao;
    }
    public void setCapitao(Boolean capitao) {
        this.capitao = capitao;
    }
}
