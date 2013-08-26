/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.TipoClasificado;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.ClasificadosTipo;
import com.vi.clasificados.utils.PublicacionesTipos;
import java.util.ArrayList;
import java.util.List;
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
public class ConsultasService {
    
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;

    public List<Clasificado> consultarInmobiliarios(int tipoOferta, int tipoInmueble, int ubicacion, int area, int precio){
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        if(ubicacion != 0 && area != 0 && precio != 0){
           clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2 AND c.subtipo3 =:sub3 AND c.subtipo4 =:sub4 AND c.subtipo5 =:sub5 ")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("sub1", new TipoClasificado(tipoOferta))
                .setParameter("sub2", new TipoClasificado(tipoInmueble))
                .setParameter("sub3", new TipoClasificado(ubicacion))
                .setParameter("sub4", new TipoClasificado(area))
                .setParameter("sub5", new TipoClasificado(precio))
                .getResultList(); 
        }else if(ubicacion != 0 && area != 0 && precio == 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2 AND c.subtipo3 =:sub3 AND c.subtipo4 =:sub4")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("sub1", new TipoClasificado(tipoOferta))
                .setParameter("sub2", new TipoClasificado(tipoInmueble))
                .setParameter("sub3", new TipoClasificado(ubicacion))
                .setParameter("sub4", new TipoClasificado(area))
                .getResultList(); 
            
        }else if(ubicacion != 0 && area == 0 && precio == 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2 AND c.subtipo3 =:sub3")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("sub1", new TipoClasificado(tipoOferta))
                .setParameter("sub2", new TipoClasificado(tipoInmueble))
                .setParameter("sub3", new TipoClasificado(ubicacion))
                .getResultList(); 
        }else if(ubicacion == 0 && area == 0 && precio == 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("sub1", new TipoClasificado(tipoOferta))
                .setParameter("sub2", new TipoClasificado(tipoInmueble))
                .getResultList(); 
            
        }else if(ubicacion == 0 && area == 0 && precio != 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2 AND c.subtipo5 =:sub5 ")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("sub1", new TipoClasificado(tipoOferta))
                .setParameter("sub2", new TipoClasificado(tipoInmueble))
                .setParameter("sub5", new TipoClasificado(precio))
                .getResultList(); 
            
        }else if(ubicacion == 0 && area != 0 && precio != 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2 AND c.subtipo4 =:sub4 AND c.subtipo5 =:sub5 ")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("sub1", new TipoClasificado(tipoOferta))
                .setParameter("sub2", new TipoClasificado(tipoInmueble))
                .setParameter("sub4", new TipoClasificado(area))
                .setParameter("sub5", new TipoClasificado(precio))
                .getResultList(); 
            
        }else if(ubicacion != 0 && area == 0 && precio != 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2 AND c.subtipo3 =:sub3 AND c.subtipo5 =:sub5 ")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("sub1", new TipoClasificado(tipoOferta))
                .setParameter("sub2", new TipoClasificado(tipoInmueble))
                .setParameter("sub3", new TipoClasificado(ubicacion))
                .setParameter("sub5", new TipoClasificado(precio))
                .getResultList(); 
            
        }else if(ubicacion == 0 && area != 0 && precio == 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2 AND c.subtipo4 =:sub4 ")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("sub1", new TipoClasificado(tipoOferta))
                .setParameter("sub2", new TipoClasificado(tipoInmueble))
                .setParameter("sub4", new TipoClasificado(area))
                .getResultList(); 
            
        }
        
        return clasificados;
    }
    
    public List<Clasificado> consultarEmpleos(int tipo, int area, int rango){
        List<Clasificado> clasificados =  new ArrayList<Clasificado>();
        
        if(area != 0 && rango != 0){
           clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2 AND c.subtipo3 =:sub3")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.EMPLEO)
                .setParameter("sub1", new TipoClasificado(tipo))
                .setParameter("sub2", new TipoClasificado(area))
                .setParameter("sub3", new TipoClasificado(rango))
                .getResultList();
        }else if(area == 0 && rango != 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo3 =:sub3")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.EMPLEO)
                .setParameter("sub1", new TipoClasificado(tipo))
                .setParameter("sub3", new TipoClasificado(rango))
                .getResultList();
            
        }else if(area != 0 && rango == 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.EMPLEO)
                .setParameter("sub1", new TipoClasificado(tipo))
                .setParameter("sub2", new TipoClasificado(area))
                .getResultList();
            
        }else if(area == 0 && rango == 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.EMPLEO)
                .setParameter("sub1", new TipoClasificado(tipo))
                .getResultList();
            
        }
        return clasificados;
    }
    
    public List<Clasificado> consultarVehiculos(int tipo, int marca, int rango){
        List<Clasificado> clasificados =  new ArrayList<Clasificado>();
        
        if(marca != 0 && rango != 0){
           clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2 AND c.subtipo3 =:sub3")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.VEHICULO)
                .setParameter("sub1", new TipoClasificado(tipo))
                .setParameter("sub2", new TipoClasificado(marca))
                .setParameter("sub3", new TipoClasificado(rango))
                .getResultList();
        }else if(marca == 0 && rango != 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo3 =:sub3")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.VEHICULO)
                .setParameter("sub1", new TipoClasificado(tipo))
                .setParameter("sub3", new TipoClasificado(rango))
                .getResultList();
            
        }else if(marca != 0 && rango == 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1 AND c.subtipo2 =:sub2")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.VEHICULO)
                .setParameter("sub1", new TipoClasificado(tipo))
                .setParameter("sub2", new TipoClasificado(marca))
                .getResultList();
            
        }else if(marca == 0 && rango == 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.VEHICULO)
                .setParameter("sub1", new TipoClasificado(tipo))
                .getResultList();
            
        }
        return clasificados;
    }
    
    public List<Clasificado> consultarVarios(int tipoOferta){
        List<Clasificado> clasificados;
        if(tipoOferta == 0){
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.VARIOS)
                .getResultList();
        }else{
            clasificados = em.createQuery("SELECT c FROM Clasificado c WHERE c.estado =:estado AND c.tipoPublicacion =:tipop AND c.tipo = :tipo AND c.subtipo1 =:sub1")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET)
                .setParameter("tipo", ClasificadosTipo.VARIOS)
                .setParameter("sub1", new TipoClasificado(tipoOferta))
                .getResultList();
        }
        return clasificados;
    }

}
