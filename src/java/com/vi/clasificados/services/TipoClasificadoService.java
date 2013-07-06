package com.vi.clasificados.services;

import com.vi.clasificados.dominio.TipoClasificado;
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
    
    public Map<Integer, TipoClasificado> getTiposBase(){
        Map<Integer, TipoClasificado> mapa = new LinkedHashMap<Integer, TipoClasificado>();
        List<TipoClasificado> tipos = em.createNamedQuery("TipoClasificado.findTiposBase").getResultList();
        for(TipoClasificado tipo : tipos){
            mapa.put(tipo.getId(), tipo);
        }
        return mapa;
    }
    
    public List<TipoClasificado> getTiposByPadre(TipoClasificado padre){
        List<TipoClasificado> tipos = em.createNamedQuery("TipoClasificado.findTiposByPadre")
                .setParameter("padre", padre).getResultList();
        return tipos;
    }
    
    public List<TipoClasificado> getAllTipos(){
        List<TipoClasificado> tipos = em.createNamedQuery("TipoClasificado.findAll").getResultList();
        return tipos;
    }
    
    public  Map<Integer, Map<Integer, List<TipoClasificado>>> getEstructuraConsulta(){
        Map<Integer, Map<Integer, List<TipoClasificado>>> tiposEstructura = new HashMap<Integer, Map<Integer, List<TipoClasificado>>>();
        List<TipoClasificado> tipos = em.createNamedQuery("TipoClasificado.findAll").getResultList();
        
        for(TipoClasificado tipo : tipos){
            if(tipo.getPadre() == null){
                Map<Integer, List<TipoClasificado>> subtiposEstructura = new LinkedHashMap<Integer, List<TipoClasificado>>();
                tiposEstructura.put(tipo.getId(), subtiposEstructura);
            }else{
                Map<Integer, List<TipoClasificado>> subtiposEstructura = tiposEstructura.get(tipo.getPadre().getId());
                List<TipoClasificado> subtipos = subtiposEstructura.get(tipo.getSubtipo());
                if(subtipos == null){
                    subtipos = new ArrayList<TipoClasificado>();
                    subtiposEstructura.put(tipo.getSubtipo(), subtipos);
                }
                subtipos.add(tipo);
            }
        }
        System.out.println(tiposEstructura);
        return tiposEstructura;
    }


}
