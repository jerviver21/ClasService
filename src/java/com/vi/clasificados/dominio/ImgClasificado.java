/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import java.io.InputStream;
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
import javax.persistence.Transient;
import javax.validation.constraints.Size;
import org.primefaces.model.StreamedContent;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "img_clasificado")
@NamedQueries({
    @NamedQuery(name = "ImgClasificado.findAll", query = "SELECT i FROM ImgClasificado i")})
public class ImgClasificado implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Size(max = 1000)
    @Column(name = "url")
    private String url;
    @Size(max = 25)
    @Column(name = "extension")
    private String extension;
    @JoinColumn(name = "id_clasificado", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private Clasificado clasificado;

    
    @Transient
    private InputStream img;

    public ImgClasificado() {
    }

    public ImgClasificado(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }

    public Clasificado getClasificado() {
        return clasificado;
    }

    public void setClasificado(Clasificado idClasificado) {
        this.clasificado = idClasificado;
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
        if (!(object instanceof ImgClasificado)) {
            return false;
        }
        ImgClasificado other = (ImgClasificado) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.ImgClasificado[ id=" + id + " ]";
    }


    /**
     * @return the img
     */
    public InputStream getImg() {
        return img;
    }

    /**
     * @param img the img to set
     */
    public void setImg(InputStream img) {
        this.img = img;
    }
    
}
