
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.DetallePrecioClasificado;
import com.vi.clasificados.dominio.DiasPrecios;
import com.vi.clasificados.dominio.TipoPublicacion;
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
    
    @PostConstruct
    public void init(){
        tiposPublicacion = tipoPubService.findAllTiposMapa();
        locator = ParameterLocator.getInstance();
    }
    
    public List<Clasificado> procesarClasificado(Clasificado clasificado){
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        int numPalabras = clasificado.getClasificado().split("[\\s_-]").length;
        for(String tipo : clasificado.getOpcionesPublicacion()){
            Clasificado nuevoClas = new Clasificado(clasificado);
            Map<Integer, DetallePrecioClasificado> mapaDetalle = new HashMap<Integer, DetallePrecioClasificado>();
            nuevoClas.setTipoPublicacion(tiposPublicacion.get(tipo));
            Calendar calendario = Calendar.getInstance();
            calendario.setTime(clasificado.getFechaIni());
            Map preciosXDia = tiposPublicacion.get(tipo).getMapaPrecios();
            while(calendario.getTime().getTime() <= clasificado.getFechaFin().getTime()){
                DiasPrecios precio = (DiasPrecios)preciosXDia.get(calendario.get(FechaUtils.isFestivo(calendario.getTime())?100:Calendar.DAY_OF_WEEK));
                if(precio.getPrecio().getProcesarXPalabra()){
                   nuevoClas.setPrecio(nuevoClas.getPrecio().add(precio.getPrecio().getPrecio().multiply(new BigDecimal(numPalabras)))); 
                }else{
                   nuevoClas.setPrecio(nuevoClas.getPrecio().add(precio.getPrecio().getPrecio())); 
                }
                calendario.add(Calendar.DATE, 1);
                nuevoClas.setNumDias(nuevoClas.getNumDias()+1);
                nuevoClas.setNumPalabras(numPalabras);
                DetallePrecioClasificado detalle = mapaDetalle.get(precio.getPrecio().getId());
                if(detalle == null){
                    detalle = new DetallePrecioClasificado();
                    detalle.setPrecio(precio.getPrecio());
                    detalle.setNumPalabras(numPalabras);
                    nuevoClas.getDetallePrecio().add(detalle);
                    mapaDetalle.put(precio.getPrecio().getId(), detalle);
                }
                detalle.setNumDias(detalle.getNumDias()+1);
            }
            clasificados.add(nuevoClas);
            
        }
        return clasificados;
    }
    
    public Clasificado editarClasificado(Clasificado clasificado){
        int numPalabras = clasificado.getClasificado().split("[\\s_-]").length;
        clasificado.setNumDias(0);
        clasificado.setNumPalabras(0);
        clasificado.setPrecio(BigDecimal.ZERO);
        clasificado.setDetallePrecio(new ArrayList<DetallePrecioClasificado>());
        Map<Integer, DetallePrecioClasificado> mapaDetalle = new HashMap<Integer, DetallePrecioClasificado>();
        Calendar calendario = Calendar.getInstance();
        calendario.setTime(clasificado.getFechaIni());
        Map preciosXDia = clasificado.getTipoPublicacion().getMapaPrecios();
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
        return clasificado;
    }

    public BigDecimal calcularTotalPedido(List<Clasificado> clasificados) {
        BigDecimal total = BigDecimal.ZERO;
        for(Clasificado clasificado: clasificados){
            total = total.add(clasificado.getPrecio());
        }
        return total;
    }
    
    
}
