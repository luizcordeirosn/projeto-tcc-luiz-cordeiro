package com.app.backend_app.Model;

import java.sql.Date;

public class Usuario {
    
    private Integer id;
    private String nome;
    private String email;
    private String senha;
    private Date registro;
    private Boolean planoAtivo;
    
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
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getSenha() {
        return senha;
    }
    public void setSenha(String senha) {
        this.senha = senha;
    }
    public Date getRegistro() {
        return registro;
    }
    public void setRegistro(Date registro) {
        this.registro = registro;
    }
    public Boolean getPlanoAtivo() {
        return planoAtivo;
    }
    public void setPlanoAtivo(Boolean planoAtivo) {
        this.planoAtivo = planoAtivo;
    }

}
