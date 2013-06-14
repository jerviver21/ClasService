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
    
    public List<TipoClasificado> getTiposBase(){
        List<TipoClasificado> tipos = em.createNamedQuery("TipoClasificado.findTiposBase").getResultList();
        return tipos;
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
    
    public  Map<Integer, Map<String, List<TipoClasificado>>> getEstructuraConsulta(){
        Map<Integer, Map<String, List<TipoClasificado>>> tiposEstructura = new HashMap<Integer, Map<String, List<TipoClasificado>>>();
        List<TipoClasificado> tipos = em.createNamedQuery("TipoClasificado.findAll").getResultList();
        
        for(TipoClasificado tipo : tipos){
            if(tipo.getPadre() == null){
                Map<String, List<TipoClasificado>> subtiposEstructura = new LinkedHashMap<String, List<TipoClasificado>>();
                tiposEstructura.put(tipo.getId(), subtiposEstructura);
            }else{
                Map<String, List<TipoClasificado>> subtiposEstructura = tiposEstructura.get(tipo.getPadre().getId());
                List<TipoClasificado> subtipos = subtiposEstructura.get(tipo.getNombre());
                if(subtipos == null){
                    subtipos = new ArrayList<TipoClasificado>();
                    subtiposEstructura.put(tipo.getNombre(), subtipos);
                }
                subtipos.add(tipo);
            }
        }
        return tiposEstructura;
    }


}
