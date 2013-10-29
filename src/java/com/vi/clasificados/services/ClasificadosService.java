
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.EstadosClasificado;
import com.vi.clasificados.locator.ClasificadosCachingLocator;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.PublicacionesTipos;
import com.vi.comun.exceptions.ParametroException;
import com.vi.comun.locator.ParameterLocator;
import com.vi.comun.util.FechaUtils;
import com.vi.comun.util.Log;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
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
public class ClasificadosService {
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;
    
    @EJB
    ConsultasService consultaService;

    ParameterLocator locator;
    ClasificadosCachingLocator caching;
    
    @PostConstruct
    public void init(){
        locator = ParameterLocator.getInstance();
        caching = ClasificadosCachingLocator.getInstance(getClasificadosActivos());
    }
    
    public ClasificadosService(){
        
    }
    
    //Métodos básicos del EJB
    public void edit(Clasificado clasificado) {
        em.merge(clasificado);
    }
    
    public Clasificado find(Long id){
        return em.find(Clasificado.class, id);
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
        List<Clasificado> clasificados = em.createNamedQuery("Clasificado.findForFiltroCache")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET).getResultList();
        return clasificados;
    }
    
    
    //Métodos de consulta de filtros
    public List<Clasificado> getFiltro(int TIPO, int... parametros){
        boolean utilizarCache = Boolean.parseBoolean(locator.getParameter("consultas_x_cache"));
        
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        switch(TIPO){
            case ClasificadosCachingLocator.INMOBILIARIO:
                clasificados = utilizarCache ? caching.getInmobiliarioFiltro(parametros[0], parametros[1], parametros[2], parametros[3], parametros[4])
                        :consultaService.consultarInmobiliarios(parametros[0], parametros[1], parametros[2], parametros[3], parametros[4]);
                break;
            case ClasificadosCachingLocator.EMPLEO:
                clasificados = utilizarCache ?  caching.getEmpleoFiltro(parametros[0], parametros[1], parametros[2])
                        :consultaService.consultarEmpleos(parametros[0], parametros[1], parametros[2]);
                break;
            case ClasificadosCachingLocator.VEHICULOS:
                clasificados = utilizarCache ?  caching.getVehiculosFiltro(parametros[0], parametros[1], parametros[2])
                        :consultaService.consultarVehiculos(parametros[0], parametros[1], parametros[2]);
                break;
            case ClasificadosCachingLocator.VARIOS:
                clasificados = utilizarCache ?  caching.getVariosFiltro(parametros[0])
                        :consultaService.consultarVarios(parametros[0]);
                break;
        }
        
        return clasificados;
    }
    
    public void recargarCache(){
        caching.setCacheClasificados(getClasificadosActivos());
    }
    
    public void actualizarEstados()throws ParametroException{
        
        Boolean depurar = Boolean.parseBoolean(locator.getParameter("depurar"));
        if(depurar == null){
            throw  new ParametroException("No existe el parámetro depurar");
        }
        
        Date fechaHoy = FechaUtils.getFechaHoy();
        
        List<Clasificado> clasificados = em.createNamedQuery("Clasificado.findByEstado")
                .setParameter("estado", ClasificadoEstados.PUBLICADO).getResultList();
        
        if(depurar){
            Log.getLogger().log(Level.INFO, "Clasificados publicados: -> {0}", clasificados.size());
        }
        
        for(Clasificado clasificado:clasificados){
            if(clasificado.getFechaFin().before(fechaHoy)){
                clasificado.setEstado(ClasificadoEstados.EXPIRADO);
                em.merge(clasificado);
            }
            
            if(depurar){
                Log.getLogger().log(Level.INFO, "Fecha Hoy: {0} - Fecha Fin: {1} - Clasificado: {2} - Nuevo estado: {3}", new Object[]{fechaHoy, clasificado.getFechaFin(), clasificado.getClasificado(), clasificado.getEstado().getId()});
            }
        }

    }
    

    
}
