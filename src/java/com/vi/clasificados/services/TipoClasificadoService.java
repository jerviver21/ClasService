package com.vi.clasificados.services;

import com.vi.clasificados.dominio.TipoClasificado;
import com.vi.clasificados.locator.TiposCachingLocator;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * @author Jerson
 */
@Stateless
@LocalBean
public class TipoClasificadoService {
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;
    
    TiposCachingLocator locator;
    
    public TipoClasificadoService(){
        locator = TiposCachingLocator.getInstance();
    }
    
    
    public List<TipoClasificado> getAllTipos(){
        List<TipoClasificado> tipos = em.createNamedQuery("TipoClasificado.findAll").getResultList();
        return tipos;
    }
    
    public Map<Integer, TipoClasificado> getTipos(){
        Map<Integer, TipoClasificado> tipos = locator.getMapa(TiposCachingLocator.TIPOS);
        if(tipos == null){
            locator.setCacheTipos(getAllTipos());
            tipos = locator.getMapa(TiposCachingLocator.TIPOS);
        }
        return tipos;
    }
    
    public Map<Integer, Map<Integer, List<TipoClasificado>>> getSubtipos(){
        Map<Integer, Map<Integer, List<TipoClasificado>>> tipos = locator.getMapa(TiposCachingLocator.SUBTIPOS);
        if(tipos == null){
            locator.setCacheTipos(getAllTipos());
            tipos = locator.getMapa(TiposCachingLocator.SUBTIPOS);
        }
        return tipos;
    }
    
    


}
