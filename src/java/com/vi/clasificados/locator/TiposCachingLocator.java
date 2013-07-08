/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.locator;

import com.vi.clasificados.dominio.TipoClasificado;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author jerviver21
 */
public class TiposCachingLocator {
    
    public final static int TIPOS = 1;
    public final static int SUBTIPOS = 2;
    
    private static TiposCachingLocator instance;
    
    private Map cache;
    
    private TiposCachingLocator(){
        cache = Collections.synchronizedMap(new HashMap());
    }
    
    public static TiposCachingLocator getInstance(){
        if(instance == null){
            try {
                instance = new TiposCachingLocator();
            } catch (Exception e) {
                System.err.println(e);
                e.printStackTrace(System.err);
            }
        }
        return instance;
    }
    
    //Cache para definir los tipos y los subtipos
    public void setCacheTipos(List<TipoClasificado> lista){
        Map<Integer, TipoClasificado> tipos = new LinkedHashMap<Integer, TipoClasificado>();
        Map<Integer, Map<Integer, List<TipoClasificado>>> subtipos = new HashMap<Integer, Map<Integer, List<TipoClasificado>>>();
        for(TipoClasificado tipo : lista){
            if(tipo.getPadre() == null){
                tipos.put(tipo.getId(), tipo);
                Map<Integer, List<TipoClasificado>> subtiposEstructura = new LinkedHashMap<Integer, List<TipoClasificado>>();
                subtipos.put(tipo.getId(), subtiposEstructura);
            }else{
                Map<Integer, List<TipoClasificado>> subtiposEstructura = subtipos.get(tipo.getPadre().getId());
                List<TipoClasificado> subs = subtiposEstructura.get(tipo.getSubtipo());
                if(subs == null){
                    subs = new ArrayList<TipoClasificado>();
                    subtiposEstructura.put(tipo.getSubtipo(), subs);
                }
                subs.add(tipo);
            }
        }
        cache.put(TIPOS, tipos);
        cache.put(SUBTIPOS, subtipos);
    }
    
    public Map getMapa(int TIPO){
        Object mapa = cache.get(TIPO);
        System.out.println(mapa);
        if(mapa == null){
            return null;
        }
        return (Map)mapa;
    }
    
}
