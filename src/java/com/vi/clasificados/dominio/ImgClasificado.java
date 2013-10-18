/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import com.vi.comun.util.Log;
import java.io.File;
import java.io.FileInputStream;
import java.io.Serializable;
import java.util.logging.Level;
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
import javax.validation.constraints.Size;
import org.primefaces.model.DefaultStreamedContent;
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
    @Column(name = "ruta_imagenes")
    private String rutaImagenes;
    
    @Transient
    private StreamedContent imagen;


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

    public String getRutaImagenes() {
        return rutaImagenes;
    }

    public void setRutaImagenes(String rutaImagenes) {
        this.rutaImagenes = rutaImagenes;
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
     * @return the imagen
     */
    public StreamedContent getImagen() {
        try {
            File inFile = new File(rutaImagenes);
            System.out.println("Clasificado: Imagen que se está cargando: "+rutaImagenes+" - extension: "+rutaImagenes.replaceAll(".*\\.(\\w{3,4})$", "$1"));
            FileInputStream in = new FileInputStream(inFile);
            imagen = new DefaultStreamedContent(in, "image/"+rutaImagenes.replaceAll(".*\\.(\\w{3,4})$", "$1"));
        } catch (Exception e) {
            System.out.println("OJO Estallon de origen");
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
