/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import com.vi.clasificados.utils.PedidoEstados;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 *
 * @author jerviver21
 */
@Entity
@Table(name = "pedido")
@NamedQueries({
    @NamedQuery(name = "Pedido.findAll", query = "SELECT p FROM Pedido p")})
public class Pedido implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Basic(optional = false)
    @Column(name = "usuario")
    private String usuario;
    @Column(name = "cod_pago")
    private String codPago;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Basic(optional = false)
    @Column(name = "valor_total")
    private BigDecimal valorTotal;
    @Basic(optional = false)
    @Column(name = "fecha_vencimiento")
    @Temporal(TemporalType.DATE)
    private Date fechaVencimiento;
    @Column(name = "fecha_hora_pago")
    @Temporal(TemporalType.DATE)
    private Date fechaHoraPago;
    @Column(name = "cod_confirmacion")
    private String codConfirmacion;
    @JoinColumn(name = "id_estado", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private EstadosPedido estado;
    @JoinColumn(name = "id_entidad_pago", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private EntidadesPago entidad;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "pedido", fetch = FetchType.LAZY)
    private List<Clasificado> clasificados;
    
    @Transient
    private String mensajePago;

    public Pedido() {
        clasificados = new ArrayList<Clasificado>();
        valorTotal = BigDecimal.ZERO;
        estado = PedidoEstados.ACTIVO_PAGO;
        entidad = new EntidadesPago();
    }
    
    public Pedido(String usuario) {
        this.usuario = usuario;
        clasificados = new ArrayList<Clasificado>();
        valorTotal = BigDecimal.ZERO;
        estado = PedidoEstados.ACTIVO_PAGO;
        entidad = new EntidadesPago();
    }

    public Pedido(Long id) {
        this.id = id;
    }

    public Pedido(Long id, String usuario, BigDecimal valorTotal, Date fechaVencimiento) {
        this.id = id;
        this.usuario = usuario;
        this.valorTotal = valorTotal;
        this.fechaVencimiento = fechaVencimiento;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getCodPago() {
        return codPago;
    }

    public void setCodPago(String codPago) {
        this.codPago = codPago;
    }

    public BigDecimal getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(BigDecimal valorTotal) {
        this.valorTotal = valorTotal;
    }

    public Date getFechaVencimiento() {
        return fechaVencimiento;
    }

    public void setFechaVencimiento(Date fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }

    public Date getFechaHoraPago() {
        return fechaHoraPago;
    }

    public void setFechaHoraPago(Date fechaHoraPago) {
        this.fechaHoraPago = fechaHoraPago;
    }

    public String getCodConfirmacion() {
        return codConfirmacion;
    }

    public void setCodConfirmacion(String codConfirmacion) {
        this.codConfirmacion = codConfirmacion;
    }

    public EstadosPedido getEstado() {
        return estado;
    }

    public void setEstado(EstadosPedido idEstado) {
        this.estado = idEstado;
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
        if (!(object instanceof Pedido)) {
            return false;
        }
        Pedido other = (Pedido) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vi.clasificados.dominio.Pedido[ id=" + id + " ]";
    }

    /**
     * @return the clasificados
     */
    public List<Clasificado> getClasificados() {
        return clasificados;
    }

    /**
     * @param clasificados the clasificados to set
     */
    public void setClasificados(List<Clasificado> clasificados) {
        this.clasificados = clasificados;
    }

    /**
     * @return the entidad
     */
    public EntidadesPago getEntidad() {
        return entidad;
    }

    /**
     * @param entidad the entidad to set
     */
    public void setEntidad(EntidadesPago entidad) {
        this.entidad = entidad;
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
