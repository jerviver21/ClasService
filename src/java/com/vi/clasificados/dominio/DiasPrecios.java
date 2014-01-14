/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import java.io.Serializable;
import java.math.BigDecimal;
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
@Table(name = "dias_precios")
@NamedQueries({
    @NamedQuery(name = "DiasPrecios.findAll", query = "SELECT p FROM DiasPrecios p")})
public class DiasPrecios implements Serializable {
    
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "iddia")
    private int iddia;
    @Basic(optional = false)
    @Column(name = "nombre_dia")
    private String nombreDia;
    
    
    @JoinColumn(name = "id_tipo_publicacion", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private SubtipoPublicacion subtipoPublicacion;
    
    @JoinColumn(name = "id_precio", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private Precios precio;

    public DiasPrecios() {
    }

    public DiasPrecios(Integer id) {
        this.id = id;
    }

    public DiasPrecios(Integer id, int iddia, String nombreDia) {
        this.id = id;
        this.iddia = iddia;
        this.nombreDia = nombreDia;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getIddia() {
        return iddia;
    }

    public void setIddia(int iddia) {
        this.iddia = iddia;
    }

    public String getNombreDia() {
        return nombreDia;
    }

    public void setNombreDia(String nombreDia) {
        this.nombreDia = nombreDia;
    }


    public SubtipoPublicacion getTipoPublicacion() {
        return subtipoPublicacion;
    }

    public void setTipoPublicacion(SubtipoPublicacion idTipoPublicacion) {
        this.subtipoPublicacion = idTipoPublicacion;
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
        if (!(object instanceof DiasPrecios)) {
            return false;
        }
        DiasPrecios other = (DiasPrecios) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.PreciosClasificados[ id=" + id + " ]";
    }

    public Precios getPrecio() {
        return precio;
    }

    public void setPrecio(Precios idTipoPrecio) {
        this.precio = idTipoPrecio;
    }

    
}
