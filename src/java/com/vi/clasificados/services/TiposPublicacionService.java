package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Precios;
import com.vi.clasificados.dominio.TipoPublicacion;
import java.util.ArrayList;
import java.util.HashMap;
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

    public List<TipoPublicacion> findAllTipos(){
        List<TipoPublicacion> tipos = em.createNamedQuery("TipoPublicacion.findAll").getResultList();
        return tipos;
    }
    
    public Map<Integer, TipoPublicacion> findAllTiposMapa(){
        Map<Integer, TipoPublicacion> mapa = new LinkedHashMap<Integer, TipoPublicacion>();
        List<TipoPublicacion> tipos = em.createNamedQuery("TipoPublicacion.findAll").getResultList();
        for(TipoPublicacion tipo : tipos){
            mapa.put(tipo.getId(), tipo);
        }
        return mapa;
    }

    public List<String> findAll(){
        List<TipoPublicacion> tipos = em.createNamedQuery("TipoPublicacion.findAll").getResultList();
        List<String> nombresTipos = new ArrayList<String>();
        for(TipoPublicacion tipo : tipos){
            nombresTipos.add(tipo.getNombre());
        }
        return nombresTipos;
    }
    
    public List<String> findImpresos(){
        List<TipoPublicacion> tipos = em.createNamedQuery("TipoPublicacion.findImpresos").getResultList();
        List<String> nombresTipos = new ArrayList<String>();
        for(TipoPublicacion tipo : tipos){
            nombresTipos.add(tipo.getNombre());
        }
        return nombresTipos;
    }



}
