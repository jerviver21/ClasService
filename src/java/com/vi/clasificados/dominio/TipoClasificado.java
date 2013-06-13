
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
@Table(name = "tipo_clasificado")
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
    @Column(name = "subtipo")
    private int subtipo;
    @Column(name = "nombre")
    private String nombre;
    
    @JoinColumn(name = "id_padre", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private TipoClasificado padre;

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

    public TipoClasificado getPadre() {
        return padre;
    }

    public void setPadre(TipoClasificado idPadre) {
        this.padre = idPadre;
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

    /**
     * @return the subtipo
     */
    public int getSubtipo() {
        return subtipo;
    }

    /**
     * @param subtipo the subtipo to set
     */
    public void setSubtipo(int subtipo) {
        this.subtipo = subtipo;
    }

    /**
     * @return the nombre
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @param nombre the nombre to set
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
}
