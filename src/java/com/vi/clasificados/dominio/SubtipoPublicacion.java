/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "subtipo_publicacion")
@NamedQueries({
    @NamedQuery(name = "SubtipoPublicacion.findAll", query = "SELECT s FROM SubtipoPublicacion s")})
public class SubtipoPublicacion implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "nombre")
    private String nombre;
    @Column(name = "precio")
    private Integer precio;
    @Column(name = "duracion")
    private Integer duracion;
    @Column(name = "prioridad")
    private Integer prioridad;
    
    @JoinColumn(name = "id_tipo_publicacion", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private TipoPublicacion tipoPublicacion;    
    
     @OneToMany(cascade = CascadeType.ALL, mappedBy = "subtipoPublicacion", fetch = FetchType.EAGER)
    private List<DiasPrecios> precios;
        


    public SubtipoPublicacion() {
    }

    public SubtipoPublicacion(Integer id) {
        this.id = id;
    }

    public SubtipoPublicacion(Integer id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Integer getPrecio() {
        return precio;
    }

    public void setPrecio(Integer precio) {
        this.precio = precio;
    }

    public Integer getDuracion() {
        return duracion;
    }

    public void setDuracion(Integer duracion) {
        this.duracion = duracion;
    }

    public Integer getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(Integer prioridad) {
        this.prioridad = prioridad;
    }
    
    public List<DiasPrecios> getPrecios() {
        return precios;
    }

    public void setPrecios(List<DiasPrecios> preciosClasificadosList) {
        this.precios = preciosClasificadosList;
    }
    
    public Map getMapaPrecios(){
        Map mapaPrecios = new HashMap();
        for(DiasPrecios precio1 : precios){
            mapaPrecios.put(precio1.getIddia(), precio1);
        }
        return mapaPrecios;
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
        if (!(object instanceof SubtipoPublicacion)) {
            return false;
        }
        SubtipoPublicacion other = (SubtipoPublicacion) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.SubtipoPublicacion[ id=" + id + " ]";
    }

    /**
     * @return the tipoPublicacion
     */
    public TipoPublicacion getTipoPublicacion() {
        return tipoPublicacion;
    }

    /**
     * @param tipoPublicacion the tipoPublicacion to set
     */
    public void setTipoPublicacion(TipoPublicacion tipoPublicacion) {
        this.tipoPublicacion = tipoPublicacion;
    }
    
}
