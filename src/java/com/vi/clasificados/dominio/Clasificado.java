
package com.vi.clasificados.dominio;

import java.io.Serializable;
import java.math.BigDecimal;
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

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "clasificado")
@NamedQueries({
    @NamedQuery(name = "Clasificado.findAll", query = "SELECT c FROM Clasificado c")})
public class Clasificado implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Basic(optional = false)
    @Column(name = "clasificado")
    private String clasificado;
    @Basic(optional = false)
    @Column(name = "usuario")
    private String usuario;
    @Column(name = "fecha_ini_impreso")
    @Temporal(TemporalType.DATE)
    private Date fechaIniImpreso;
    @Column(name = "fecha_fin_impreso")
    @Temporal(TemporalType.DATE)
    private Date fechaFinImpreso;
    @Column(name = "fecha_ini_web")
    @Temporal(TemporalType.DATE)
    private Date fechaIniWeb;
    @Column(name = "fecha_fin_web")
    @Temporal(TemporalType.DATE)
    private Date fechaFinWeb;
    @Column(name = "precio")
    private BigDecimal precio;
    @Basic(optional = false)
    @Column(name = "id_estado")
    private int estado;
    @Column(name = "cod_pago")
    private String codPago;
    @Column(name = "precio_impresion")
    private BigDecimal precioImpresion;
    @Column(name = "precio_web")
    private BigDecimal precioWeb;
    @Column(name = "publicarweb")
    private Boolean publicarWeb;
    @Column(name = "publicarimpreso")
    private Boolean publicarImpreso;
    
    
    @Column(name = "precio_oferta")
    private BigDecimal precioOferta;
    @Column(name = "area_oferta")
    private int areaOferta;
    @JoinColumn(name = "id_subtipo5", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private TipoClasificado subtipo5;
    @JoinColumn(name = "id_subtipo4", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private TipoClasificado subtipo4;
    @JoinColumn(name = "id_subtipo3", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private TipoClasificado subtipo3;
    @JoinColumn(name = "id_subtipo2", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private TipoClasificado subtipo2;
    @JoinColumn(name = "id_subtipo1", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private TipoClasificado subtipo1;
    @JoinColumn(name = "id_tipo", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private TipoClasificado tipo;
    
    

    public Clasificado() {
    }

    public Clasificado(Long id) {
        this.id = id;
    }

    public Clasificado(Long id, String clasificado, String usuario, int idEstado) {
        this.id = id;
        this.clasificado = clasificado;
        this.usuario = usuario;
        this.estado = idEstado;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getClasificado() {
        return clasificado;
    }

    public void setClasificado(String clasificado) {
        this.clasificado = clasificado;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public Date getFechaIniImpreso() {
        return fechaIniImpreso;
    }

    public void setFechaIniImpreso(Date fechaIniImpreso) {
        this.fechaIniImpreso = fechaIniImpreso;
    }

    public Date getFechaFinImpreso() {
        return fechaFinImpreso;
    }

    public void setFechaFinImpreso(Date fechaFinImpreso) {
        this.fechaFinImpreso = fechaFinImpreso;
    }

    public Date getFechaIniWeb() {
        return fechaIniWeb;
    }

    public void setFechaIniWeb(Date fechaIniWeb) {
        this.fechaIniWeb = fechaIniWeb;
    }

    public Date getFechaFinWeb() {
        return fechaFinWeb;
    }

    public void setFechaFinWeb(Date fechaFinWeb) {
        this.fechaFinWeb = fechaFinWeb;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int idEstado) {
        this.estado = idEstado;
    }

    public String getCodPago() {
        return codPago;
    }

    public void setCodPago(String codPago) {
        this.codPago = codPago;
    }

    public BigDecimal getPrecioImpresion() {
        return precioImpresion;
    }

    public void setPrecioImpresion(BigDecimal precioImpresion) {
        this.precioImpresion = precioImpresion;
    }

    public BigDecimal getPrecioWeb() {
        return precioWeb;
    }

    public void setPrecioWeb(BigDecimal precioWeb) {
        this.precioWeb = precioWeb;
    }

    public TipoClasificado getSubtipo5() {
        return subtipo5;
    }

    public void setSubtipo5(TipoClasificado idSubtipo5) {
        this.subtipo5 = idSubtipo5;
    }

    public TipoClasificado getSubtipo4() {
        return subtipo4;
    }

    public void setSubtipo4(TipoClasificado idSubtipo4) {
        this.subtipo4 = idSubtipo4;
    }

    public TipoClasificado getSubtipo3() {
        return subtipo3;
    }

    public void setSubtipo3(TipoClasificado idSubtipo3) {
        this.subtipo3 = idSubtipo3;
    }

    public TipoClasificado getSubtipo2() {
        return subtipo2;
    }

    public void setSubtipo2(TipoClasificado idSubtipo2) {
        this.subtipo2 = idSubtipo2;
    }

    public TipoClasificado getSubtipo1() {
        return subtipo1;
    }

    public void setSubtipo1(TipoClasificado idSubtipo1) {
        this.subtipo1 = idSubtipo1;
    }

    public TipoClasificado getTipo() {
        return tipo;
    }

    public void setTipo(TipoClasificado idTipo) {
        this.tipo = idTipo;
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
        if (!(object instanceof Clasificado)) {
            return false;
        }
        Clasificado other = (Clasificado) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.Clasificado[ id=" + id + " ]";
    }

    /**
     * @return the publicarWeb
     */
    public Boolean getPublicarWeb() {
        return publicarWeb;
    }

    /**
     * @param publicarWeb the publicarWeb to set
     */
    public void setPublicarWeb(Boolean publicarWeb) {
        this.publicarWeb = publicarWeb;
    }

    /**
     * @return the publicarImpreso
     */
    public Boolean getPublicarImpreso() {
        return publicarImpreso;
    }

    /**
     * @param publicarImpreso the publicarImpreso to set
     */
    public void setPublicarImpreso(Boolean publicarImpreso) {
        this.publicarImpreso = publicarImpreso;
    }

    /**
     * @return the precioOferta
     */
    public BigDecimal getPrecioOferta() {
        return precioOferta;
    }

    /**
     * @param precioOferta the precioOferta to set
     */
    public void setPrecioOferta(BigDecimal precioOferta) {
        this.precioOferta = precioOferta;
    }

    /**
     * @return the areaOferta
     */
    public int getAreaOferta() {
        return areaOferta;
    }

    /**
     * @param areaOferta the areaOferta to set
     */
    public void setAreaOferta(int areaOferta) {
        this.areaOferta = areaOferta;
    }
    
}
