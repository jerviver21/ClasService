
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.DetallePrecioClasificado;
import com.vi.clasificados.dominio.DiasPrecios;
import com.vi.clasificados.dominio.EstadosClasificado;
import com.vi.clasificados.dominio.TipoPublicacion;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.ClasificadosTipo;
import com.vi.clasificados.utils.PublicacionesTipos;
import com.vi.comun.locator.ParameterLocator;
import com.vi.comun.util.FechaUtils;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
        for(String tipo : clasificado.getOpcionesPublicacion()){
            Clasificado nuevoClas = new Clasificado(clasificado);
            nuevoClas.setTipoPublicacion(tiposPublicacion.get(tipo));
            Map preciosXDia = tiposPublicacion.get(tipo).getMapaPrecios();
            calcularPrecio(nuevoClas, preciosXDia);
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
        calcularPrecio(clasificado, preciosXDia);
        return clasificado;
    }
    
    public void calcularPrecio(Clasificado clasificado, Map preciosXDia){
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
    }

    public BigDecimal calcularTotalPedido(List<Clasificado> clasificados) {
        BigDecimal total = BigDecimal.ZERO;
        for(Clasificado clasificado: clasificados){
            total = total.add(clasificado.getPrecio());
        }
        return total;
    }

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
    
    public List<EstadosClasificado> getEstados() {
        List<EstadosClasificado> estados = em.createNamedQuery("EstadosClasificado.findAll").getResultList();
        return estados;
    }
    
    public List<EstadosClasificado> getEstadosEditables() {
        List<EstadosClasificado> estados = em.createQuery("SELECT e  "
                + "FROM EstadosClasificado e "
                + "WHERE e.id ="+ClasificadoEstados.CANCELADO.getId()+" "
                + "OR e.id = "+ClasificadoEstados.PUBLICADO.getId()+" "
                + "OR e.id = "+ClasificadoEstados.VENDIDO.getId()+" ").getResultList();
        return estados;
    }

    public void edit(Clasificado clasificado) {
        em.merge(clasificado);
    }



    public Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> getClasificadosEmpleo() {
        Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>  clasificados = new HashMap<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>();
        List<Clasificado> empleos = em.createNamedQuery("Clasificado.findForFiltro")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.EMPLEO).getResultList();
        
        for(Clasificado empleo:empleos){
            Map<Integer, Map<Integer, List<Clasificado>>> mapa1 = clasificados.get(empleo.getSubtipo1().getId());
            if(mapa1 == null){
                mapa1 = new HashMap<Integer, Map<Integer, List<Clasificado>>>();
                clasificados.put(empleo.getSubtipo1().getId(), mapa1);
            }
            Map<Integer, List<Clasificado>> mapa2 = mapa1.get(empleo.getSubtipo2().getId());
            if(mapa2 == null){
                mapa2 = new HashMap<Integer, List<Clasificado>>();
                mapa1.put(empleo.getSubtipo2().getId(), mapa2);
            }
            List<Clasificado> conjunto = mapa2.get(empleo.getSubtipo3().getId());
            if(conjunto == null){
                conjunto = new ArrayList<Clasificado>();
                mapa2.put(empleo.getSubtipo3().getId(), conjunto);
            }
            conjunto.add(empleo);
        }
        return clasificados;
    }

    public List<Clasificado> getEmpleosFiltro(Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> mapaClasificados, int... filtros) {
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        Set<Map<Integer, Map<Integer, List<Clasificado>>>> escaneo1nivel = new HashSet<Map<Integer, Map<Integer, List<Clasificado>>>>();
        Set<Map<Integer, List<Clasificado>>> escaneo2nivel = new HashSet< Map<Integer, List<Clasificado>>>();
        Set<List<Clasificado>> escaneo3nivel = new HashSet<List<Clasificado>>();
        
        if(filtros[0] == 0){
            Set<Integer> subs = mapaClasificados.keySet();
            for(Integer sub:subs){
                escaneo1nivel.add(mapaClasificados.get(sub));
            }
        }else{
            Map<Integer, Map<Integer, List<Clasificado>>> mapa1 = mapaClasificados.get(filtros[0]);
            if(mapa1 != null){
                escaneo1nivel.add(mapa1);
            }
        }
        
        if(filtros[1] == 0){
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:escaneo1nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo2nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:escaneo1nivel){
                Map<Integer, List<Clasificado>> mapa2 = lista.get(filtros[1]);
                if(mapa2 != null){
                    escaneo2nivel.add(mapa2);
                }
            }
        }
        
        if(filtros[2] == 0){
            for(Map<Integer, List<Clasificado>> lista:escaneo2nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo3nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, List<Clasificado>> lista:escaneo2nivel){
                List<Clasificado> conjunto = lista.get(filtros[2]);
                if(conjunto != null){
                    escaneo3nivel.add(conjunto);
                }
            }
        }
        
        for(List<Clasificado> conjunto:escaneo3nivel){
            clasificados.addAll(conjunto);
        }
        
        return clasificados;
    }
    
    
}
