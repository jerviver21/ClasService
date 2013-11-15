/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import java.io.File;
import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "ruta_imagenes")
@NamedQueries({
    @NamedQuery(name = "RutaImagenes.findAll", query = "SELECT r FROM RutaImagenes r")})
public class RutaImagenes implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Column(name = "url_root")
    private String urlRoot;
    @Column(name = "img0")
    private String img0;
    @Column(name = "ruta")
    private String ruta;
    
    @Transient
    private String pathImg0;

    public RutaImagenes() {
    }

    public RutaImagenes(Long id) {
        this.id = id;
    }

    public RutaImagenes(Long id, String ruta) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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
        if (!(object instanceof RutaImagenes)) {
            return false;
        }
        RutaImagenes other = (RutaImagenes) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.RutaImagenes[ id=" + id + " ]";
    }

    /**
     * @return the urlRoot
     */
    public String getUrlRoot() {
        return urlRoot;
    }

    /**
     * @param urlRoot the urlRoot to set
     */
    public void setUrlRoot(String urlRoot) {
        this.urlRoot = urlRoot;
    }

    /**
     * @return the img0
     */
    public String getImg0() {
        return img0;
    }

    /**
     * @param img0 the img0 to set
     */
    public void setImg0(String img0) {
        this.img0 = img0;
    }

    /**
     * @return the pathImg0
     */
    public String getPathImg0() {
        pathImg0 = urlRoot+File.separator+img0;
        return pathImg0;
    }

    /**
     * @return the ruta
     */
    public String getRuta() {
        return ruta;
    }

    /**
     * @param ruta the ruta to set
     */
    public void setRuta(String ruta) {
        this.ruta = ruta;
    }


    
}
