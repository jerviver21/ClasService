
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.DiasPrecios;
import com.vi.clasificados.dominio.TipoPublicacion;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
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
    
    @PostConstruct
    public void init(){
        tiposPublicacion = tipoPubService.findAllTiposMapa();
    }
    
    public List<Clasificado> procesarClasificado(Clasificado clasificado){
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        int numPalabras = clasificado.getClasificado().split("[\\s_-]").length;
        
        BigDecimal valorTotal = BigDecimal.ZERO;
        
        for(String tipo : clasificado.getOpcionesPublicacion()){
            Clasificado nuevoClas = new Clasificado(clasificado);
            nuevoClas.setTipoPublicacion(tiposPublicacion.get(tipo));
            Calendar calendario = Calendar.getInstance();
            calendario.setTime(clasificado.getFechaIni());
            Map preciosXDia = tiposPublicacion.get(tipo).getMapaPrecios();
            while(calendario.getTime().getTime() <= clasificado.getFechaFin().getTime()){
                DiasPrecios precio = (DiasPrecios)preciosXDia.get(calendario.get(Calendar.DAY_OF_WEEK));
                if(precio.getPrecio().getProcesarXPalabra()){
                   nuevoClas.setPrecio(precio.getPrecio().getPrecio().multiply(new BigDecimal(numPalabras))); 
                }else{
                   nuevoClas.setPrecio(precio.getPrecio().getPrecio()); 
                }
                valorTotal = valorTotal.add(nuevoClas.getPrecio());
                calendario.add(Calendar.DATE, 1);
                nuevoClas.setNumDias(nuevoClas.getNumDias()+1);
                nuevoClas.setNumPalabras(numPalabras);
            }
            clasificados.add(nuevoClas);
            
        }
        
        
        return clasificados;
    }
    
    
}
