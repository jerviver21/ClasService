
package com.vi.clasificados.dominio;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import javax.persistence.Transient;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "clasificado")
@NamedQueries({
    @NamedQuery(name = "Clasificado.findAll", query = "SELECT c FROM Clasificado c")})
public class Clasificado implements Serializable {
    @Column(name = "area_oferta")
    private Integer areaOferta;
    @Column(name = "num_dias")
    private Integer numDias;
    @Column(name = "num_palabras")
    private Integer numPalabras;
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
    @Column(name = "fecha_ini")
    @Temporal(TemporalType.DATE)
    private Date fechaIni;
    @Column(name = "fecha_fin")
    @Temporal(TemporalType.DATE)
    private Date fechaFin;
    @Column(name = "precio")
    private BigDecimal precio;
    @Column(name = "salario_oferta")
    private BigDecimal salarioOferta;
    @Basic(optional = false)
    @Column(name = "id_estado")
    private int estado;
    @Column(name = "cod_pago")
    private String codPago;
    
    
    @Column(name = "precio_oferta")
    private BigDecimal precioOferta;
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
    
    @JoinColumn(name = "id_tipo_publicacion", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private TipoPublicacion tipoPublicacion;
    
    
    @Transient
    private List<String> opcionesPublicacion;
    
    @Transient
    private String clasificadoFrac;
    
    @Transient
    private List<DetallePrecioClasificado> detallePrecio;
    

    public Clasificado() {
        tipo = new TipoClasificado();
        subtipo1 = new TipoClasificado();
        subtipo2 = new TipoClasificado();
        subtipo3 = new TipoClasificado();
        subtipo4 = new TipoClasificado();
        subtipo5 = new TipoClasificado();
        tipoPublicacion = new TipoPublicacion();
        opcionesPublicacion = new ArrayList<String>();
        detallePrecio = new ArrayList<DetallePrecioClasificado>();
        areaOferta = 0;
        numDias = 0;
        numPalabras = 0;
        precioOferta = BigDecimal.ZERO;
        precio = BigDecimal.ZERO;
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
    
    public Clasificado(Clasificado clasificado) {
        this.id = clasificado.getId();
        this.clasificado = clasificado.getClasificado();
        this.usuario = clasificado.getUsuario();
        this.estado = clasificado.getEstado();
        this.subtipo1 = clasificado.getSubtipo1();
        this.subtipo2 = clasificado.getSubtipo2();
        this.subtipo3 = clasificado.getSubtipo3();
        this.subtipo4 = clasificado.getSubtipo4();
        this.subtipo5 = clasificado.getSubtipo5();
        this.tipo = clasificado.getTipo();
        this.areaOferta = clasificado.getAreaOferta();
        this.precioOferta = clasificado.getPrecioOferta();
        this.precio = clasificado.getPrecio();
        this.fechaIni = clasificado.getFechaIni();
        this.fechaFin = clasificado.getFechaFin();
        this.codPago = clasificado.getCodPago();
        this.numDias = clasificado.getNumDias();
        this.numPalabras = clasificado.getNumPalabras();
        detallePrecio = new ArrayList<DetallePrecioClasificado>();
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
        return clasificado;
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

    /**
     * @return the fechaIni
     */
    public Date getFechaIni() {
        return fechaIni;
    }

    /**
     * @param fechaIni the fechaIni to set
     */
    public void setFechaIni(Date fechaIni) {
        this.fechaIni = fechaIni;
    }

    /**
     * @return the fechaFin
     */
    public Date getFechaFin() {
        return fechaFin;
    }

    /**
     * @param fechaFin the fechaFin to set
     */
    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
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



    public void setAreaOferta(Integer areaOferta) {
        this.areaOferta = areaOferta;
    }

    public Integer getNumDias() {
        return numDias;
    }

    public void setNumDias(Integer numDias) {
        this.numDias = numDias;
    }

    public Integer getNumPalabras() {
        return numPalabras;
    }

    public void setNumPalabras(Integer numPalabras) {
        this.numPalabras = numPalabras;
    }

    /**
     * @return the opcionesPublicacion
     */
    public List<String> getOpcionesPublicacion() {
        return opcionesPublicacion;
    }

    /**
     * @param opcionesPublicacion the opcionesPublicacion to set
     */
    public void setOpcionesPublicacion(List<String> opcionesPublicacion) {
        this.opcionesPublicacion = opcionesPublicacion;
    }

    /**
     * @return the salarioOferta
     */
    public BigDecimal getSalarioOferta() {
        return salarioOferta;
    }

    /**
     * @param salarioOferta the salarioOferta to set
     */
    public void setSalarioOferta(BigDecimal salarioOferta) {
        this.salarioOferta = salarioOferta;
    }

    /**
     * @return the clasificadoFrac
     */
    public String getClasificadoFrac() {
        clasificadoFrac = clasificado.length() > 50 ? clasificado.substring(0, 49)+"..." : clasificado;
        return clasificadoFrac;
    }

    /**
     * @return the detallePrecio
     */
    public List<DetallePrecioClasificado> getDetallePrecio() {
        return detallePrecio;
    }

    /**
     * @param detallePrecio the detallePrecio to set
     */
    public void setDetallePrecio(List<DetallePrecioClasificado> detallePrecio) {
        this.detallePrecio = detallePrecio;
    }


    
}
