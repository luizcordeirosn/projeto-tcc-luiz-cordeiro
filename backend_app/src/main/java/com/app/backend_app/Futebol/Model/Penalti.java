package com.app.backend_app.Futebol.Model;

public class Penalti {
    
    private Integer id;
    private Time time;
    private Integer numPenaltis;
    private boolean cometido;
    
    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
    public Time getTime() {
        return time;
    }
    public void setTime(Time time) {
        this.time = time;
    }
    public Integer getNumPenaltis() {
        return numPenaltis;
    }
    public void setNumPenaltis(Integer numPenaltis) {
        this.numPenaltis = numPenaltis;
    }
    public boolean isCometido() {
        return cometido;
    }
    public void setCometido(boolean cometido) {
        this.cometido = cometido;
    }
}
