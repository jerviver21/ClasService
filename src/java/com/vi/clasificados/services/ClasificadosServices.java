
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.DetallePrecioClasificado;
import com.vi.clasificados.dominio.DiasPrecios;
import com.vi.clasificados.dominio.EstadosClasificado;
import com.vi.clasificados.dominio.TipoPublicacion;
import com.vi.clasificados.locator.ClasificadosCachingLocator;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.PublicacionesTipos;
import com.vi.clasificados.utils.SelectorRangos;
import com.vi.comun.locator.ParameterLocator;
import com.vi.comun.util.FechaUtils;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * @author jerviver21
 */
@Stateless
@LocalBean
public class ClasificadosServices {
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;
    
    @EJB
    TiposPublicacionService tipoPubService;
    
    Map<String, TipoPublicacion> tiposPublicacion;
    ParameterLocator locator;
    ClasificadosCachingLocator caching;
    
    @PostConstruct
    public void init(){
        tiposPublicacion = tipoPubService.findAllTiposMapa();
        locator = ParameterLocator.getInstance();
        caching = ClasificadosCachingLocator.getInstance(getClasificadosActivos());
    }
    
    public ClasificadosServices(){
        
    }
    
    //Métodos básicos del EJB
    public void edit(Clasificado clasificado) {
        em.merge(clasificado);
    }
    
    
    //Métodos de procesamiento de la lógica del negocio
    public List<Clasificado> procesarClasificado(Clasificado clasificado){
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        for(String tipo : clasificado.getOpcionesPublicacion()){
            Clasificado nuevoClas = new Clasificado(clasificado);
            nuevoClas.setTipoPublicacion(tiposPublicacion.get(tipo));
            Map preciosXDia = tiposPublicacion.get(tipo).getMapaPrecios();
            calcularValores(nuevoClas, preciosXDia);
            clasificados.add(nuevoClas);
        }
        return clasificados;
    }
    
    public Clasificado editarClasificado(Clasificado clasificado){
        clasificado.setNumDias(0);
        clasificado.setNumPalabras(0);
        clasificado.setPrecio(BigDecimal.ZERO);
        clasificado.setDetallePrecio(new ArrayList<DetallePrecioClasificado>());
        Map preciosXDia = clasificado.getTipoPublicacion().getMapaPrecios();
        calcularValores(clasificado, preciosXDia);
        return clasificado;
    }
    
    public void calcularValores(Clasificado clasificado, Map preciosXDia){
        int numPalabras = clasificado.getClasificado().split("[\\s_-]").length;
        Map<Integer, DetallePrecioClasificado> mapaDetalle = new HashMap<Integer, DetallePrecioClasificado>();
        Calendar calendario = Calendar.getInstance();
        calendario.setTime(clasificado.getFechaIni());
        while(calendario.getTime().getTime() <= clasificado.getFechaFin().getTime()){
            DiasPrecios precio = (DiasPrecios)preciosXDia.get(calendario.get(FechaUtils.isFestivo(calendario.getTime())?100:Calendar.DAY_OF_WEEK));//100 indica que es un festivo
            if(precio.getPrecio().getProcesarXPalabra()){
               clasificado.setPrecio(clasificado.getPrecio().add(precio.getPrecio().getPrecio().multiply(new BigDecimal(numPalabras)))); 
            }else{
               clasificado.setPrecio(clasificado.getPrecio().add(precio.getPrecio().getPrecio())); 
            }
            calendario.add(Calendar.DATE, 1);
            clasificado.setNumDias(clasificado.getNumDias()+1);
            clasificado.setNumPalabras(numPalabras);
            DetallePrecioClasificado detalle = mapaDetalle.get(precio.getPrecio().getId());
            if(detalle == null){
                detalle = new DetallePrecioClasificado();
                detalle.setPrecio(precio.getPrecio());
                detalle.setNumPalabras(clasificado.getNumPalabras());
                clasificado.getDetallePrecio().add(detalle);
                mapaDetalle.put(precio.getPrecio().getId(), detalle);
            }
            detalle.setNumDias(detalle.getNumDias()+1);
        }
        SelectorRangos sr = new SelectorRangos();
        clasificado.getMoneda().getCambio();
        sr.setRangoValores(clasificado);
    }

    public BigDecimal calcularTotalPedido(List<Clasificado> clasificados) {
        BigDecimal total = BigDecimal.ZERO;
        for(Clasificado clasificado: clasificados){
            total = total.add(clasificado.getPrecio());
        }
        return total;
    }

    //Métodos de Consultas básicas
    public List<Clasificado> getClasificados(String usr, EstadosClasificado estado) {
        List<Clasificado> clasificados;
        if(estado == null){
            clasificados = em.createNamedQuery("Clasificado.findByUsr").setParameter("usr", usr).getResultList();
        }else{
            clasificados = em.createNamedQuery("Clasificado.findByUsrEstado")
                    .setParameter("usr", usr).setParameter("estado", estado).getResultList();
        }
        return clasificados;
    }

    

    public List<Clasificado> getClasificadosActivos() {
        List<Clasificado> clasificados = em.createNamedQuery("Clasificado.findForFiltro")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET).getResultList();
        return clasificados;
    }
    
    
    //Métodos de consulta de filtros
    public List<Clasificado> getFiltro(int TIPO, int... parametros){
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        switch(TIPO){
            case ClasificadosCachingLocator.INMOBILIARIO:
                clasificados = caching.getInmobiliarioFiltro(parametros[0], parametros[1], parametros[2], parametros[3], parametros[4]);
                break;
            case ClasificadosCachingLocator.EMPLEO:
                clasificados = caching.getEmpleoFiltro(parametros[0], parametros[1], parametros[2]);
                break;
            case ClasificadosCachingLocator.VEHICULOS:
                clasificados = caching.getVehiculosFiltro(parametros[0], parametros[1], parametros[2]);
                break;
            case ClasificadosCachingLocator.VARIOS:
                clasificados = caching.getVariosFiltro(parametros[0]);
                break;
        }
        
        return clasificados;
    }
    
    public void recargarCache(){
        caching.setCacheClasificados(getClasificadosActivos());
    }
    
    



    
    
    
}
