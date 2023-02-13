package com.app.backend_app.Futebol.Model;

public class RodadaInput {
    
    private Integer id;
    private String titulo;
    private Integer competicao;
    
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
    public Integer getCompeticao() {
        return competicao;
    }
    public void setCompeticao(Integer competicao) {
        this.competicao = competicao;
    }
}
