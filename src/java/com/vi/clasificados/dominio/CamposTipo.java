/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "campos_tipo")
@NamedQueries({
    @NamedQuery(name = "CamposTipo.findAll", query = "SELECT c FROM CamposTipo c")})
public class CamposTipo implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Basic(optional = false)
    @Column(name = "subtipo1")
    private boolean subtipo1;
    @Basic(optional = false)
    @Column(name = "subtipo2")
    private boolean subtipo2;
    @Basic(optional = false)
    @Column(name = "subtipo3")
    private boolean subtipo3;
    @Basic(optional = false)
    @Column(name = "subtipo4")
    private boolean subtipo4;
    @Basic(optional = false)
    @Column(name = "subtipo5")
    private boolean subtipo5;
    @Basic(optional = false)
    @Column(name = "valor")
    private boolean valor;
    @JoinColumn(name = "id_tipoclasificado", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private TipoClasificado tipoClasificado;

    public CamposTipo() {
    }

    public CamposTipo(Long id) {
        this.id = id;
    }

    public CamposTipo(Long id, boolean subtipo1, boolean subtipo2, boolean subtipo3, boolean subtipo4, boolean subtipo5, boolean precio, boolean area) {
        this.id = id;
        this.subtipo1 = subtipo1;
        this.subtipo2 = subtipo2;
        this.subtipo3 = subtipo3;
        this.subtipo4 = subtipo4;
        this.subtipo5 = subtipo5;
        this.valor = precio;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public boolean getSubtipo1() {
        return subtipo1;
    }

    public void setSubtipo1(boolean subtipo1) {
        this.subtipo1 = subtipo1;
    }

    public boolean getSubtipo2() {
        return subtipo2;
    }

    public void setSubtipo2(boolean subtipo2) {
        this.subtipo2 = subtipo2;
    }

    public boolean getSubtipo3() {
        return subtipo3;
    }

    public void setSubtipo3(boolean subtipo3) {
        this.subtipo3 = subtipo3;
    }

    public boolean getSubtipo4() {
        return subtipo4;
    }

    public void setSubtipo4(boolean subtipo4) {
        this.subtipo4 = subtipo4;
    }

    public boolean getSubtipo5() {
        return subtipo5;
    }

    public void setSubtipo5(boolean subtipo5) {
        this.subtipo5 = subtipo5;
    }

    

    public TipoClasificado getTipoclasificado() {
        return tipoClasificado;
    }

    public void setTipoclasificado(TipoClasificado idTipoclasificado) {
        this.tipoClasificado = idTipoclasificado;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CamposTipo)) {
            return false;
        }
        CamposTipo other = (CamposTipo) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.CamposTipo[ id=" + id + " ]";
    }



    /**
     * @return the valor
     */
    public boolean isValor() {
        return valor;
    }

    /**
     * @param valor the valor to set
     */
    public void setValor(boolean valor) {
        this.valor = valor;
    }
    
}
