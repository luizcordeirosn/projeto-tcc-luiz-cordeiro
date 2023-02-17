package com.app.backend_app.Futebol.Model;

public class OpcaoJogador {

    private Integer id;
    private Jogador jogador;
    private Rodada rodada;
    private Integer boaPontuacao;
    private String posicao;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Jogador getJogador() {
        return jogador;
    }
    public void setJogador(Jogador jogador) {
        this.jogador = jogador;
    }
    public Rodada getRodada() {
        return rodada;
    }
    public void setRodada(Rodada rodada) {
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
