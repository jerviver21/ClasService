/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "entidades_pago")
@NamedQueries({
    @NamedQuery(name = "EntidadesPago.findAll", query = "SELECT e FROM EntidadesPago e")})
public class EntidadesPago implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "nombre")
    private String nombre;
    @Column(name = "num_cuenta_recaudo")
    private String numCuentaRecaudo;
    @Column(name = "clave")
    private String clave;
    @Column(name = "direccion_ip")
    private String direccionIp;
    @Column(name = "nombre_usuario")
    private String nombreUsuario;
    @Column(name = "mensaje_pago")
    private String mensajePago;

    public EntidadesPago() {
        id = 2;
    }

    public EntidadesPago(Integer id) {
        this.id = id;
    }

    public EntidadesPago(Integer id, String nombre) {
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

    public String getNumCuentaRecaudo() {
        return numCuentaRecaudo;
    }

    public void setNumCuentaRecaudo(String numCuentaRecaudo) {
        this.numCuentaRecaudo = numCuentaRecaudo;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getDireccionIp() {
        return direccionIp;
    }

    public void setDireccionIp(String direccionIp) {
        this.direccionIp = direccionIp;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
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
        if (!(object instanceof EntidadesPago)) {
            return false;
        }
        EntidadesPago other = (EntidadesPago) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.EntidadesPago[ id=" + id + " ]";
    }

    /**
     * @return the mensajePago
     */
    public String getMensajePago() {
        return mensajePago;
    }

    /**
     * @param mensajePago the mensajePago to set
     */
    public void setMensajePago(String mensajePago) {
        this.mensajePago = mensajePago;
    }
    
}
