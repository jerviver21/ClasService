/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import com.vi.comun.util.Log;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.Serializable;
import java.util.logging.Level;
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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "imagenes_publicidad")
@NamedQueries({
    @NamedQuery(name = "ImagenesPublicidad.findAll", query = "SELECT i FROM ImagenesPublicidad i")})
public class ImagenesPublicidad implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "url_fuente")
    private String urlFuente;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 1000)
    @Column(name = "nombre_cliente")
    private String nombreCliente;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "nid")
    private String nid;
    @Size(max = 50)
    @Column(name = "telefono")
    private String telefono;
    @Size(max = 1000)
    @Column(name = "url_aterrizaje")
    private String urlAterrizaje;
    @JoinColumn(name = "id_tipo_fuente", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private TipoFuente tipoFuente;
    
    @Transient
    private StreamedContent imagen;


    public ImagenesPublicidad() {
    }

    public ImagenesPublicidad(Long id) {
        this.id = id;
    }

    public ImagenesPublicidad(Long id, String urlFuente, String nombreCliente, String nid) {
        this.id = id;
        this.urlFuente = urlFuente;
        this.nombreCliente = nombreCliente;
        this.nid = nid;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUrlFuente() {
        return urlFuente;
    }

    public void setUrlFuente(String urlFuente) {
        this.urlFuente = urlFuente;
    }

    public String getNombreCliente() {
        return nombreCliente;
    }

    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getUrlAterrizaje() {
        return urlAterrizaje;
    }

    public void setUrlAterrizaje(String urlAterrizaje) {
        this.urlAterrizaje = urlAterrizaje;
    }

    public TipoFuente getTipoFuente() {
        return tipoFuente;
    }

    public void setTipoFuente(TipoFuente idTipoFuente) {
        this.tipoFuente = idTipoFuente;
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
        if (!(object instanceof ImagenesPublicidad)) {
            return false;
        }
        ImagenesPublicidad other = (ImagenesPublicidad) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.ImagenesPublicidad[ id=" + id + " ]";
    }

    /**
     * @return the imagen
     */
    public StreamedContent getImagen() {
        try {
           BufferedInputStream stream = new BufferedInputStream(new FileInputStream(urlFuente));
           imagen = new DefaultStreamedContent(stream, "image/"+urlFuente.replaceAll(".*\\.(\\w{3,4})$", "$1"));
        } catch (Exception e) {
            Log.getLogger().log(Level.SEVERE, e.getMessage(), e);
        }
        return imagen;
    }

    /**
     * @param imagen the imagen to set
     */
    public void setImagen(StreamedContent imagen) {
        this.imagen = imagen;
    }
    
}
