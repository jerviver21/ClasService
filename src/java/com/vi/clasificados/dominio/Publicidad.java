/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "publicidad")
@NamedQueries({
    @NamedQuery(name = "Publicidad.findAll", query = "SELECT p FROM Publicidad p"),
    @NamedQuery(name = "Publicidad.findByBanner", query = "SELECT p FROM Publicidad p WHERE p.fechaIni <= :fecha AND p.fechaFin >= :fecha AND p.seccionPage = :banner")
})
public class Publicidad implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_ini")
    @Temporal(TemporalType.DATE)
    private Date fechaIni;
    @Size(max = 10)
    @Column(name = "seccion_page")
    private String seccionPage;
    @Basic(optional = false)
    @NotNull
    @Column(name = "num_clicks")
    private long numClicks;
    @Column(name = "fecha_fin")
    @Temporal(TemporalType.DATE)
    private Date fechaFin;
    @Basic(optional = false)
    @NotNull
    @Column(name = "num_impresiones")
    private long numImpresiones;
    @Column(name = "heigh")
    private Integer heigh;
    @Column(name = "width")
    private Integer width;
    @JoinColumn(name = "id_imagen", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private ImagenesPublicidad imagen;

    public Publicidad() {
    }

    public Publicidad(Long id) {
        this.id = id;
    }

    public Publicidad(Long id, Date fechaIni, long numClicks, long numImpresiones) {
        this.id = id;
        this.fechaIni = fechaIni;
        this.numClicks = numClicks;
        this.numImpresiones = numImpresiones;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getFechaIni() {
        return fechaIni;
    }

    public void setFechaIni(Date fechaIni) {
        this.fechaIni = fechaIni;
    }

    public String getSeccionPage() {
        return seccionPage;
    }

    public void setSeccionPage(String seccionPage) {
        this.seccionPage = seccionPage;
    }

    public long getNumClicks() {
        return numClicks;
    }

    public void setNumClicks(long numClicks) {
        this.numClicks = numClicks;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public long getNumImpresiones() {
        return numImpresiones;
    }

    public void setNumImpresiones(long numImpresiones) {
        this.numImpresiones = numImpresiones;
    }

    public Integer getHeigh() {
        return heigh;
    }

    public void setHeigh(Integer heigh) {
        this.heigh = heigh;
    }

    public Integer getWidth() {
        return width;
    }

    public void setWidth(Integer width) {
        this.width = width;
    }

    public ImagenesPublicidad getImagen() {
        return imagen;
    }

    public void setImagen(ImagenesPublicidad idImagen) {
        this.imagen = idImagen;
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
        if (!(object instanceof Publicidad)) {
            return false;
        }
        Publicidad other = (Publicidad) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.Publicidad[ id=" + id + " ]";
    }
    
}
