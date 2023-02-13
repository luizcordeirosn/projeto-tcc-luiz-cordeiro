package com.app.backend_app.Futebol.Model;

public class Rodada {
    
    private Integer id;
    private String titulo;
    private Competicao competicao;
    
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public String getTitulo() {
        return titulo;
    }
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }
    public Competicao getCompeticao() {
        return competicao;
    }
    public void setCompeticao(Competicao competicao) {
        this.competicao = competicao;
    }
}
