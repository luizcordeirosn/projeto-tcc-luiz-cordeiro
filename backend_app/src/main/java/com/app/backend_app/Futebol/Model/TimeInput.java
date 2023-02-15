package com.app.backend_app.Futebol.Model;

public class TimeInput {
    
    private Integer id;
    private String titulo;
    private String sigla;
    private String escudo;
    
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
    public String getSigla() {
        return sigla;
    }
    public void setSigla(String sigla) {
        this.sigla = sigla;
    }
    public String getEscudo() {
        return escudo;
    }
    public void setEscudo(String escudo) {
        this.escudo = escudo;
    }
}
