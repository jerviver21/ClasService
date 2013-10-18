/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.Currencies;
import com.vi.clasificados.dominio.DetallePrecioClasificado;
import com.vi.clasificados.dominio.DiasPrecios;
import com.vi.clasificados.dominio.TipoPublicacion;
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
 *
 * @author jerviver21
 */
@Stateless
@LocalBean
public class PublicacionService {
    
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;
    
    @EJB
    TiposPublicacionService tipoPubService;
    
    Map<String, TipoPublicacion> tiposPublicacion;
    
    ParameterLocator locator;
    
    @PostConstruct
    public void init(){
        locator = ParameterLocator.getInstance();
        tiposPublicacion = tipoPubService.findAllTiposMapa();
    }

    //Métodos de procesamiento de la lógica del negocio
    public List<Clasificado> procesarClasificado(Clasificado clasificado){
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        for(String tipo : clasificado.getOpcionesPublicacion()){
            Clasificado nuevoClas = new Clasificado(clasificado);
            System.out.println("---> "+clasificado.getExtImg1()+" - "+clasificado.getImg1());
            nuevoClas.setTipoPublicacion(tiposPublicacion.get(tipo));
            Map preciosXDia = tiposPublicacion.get(tipo).getMapaPrecios();
            calcularValores(nuevoClas, preciosXDia);
            clasificados.add(nuevoClas);
        }
        return clasificados;
    }
    
    public Clasificado procesarEdicion(Clasificado clasificado){
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
        Currencies moneda = (Currencies)em.find(Currencies.class, clasificado.getMoneda().getId());
        new SelectorRangos().setRangoValores(clasificado, moneda);  
    }

    public BigDecimal calcularTotalPedido(List<Clasificado> clasificados) {
        BigDecimal total = BigDecimal.ZERO;
        for(Clasificado clasificado: clasificados){
            total = total.add(clasificado.getPrecio());
        }
        return total;
    }
    
    

}
