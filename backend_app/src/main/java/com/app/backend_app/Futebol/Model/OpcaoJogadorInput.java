package com.app.backend_app.Futebol.Model;

public class OpcaoJogadorInput {
    
    private Integer id;
    private Integer jogador;
    private Integer rodada;
    private Integer boaPontuacao;
    private String posicao;

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
    public Integer getRodada() {
        return rodada;
    }
    public void setRodada(Integer rodada) {
        this.rodada = rodada;
    }
    public Integer getBoaPontuacao() {
        return boaPontuacao;
    }
    public void setBoaPontuacao(Integer boaPontuacao) {
        this.boaPontuacao = boaPontuacao;
    }
    public String getPosicao() {
        return posicao;
    }
    public void setPosicao(String posicao) {
        this.posicao = posicao;
    }
}
