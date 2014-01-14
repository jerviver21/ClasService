
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.EstadosClasificado;
import com.vi.clasificados.dominio.ImgClasificado;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.PublicacionTipos;
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
    
    @PostConstruct
    public void init(){
        locator = ParameterLocator.getInstance();
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
    
    public Clasificado findWithImgs(Long id){
        Clasificado clasificado = em.find(Clasificado.class, id);
        for(ImgClasificado img : clasificado.getImgs()){
            img.getExtension();
        }
        return clasificado;
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
        List<Clasificado> clasificados = em.createNamedQuery("Clasificado.findActWeb")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipopub", PublicacionTipos.WEB)
                .getResultList();
        return clasificados;
    }
    
    
    //Métodos de consulta de filtros seleccionados por el usuario
    public List<Clasificado> consultar(int TIPO, int... parametros){
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        switch(TIPO){
            case ConsultasService.INMOBILIARIO:
                clasificados = consultaService.consultarInmobiliarios(parametros[0], parametros[1], parametros[2], parametros[3], parametros[4]);
                break;
            case ConsultasService.EMPLEO:
                clasificados = consultaService.consultarEmpleos(parametros[0], parametros[1], parametros[2]);
                break;
            case ConsultasService.VEHICULOS:
                clasificados = consultaService.consultarVehiculos(parametros[0], parametros[1], parametros[2]);
                break;
            case ConsultasService.VARIOS:
                clasificados = consultaService.consultarVarios(parametros[0]);
                break;
        }
        return clasificados;
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
