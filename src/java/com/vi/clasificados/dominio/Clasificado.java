
package com.vi.clasificados.dominio;

import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.PublicacionTipos;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Cacheable;
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
import javax.persistence.QueryHint;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 *
 * @author jerviver21
 */
@Entity
@Cacheable(true) 
@Table(name = "clasificado")
@NamedQueries({
    @NamedQuery(name = "Clasificado.findAll", query = "SELECT c FROM Clasificado c"),
    @NamedQuery(name = "Clasificado.findByUsr", query = "SELECT c FROM Clasificado c WHERE c.pedido.usuario =:usr"),
    @NamedQuery(name = "Clasificado.findByUsrEstado", query = "SELECT c FROM Clasificado c WHERE c.pedido.usuario =:usr AND c.estado =:estado"),
    @NamedQuery(name = "Clasificado.findByEstado", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado"),
    @NamedQuery(name = "Clasificado.findActWeb", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.subtipoPublicacion.tipoPublicacion =:tipopub"),
    @NamedQuery(name = "Clasificado.consultaCrit1", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipo =:tipo AND c.subtipoPublicacion.tipoPublicacion =:tipopub AND c.subtipo1 =:criterio1", hints = {@QueryHint(name = "org.hibernate.cacheable", value = "true")}),
    @NamedQuery(name = "Clasificado.consultaCrit12", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipo =:tipo AND c.subtipoPublicacion.tipoPublicacion =:tipopub AND c.subtipo1 =:criterio1 AND c.subtipo2 =:criterio2", hints = {@QueryHint(name = "org.hibernate.cacheable", value = "true")}),
    @NamedQuery(name = "Clasificado.consultaCrit13", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipo =:tipo AND c.subtipoPublicacion.tipoPublicacion =:tipopub AND c.subtipo1 =:criterio1 AND c.subtipo3 =:criterio3", hints = {@QueryHint(name = "org.hibernate.cacheable", value = "true")}),
    @NamedQuery(name = "Clasificado.consultaCrit123", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipo =:tipo AND c.subtipoPublicacion.tipoPublicacion =:tipopub AND c.subtipo1 =:criterio1 AND c.subtipo2 =:criterio2 AND c.subtipo3 =:criterio3", hints = {@QueryHint(name = "org.hibernate.cacheable", value = "true")}),
    @NamedQuery(name = "Clasificado.consultaCrit125", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipo =:tipo AND c.subtipoPublicacion.tipoPublicacion =:tipopub AND c.subtipo1 =:criterio1 AND c.subtipo2 =:criterio2  AND c.subtipo5 =:criterio5 ", hints = {@QueryHint(name = "org.hibernate.cacheable", value = "true")}),
    @NamedQuery(name = "Clasificado.consultaCrit1235", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipo =:tipo AND c.subtipoPublicacion.tipoPublicacion =:tipopub AND c.subtipo1 =:criterio1 AND c.subtipo2 =:criterio2 AND c.subtipo3 =:criterio3 AND c.subtipo5 =:criterio5 ", hints = {@QueryHint(name = "org.hibernate.cacheable", value = "true")}),
    @NamedQuery(name = "Clasificado.consultaCrit1245", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipo =:tipo AND c.subtipoPublicacion.tipoPublicacion =:tipopub AND c.subtipo1 =:criterio1 AND c.subtipo2 =:criterio2 AND c.subtipo4 =:criterio4 AND c.subtipo5 =:criterio5 ", hints = {@QueryHint(name = "org.hibernate.cacheable", value = "true")}),
    @NamedQuery(name = "Clasificado.consultaCrit12345", query = "SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipo =:tipo AND c.subtipoPublicacion.tipoPublicacion =:tipopub AND c.subtipo1 =:criterio1 AND c.subtipo2 =:criterio2 AND c.subtipo3 =:criterio3  AND c.subtipo4 =:criterio4 AND c.subtipo5 =:criterio5", hints = {@QueryHint(name = "org.hibernate.cacheable", value = "true")})
})
public class Clasificado implements Serializable {


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
    @Column(name = "url_img0")
    private String urlImg0;
    @Column(name = "nombre_ofertante")
    private String nombreOfertante;
    @Column(name = "titulo_oferta")
    private String tituloOferta;
    @Column(name = "fecha_ini")
    @Temporal(TemporalType.DATE)
    private Date fechaIni;
    @Column(name = "fecha_fin")
    @Temporal(TemporalType.DATE)
    private Date fechaFin;
    @Column(name = "precio")
    private BigDecimal precio;
    @Column(name = "valor_oferta")
    private BigDecimal valorOferta;


    @JoinColumn(name = "id_subtipo5", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private TipoClasificado subtipo5;
    @JoinColumn(name = "id_subtipo4", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private TipoClasificado subtipo4;
    @JoinColumn(name = "id_subtipo3", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private TipoClasificado subtipo3;
    @JoinColumn(name = "id_subtipo2", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private TipoClasificado subtipo2;
    @JoinColumn(name = "id_subtipo1", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private TipoClasificado subtipo1;
    @JoinColumn(name = "id_subtipo6", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private TipoClasificado subtipo6;
    @JoinColumn(name = "id_tipo", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private TipoClasificado tipo;
    
    @JoinColumn(name = "id_subtipo_publicacion", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private SubtipoPublicacion subtipoPublicacion;
    
    
    
    @JoinColumn(name = "id_pedido", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.EAGER)
    private Pedido pedido;
    
    @JoinColumn(name = "id_estado", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private EstadosClasificado estado;
    
    @JoinColumn(name = "id_currency_oferta", referencedColumnName = "id")
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    private Currencies moneda;
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "clasificado", fetch = FetchType.LAZY)
    private List<ImgClasificado> imgs;
    
    @Transient
    private String clasificadoFrac;
    
    @Transient
    private List<DetallePrecioClasificado> detallePrecio;
    
    @Transient
    private boolean editarEstado;
    
    @Transient
    private boolean agregarAPedido;
    

    public Clasificado() {
        tipo = new TipoClasificado(1);// 1 - Es el tipo: FINCA RAIZ 
        subtipo1 = null;
        subtipo2 = null;
        subtipo3 = null;
        subtipo4 = null;
        subtipo5 = null;
        subtipo6 = null;
        subtipoPublicacion = new SubtipoPublicacion();
        detallePrecio = new ArrayList<DetallePrecioClasificado>();
        imgs = new ArrayList<ImgClasificado>();
        numDias = 0;
        numPalabras = 0;
        moneda = new Currencies(2);///Por defecto queda en 2 = soles
        precio = BigDecimal.ZERO;
        estado = ClasificadoEstados.PEDIDOXPAGAR;
        valorOferta = BigDecimal.ZERO;
        fechaIni = new Date();
    }

    public Clasificado(Long id) {
        this.id = id;
    }

    public Clasificado(Long id, String clasificado) {
        this.id = id;
        this.clasificado = clasificado;
    }
    
    public Clasificado(Clasificado clasificado) {
        this.id = clasificado.getId();
        this.clasificado = clasificado.getClasificado();
        this.subtipo1 = clasificado.getSubtipo1() == null?null :new TipoClasificado(clasificado.getSubtipo1().getId());
        this.subtipo2 = clasificado.getSubtipo2() == null?null :new TipoClasificado(clasificado.getSubtipo2().getId());
        this.subtipo3 = clasificado.getSubtipo3() == null?null :new TipoClasificado(clasificado.getSubtipo3().getId());
        this.subtipo4 = clasificado.getSubtipo4() == null?null :new TipoClasificado(clasificado.getSubtipo4().getId());
        this.subtipo5 = clasificado.getSubtipo5() == null?null :new TipoClasificado(clasificado.getSubtipo5().getId());
        this.subtipo6 = clasificado.getSubtipo6() == null?null :new TipoClasificado(clasificado.getSubtipo6().getId());
        this.tipo = clasificado.getTipo() == null?null :new TipoClasificado(clasificado.getTipo().getId());
        this.precio = clasificado.getPrecio();
        this.fechaIni = clasificado.getFechaIni();
        this.fechaFin = clasificado.getFechaFin();
        this.numDias = clasificado.getNumDias();
        this.numPalabras = clasificado.getNumPalabras();
        this.estado = clasificado.getEstado() == null?null :new EstadosClasificado(clasificado.getEstado().getId());
        this.valorOferta = clasificado.getValorOferta();
        this.moneda = clasificado.getMoneda() == null?null :new Currencies(clasificado.getMoneda().getId());
        this.subtipoPublicacion = clasificado.getSubtipoPublicacion() == null?null :new SubtipoPublicacion(clasificado.getSubtipoPublicacion().getId());
        this.imgs = clasificado.getImgs();
        
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


    
    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
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

    /**
     * @return the pedido
     */
    public Pedido getPedido() {
        return pedido;
    }

    /**
     * @param pedido the pedido to set
     */
    public void setPedido(Pedido pedido) {
        this.pedido = pedido;
    }

    /**
     * @return the estado
     */
    public EstadosClasificado getEstado() {
        return estado;
    }

    /**
     * @param estado the estado to set
     */
    public void setEstado(EstadosClasificado estado) {
        this.estado = estado;
    }

    public void resetSubtipos() {
        subtipo1 = null;
        subtipo2 = null;
        subtipo3 = null;
        subtipo4 = null;
        subtipo5 = null;
    }

    /**
     * @return the editarEstado
     */
    public boolean isEditarEstado() {
        editarEstado = getSubtipoPublicacion().getTipoPublicacion().equals(PublicacionTipos.WEB) && (estado.equals(ClasificadoEstados.PUBLICADO) || estado.equals(ClasificadoEstados.CANCELADO) || estado.equals(ClasificadoEstados.VENDIDO));
        return editarEstado;
    }

    /**
     * @return the agregarAPedido
     */
    public boolean isAgregarAPedido() {
        agregarAPedido = estado.equals(ClasificadoEstados.PEDIDOVENCIDO) || estado.equals(ClasificadoEstados.EXPIRADO);
        return agregarAPedido;
    }

    /**
     * @return the valorOferta
     */
    public BigDecimal getValorOferta() {
        return valorOferta;
    }

    /**
     * @param valorOferta the valorOferta to set
     */
    public void setValorOferta(BigDecimal valorOferta) {
        this.valorOferta = valorOferta;
    }

    /**
     * @return the subtipo6
     */
    public TipoClasificado getSubtipo6() {
        return subtipo6;
    }

    /**
     * @param subtipo6 the subtipo6 to set
     */
    public void setSubtipo6(TipoClasificado subtipo6) {
        this.subtipo6 = subtipo6;
    }

    /**
     * @return the moneda
     */
    public Currencies getMoneda() {
        return moneda;
    }

    /**
     * @param moneda the moneda to set
     */
    public void setMoneda(Currencies moneda) {
        this.moneda = moneda;
    }


    /**
     * @return the imgs
     */
    public List<ImgClasificado> getImgs() {
        return imgs;
    }

    /**
     * @param imgs the imgs to set
     */
    public void setImgs(List<ImgClasificado> imgs) {
        this.imgs = imgs;
    }

    /**
     * @return the urlImg0
     */
    public String getUrlImg0() {
        return urlImg0;
    }

    /**
     * @param urlImg0 the urlImg0 to set
     */
    public void setUrlImg0(String urlImg0) {
        this.urlImg0 = urlImg0;
    }

    /**
     * @return the subtipoPublicacion
     */
    public SubtipoPublicacion getSubtipoPublicacion() {
        return subtipoPublicacion;
    }

    /**
     * @param subtipoPublicacion the subtipoPublicacion to set
     */
    public void setSubtipoPublicacion(SubtipoPublicacion subtipoPublicacion) {
        this.subtipoPublicacion = subtipoPublicacion;
    }

    /**
     * @return the nombreOfertante
     */
    public String getNombreOfertante() {
        return nombreOfertante;
    }

    /**
     * @param nombreOfertante the nombreOfertante to set
     */
    public void setNombreOfertante(String nombreOfertante) {
        this.nombreOfertante = nombreOfertante;
    }

    /**
     * @return the tituloOferta
     */
    public String getTituloOferta() {
        return tituloOferta;
    }

    /**
     * @param tituloOferta the tituloOferta to set
     */
    public void setTituloOferta(String tituloOferta) {
        this.tituloOferta = tituloOferta;
    }

    
}
