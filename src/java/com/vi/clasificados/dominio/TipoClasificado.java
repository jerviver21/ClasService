/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "tipo_clasificado")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TipoClasificado.findAll", query = "SELECT t FROM TipoClasificado t")})
public class TipoClasificado implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "dato")
    private String dato;
    @OneToMany(mappedBy = "idSubtipo5", fetch = FetchType.LAZY)
    private List<Clasificado> clasificadoList;
    @OneToMany(mappedBy = "idSubtipo4", fetch = FetchType.LAZY)
    private List<Clasificado> clasificadoList1;
    @OneToMany(mappedBy = "idSubtipo3", fetch = FetchType.LAZY)
    private List<Clasificado> clasificadoList2;
    @OneToMany(mappedBy = "idSubtipo2", fetch = FetchType.LAZY)
    private List<Clasificado> clasificadoList3;
    @OneToMany(mappedBy = "idSubtipo1", fetch = FetchType.LAZY)
    private List<Clasificado> clasificadoList4;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTipo", fetch = FetchType.LAZY)
    private List<Clasificado> clasificadoList5;
    @OneToMany(mappedBy = "idPadre", fetch = FetchType.LAZY)
    private List<TipoClasificado> tipoClasificadoList;
    @JoinColumn(name = "id_padre", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private TipoClasificado idPadre;

    public TipoClasificado() {
    }

    public TipoClasificado(Integer id) {
        this.id = id;
    }

    public TipoClasificado(Integer id, String dato) {
        this.id = id;
        this.dato = dato;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDato() {
        return dato;
    }

    public void setDato(String dato) {
        this.dato = dato;
    }

    @XmlTransient
    public List<Clasificado> getClasificadoList() {
        return clasificadoList;
    }

    public void setClasificadoList(List<Clasificado> clasificadoList) {
        this.clasificadoList = clasificadoList;
    }

    @XmlTransient
    public List<Clasificado> getClasificadoList1() {
        return clasificadoList1;
    }

    public void setClasificadoList1(List<Clasificado> clasificadoList1) {
        this.clasificadoList1 = clasificadoList1;
    }

    @XmlTransient
    public List<Clasificado> getClasificadoList2() {
        return clasificadoList2;
    }

    public void setClasificadoList2(List<Clasificado> clasificadoList2) {
        this.clasificadoList2 = clasificadoList2;
    }

    @XmlTransient
    public List<Clasificado> getClasificadoList3() {
        return clasificadoList3;
    }

    public void setClasificadoList3(List<Clasificado> clasificadoList3) {
        this.clasificadoList3 = clasificadoList3;
    }

    @XmlTransient
    public List<Clasificado> getClasificadoList4() {
        return clasificadoList4;
    }

    public void setClasificadoList4(List<Clasificado> clasificadoList4) {
        this.clasificadoList4 = clasificadoList4;
    }

    @XmlTransient
    public List<Clasificado> getClasificadoList5() {
        return clasificadoList5;
    }

    public void setClasificadoList5(List<Clasificado> clasificadoList5) {
        this.clasificadoList5 = clasificadoList5;
    }

    @XmlTransient
    public List<TipoClasificado> getTipoClasificadoList() {
        return tipoClasificadoList;
    }

    public void setTipoClasificadoList(List<TipoClasificado> tipoClasificadoList) {
        this.tipoClasificadoList = tipoClasificadoList;
    }

    public TipoClasificado getIdPadre() {
        return idPadre;
    }

    public void setIdPadre(TipoClasificado idPadre) {
        this.idPadre = idPadre;
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
        if (!(object instanceof TipoClasificado)) {
            return false;
        }
        TipoClasificado other = (TipoClasificado) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.TipoClasificado[ id=" + id + " ]";
    }
    
}
