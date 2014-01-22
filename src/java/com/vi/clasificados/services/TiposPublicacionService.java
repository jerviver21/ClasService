package com.vi.clasificados.services;

import com.vi.clasificados.dominio.SubtipoPublicacion;
import com.vi.clasificados.dominio.TipoPublicacion;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * @author jerviver21
 */
@Stateless
@LocalBean
public class TiposPublicacionService {
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;

    public List<SubtipoPublicacion> findAllSubtipos(){
        List<SubtipoPublicacion> s = em.createNamedQuery("SubtipoPublicacion.findAll").getResultList();
        return s;
    }
    
    public List<SubtipoPublicacion> findImpresos(){
        List<SubtipoPublicacion> s = em.createNamedQuery("SubtipoPublicacion.findImpresos").getResultList();
        return s;
    }
    
    public List<SubtipoPublicacion> findWeb(){
        List<SubtipoPublicacion> s = em.createNamedQuery("SubtipoPublicacion.findWeb").getResultList();
        return s;
    }



}
