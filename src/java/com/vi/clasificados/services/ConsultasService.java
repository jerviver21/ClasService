/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.TipoClasificado;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.ClasificadosTipo;
import com.vi.clasificados.utils.PublicacionTipos;
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
    public static final int INMOBILIARIO = 1;
    public static final int EMPLEO = 2;
    public static final int VEHICULOS = 3;
    public static final int VARIOS = 4;

    
    
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;

    public List<Clasificado> consultarInmobiliarios(int tipoOferta, int tipoInmueble, int ubicacion, int area, int precio){
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        
        //Criterio 1: tipo de oferta (Venta, Alquiler)
        //Criterio 2: tipo de inmueble(Casa, Departamento)
        //Criterio 3: ubicación
        //Criterio 4: Área (m2)
        //Criterio 5: rango de precios
        
        if(ubicacion == 0){
            clasificados = em.createNamedQuery("Clasificado.consultaCrit1245")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipopub", PublicacionTipos.WEB)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("criterio1", new TipoClasificado(tipoOferta))
                .setParameter("criterio2", new TipoClasificado(tipoInmueble))
                .setParameter("criterio4", new TipoClasificado(area))
                .setParameter("criterio5", new TipoClasificado(precio))
                .getResultList(); 
            
        }else{
            clasificados = em.createNamedQuery("Clasificado.consultaCrit12345")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipopub", PublicacionTipos.WEB)
                .setParameter("tipo", ClasificadosTipo.INMOBILIARIO)
                .setParameter("criterio1", new TipoClasificado(tipoOferta))
                .setParameter("criterio2", new TipoClasificado(tipoInmueble))
                .setParameter("criterio3", new TipoClasificado(ubicacion))
                .setParameter("criterio4", new TipoClasificado(area))
                .setParameter("criterio5", new TipoClasificado(precio))
                .getResultList(); 
            
        }
        
        return clasificados;
    }
    
    public List<Clasificado> consultarEmpleos(int tipo, int area, int rango){
        List<Clasificado> clasificados =  new ArrayList<Clasificado>();
        
        //Criterio 1: tipo de oferta (Oferta, Solicitud)
        //Criterio 2: Área (administración, Ingeniería)
        //Criterio 3: rango de salarios
        if(rango == 0){
            clasificados = em.createNamedQuery("Clasificado.consultaCrit12")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipopub", PublicacionTipos.WEB)
                .setParameter("tipo", ClasificadosTipo.VEHICULO)
                .setParameter("criterio1", new TipoClasificado(tipo))
                .setParameter("criterio2", new TipoClasificado(area))
                .getResultList();
            
        }else{
            clasificados = em.createNamedQuery("Clasificado.consultaCrit123")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipopub", PublicacionTipos.WEB)                
                .setParameter("tipo", ClasificadosTipo.VEHICULO)
                .setParameter("criterio1", new TipoClasificado(tipo))
                .setParameter("criterio2", new TipoClasificado(area))
                .setParameter("criterio3", new TipoClasificado(rango))  
                .getResultList();
        }
        return clasificados;
    }
    
    public List<Clasificado> consultarVehiculos(int tipo, int marca, int rango){
        List<Clasificado> clasificados =  new ArrayList<Clasificado>();
        
        //Criterio 1: tipo de vehiculo (Carro, Moto, Camion)
        //Criterio 2: Marca
        //Criterio 3: rango de precios
        if(marca == 0){
            clasificados = em.createNamedQuery("Clasificado.consultaCrit13")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipopub", PublicacionTipos.WEB)
                .setParameter("tipo", ClasificadosTipo.VEHICULO)
                .setParameter("criterio1", new TipoClasificado(tipo))
                .setParameter("criterio3", new TipoClasificado(rango))
                .getResultList();
            
        }else{
            clasificados = em.createNamedQuery("Clasificado.consultaCrit123")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipopub", PublicacionTipos.WEB)                
                .setParameter("tipo", ClasificadosTipo.VEHICULO)
                .setParameter("criterio1", new TipoClasificado(tipo))
                .setParameter("criterio2", new TipoClasificado(marca))
                .setParameter("criterio3", new TipoClasificado(rango))  
                .getResultList();
        }
        return clasificados;
    }
    
    public List<Clasificado> consultarVarios(int tipoOferta){
        //Criterio 1: Tipo (Productos Electrónicos (Camaras), Computadores)
        List<Clasificado> clasificados = em.createNamedQuery("Clasificado.consultaCrit1")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipopub", PublicacionTipos.WEB)
                .setParameter("tipo", ClasificadosTipo.VARIOS)
                .setParameter("criterio1", new TipoClasificado(tipoOferta))
                .getResultList();
        return clasificados;
    }
    
    
  
}
