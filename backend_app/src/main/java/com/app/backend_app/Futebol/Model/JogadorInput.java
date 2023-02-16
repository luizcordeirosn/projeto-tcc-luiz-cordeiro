package com.app.backend_app.Futebol.Model;

public class JogadorInput {
    
    private Integer id;
    private String nome;
    private String dataNascimento;
    private String nacionalidade;
    private double altura;
    private String posicao;
    private Integer gols;
    private Integer assistencias;
    private String imagem;
    private Integer time;

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getNome() {
        return nome;
    }
    public void setNome(String nome) {
        this.nome = nome;
    }
    public String getDataNascimento() {
        return dataNascimento;
    }
    public void setDataNascimento(String dataNascimento) {
        this.dataNascimento = dataNascimento;
    }
    public String getNacionalidade() {
        return nacionalidade;
    }
    public void setNacionalidade(String nacionalidade) {
        this.nacionalidade = nacionalidade;
    }
    public double getAltura() {
        return altura;
    }
    public void setAltura(double altura) {
        this.altura = altura;
    }
    public String getPosicao() {
        return posicao;
    }
    public void setPosicao(String posicao) {
        this.posicao = posicao;
    }
    public Integer getGols() {
        return gols;
    }
    public void setGols(Integer gols) {
        this.gols = gols;
    }
    public Integer getAssistencias() {
        return assistencias;
    }
    public void setAssistencias(Integer assistencias) {
        this.assistencias = assistencias;
    }
    public String getImagem() {
        return imagem;
    }
    public void setImagem(String imagem) {
        this.imagem = imagem;
    }
    public Integer getTime() {
        return time;
    }
    public void setTime(Integer time) {
        this.time = time;
    }
}
