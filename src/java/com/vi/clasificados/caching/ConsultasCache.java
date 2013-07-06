
package com.vi.clasificados.caching;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.utils.ClasificadosTipo;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * @author Jerson Viveros Aguirre
 * 
 */
public class ConsultasCache {
    private final static Integer objectId = 1000000;
    
    public final static int INMOBILIARIO = 1;
    public final static int EMPLEO = 2;
    public final static int VEHICULOS = 3;
    public final static int VARIOS = 4;
    
    private ConsultasCache instance;
    
    private Map cache;
    
    private ConsultasCache(){
    }
    
    public static ConsultasCache getInstance(){
        ConsultasCache cc = new ConsultasCache();
        if(cc.instance == null){
            try {
                cc.instance = new ConsultasCache();
            } catch (Exception e) {
                System.err.println(e);
                e.printStackTrace(System.err);
            }
        }
        return cc.instance;
    }
    
    public List<Clasificado> getFiltro(int TIPO, int... parametros){
        if(cache == null){
            return null;
        }
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        switch(TIPO){
            case INMOBILIARIO:
                clasificados = getInmobiliarioFiltro(parametros[0], parametros[1], parametros[2], parametros[3], parametros[4]);
                break;
            case EMPLEO:
                clasificados = getEmpleoFiltro(parametros[0], parametros[1], parametros[2]);
                break;
            case VEHICULOS:
                clasificados = getVehiculosFiltro(parametros[0], parametros[1], parametros[2]);
                break;
            case VARIOS:
                clasificados = getVariosFiltro(parametros[0]);
                break;
        }
        return clasificados;
    }
    
    private List<Clasificado> getEmpleoFiltro(int tipo, int area, int rango) {
        Object estructura = cache.get(EMPLEO);
        if(estructura == null){
            return new ArrayList<Clasificado>();
        }
        Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> mapaClasificados = (Map)cache.get(EMPLEO);
        
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        Set<Map<Integer, Map<Integer, List<Clasificado>>>> escaneo1nivel = new HashSet<Map<Integer, Map<Integer, List<Clasificado>>>>();
        Set<Map<Integer, List<Clasificado>>> escaneo2nivel = new HashSet< Map<Integer, List<Clasificado>>>();
        Set<List<Clasificado>> escaneo3nivel = new HashSet<List<Clasificado>>();
        
        if(tipo == 0){
            Set<Integer> subs = mapaClasificados.keySet();
            for(Integer sub:subs){
                escaneo1nivel.add(mapaClasificados.get(sub));
            }
        }else{
            Map<Integer, Map<Integer, List<Clasificado>>> mapa1 = mapaClasificados.get(tipo);
            if(mapa1 != null){
                escaneo1nivel.add(mapa1);
            }
        }
        
        if(area == 0){
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:escaneo1nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo2nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:escaneo1nivel){
                Map<Integer, List<Clasificado>> mapa2 = lista.get(area);
                if(mapa2 != null){
                    escaneo2nivel.add(mapa2);
                }
            }
        }
        
        if(rango == 0){
            for(Map<Integer, List<Clasificado>> lista:escaneo2nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo3nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, List<Clasificado>> lista:escaneo2nivel){
                List<Clasificado> conjunto = lista.get(rango);
                if(conjunto != null){
                    escaneo3nivel.add(conjunto);
                }
            }
        }
        
        for(List<Clasificado> conjunto:escaneo3nivel){
            clasificados.addAll(conjunto);
        }
        
        return clasificados;
    }
    
    private List<Clasificado> getVehiculosFiltro(int tipo, int marca, int rango) {
        Object estructura = cache.get(VEHICULOS);
        if(estructura == null){
            return new ArrayList<Clasificado>();
        }
        Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> mapaClasificados = (Map)cache.get(VEHICULOS);
        
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        Set<Map<Integer, Map<Integer, List<Clasificado>>>> escaneo1nivel = new HashSet<Map<Integer, Map<Integer, List<Clasificado>>>>();
        Set<Map<Integer, List<Clasificado>>> escaneo2nivel = new HashSet< Map<Integer, List<Clasificado>>>();
        Set<List<Clasificado>> escaneo3nivel = new HashSet<List<Clasificado>>();
        
        if(tipo == 0){
            Set<Integer> subs = mapaClasificados.keySet();
            for(Integer sub:subs){
                escaneo1nivel.add(mapaClasificados.get(sub));
            }
        }else{
            Map<Integer, Map<Integer, List<Clasificado>>> mapa1 = mapaClasificados.get(tipo);
            if(mapa1 != null){
                escaneo1nivel.add(mapa1);
            }
        }
        
        if(marca == 0){
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:escaneo1nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo2nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:escaneo1nivel){
                Map<Integer, List<Clasificado>> mapa2 = lista.get(marca);
                if(mapa2 != null){
                    escaneo2nivel.add(mapa2);
                }
            }
        }
        
        if(rango == 0){
            for(Map<Integer, List<Clasificado>> lista:escaneo2nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo3nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, List<Clasificado>> lista:escaneo2nivel){
                List<Clasificado> conjunto = lista.get(rango);
                if(conjunto != null){
                    escaneo3nivel.add(conjunto);
                }
            }
        }
        
        for(List<Clasificado> conjunto:escaneo3nivel){
            clasificados.addAll(conjunto);
        }
        
        return clasificados;
    }
    
    private List<Clasificado> getVariosFiltro(int tipoClasificado) {
        Object estructura = cache.get(VARIOS);
        if(estructura == null){
            return new ArrayList<Clasificado>();
        }
        Map<Integer, List<Clasificado>> mapaClasificados = (Map)cache.get(VARIOS);
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        Set<List<Clasificado>> escaneo1nivel = new HashSet<List<Clasificado>>();
        
        if(tipoClasificado == 0){
            Set<Integer> subs = mapaClasificados.keySet();
            for(Integer sub:subs){
                escaneo1nivel.add(mapaClasificados.get(sub));
            }
        }else{
            List<Clasificado> conjunto = mapaClasificados.get(tipoClasificado);
            if(conjunto != null){
                escaneo1nivel.add(conjunto);
            }
        }

        
        for(List<Clasificado> conjunto:escaneo1nivel){
            clasificados.addAll(conjunto);
        }
        
        return clasificados;
    }
    
    private List<Clasificado> getInmobiliarioFiltro(int tipoOferta, int tipoInmueble, int ubicacion, int area, int rangoPrecio) {
        Object estructura = cache.get(INMOBILIARIO);
        if(estructura == null){
            return new ArrayList<Clasificado>();
        }
        Map<Integer, Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>>> mapaClasificados = (Map)cache.get(INMOBILIARIO);
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        Set<Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>>> escaneo1nivel = new HashSet<Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>>>();
        Set<Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>> escaneo2nivel = new HashSet< Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>>();
        Set<Map<Integer, Map<Integer, List<Clasificado>>>> escaneo3nivel = new HashSet<Map<Integer, Map<Integer, List<Clasificado>>>>();
        Set<Map<Integer, List<Clasificado>>> escaneo4nivel = new HashSet< Map<Integer, List<Clasificado>>>();
        Set<List<Clasificado>> escaneo5nivel = new HashSet<List<Clasificado>>();
        
        if(tipoOferta == 0){
            Set<Integer> subs = mapaClasificados.keySet();
            for(Integer sub:subs){
                escaneo1nivel.add(mapaClasificados.get(sub));
            }
        }else{
            Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>> mapa1 = mapaClasificados.get(tipoOferta);
            if(mapa1 != null){
                escaneo1nivel.add(mapa1);
            }
        }
        
        if(tipoInmueble == 0){
            for(Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>> lista:escaneo1nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo2nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>> lista:escaneo1nivel){
                Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> mapa2 = lista.get(tipoInmueble);
                if(mapa2 != null){
                    escaneo2nivel.add(mapa2);
                }
            }
        }
        
        if(ubicacion == 0){
            for(Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> lista:escaneo2nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo3nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> lista:escaneo2nivel){
                Map<Integer, Map<Integer, List<Clasificado>>> mapa2 = lista.get(ubicacion);
                if(mapa2 != null){
                    escaneo3nivel.add(mapa2);
                }
            }
        }
        
        if(area == 0){
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:escaneo3nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo4nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:escaneo3nivel){
                Map<Integer, List<Clasificado>> mapa2 = lista.get(area);
                if(mapa2 != null){
                    escaneo4nivel.add(mapa2);
                }
            }
        }
        
        if(rangoPrecio == 0){
            for(Map<Integer, List<Clasificado>> lista:escaneo4nivel){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    escaneo5nivel.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, List<Clasificado>> lista:escaneo4nivel){
                List<Clasificado> conjunto = lista.get(rangoPrecio);
                if(conjunto != null){
                    escaneo5nivel.add(conjunto);
                }
            }
        }
        
        for(List<Clasificado> conjunto:escaneo5nivel){
            clasificados.addAll(conjunto);
        }
        
        return clasificados;
        
    }
    
    public void setCache(List<Clasificado> clasificados){
        synchronized(objectId){
            if(cache != null){
                return;
            }else{
                cache = Collections.synchronizedMap(new HashMap());
            }
            for(Clasificado clasificado : clasificados){
                if(clasificado.getTipo().equals(ClasificadosTipo.INMOBILIARIO)){
                    setInmobiliario(clasificado);
                }else if(clasificado.getTipo().equals(ClasificadosTipo.EMPLEO)){
                    setEmpleo(clasificado);
                }else if(clasificado.getTipo().equals(ClasificadosTipo.VEHICULO)){
                    setVehiculos(clasificado);
                }else if(clasificado.getTipo().equals(ClasificadosTipo.VARIOS)){
                    setVarios(clasificado);
                }
            }
        }
    }
    
    private void setEmpleo(Clasificado empleo){
        Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>  empleos = (Map)cache.get(EMPLEO);
        if(empleos == null ){
            empleos = new HashMap<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>();
            cache.put(EMPLEO, empleos);
        }
        
        Map<Integer, Map<Integer, List<Clasificado>>> mapa1 = empleos.get(empleo.getSubtipo1().getId());
        if(mapa1 == null){
            mapa1 = new HashMap<Integer, Map<Integer, List<Clasificado>>>();
            empleos.put(empleo.getSubtipo1().getId(), mapa1);
        }
        Map<Integer, List<Clasificado>> mapa2 = mapa1.get(empleo.getSubtipo2().getId());
        if(mapa2 == null){
            mapa2 = new HashMap<Integer, List<Clasificado>>();
            mapa1.put(empleo.getSubtipo2().getId(), mapa2);
        }
        List<Clasificado> conjunto = mapa2.get(empleo.getSubtipo3().getId());
        if(conjunto == null){
            conjunto = new ArrayList<Clasificado>();
            mapa2.put(empleo.getSubtipo3().getId(), conjunto);
        }
        conjunto.add(empleo);
        
    }
    
    private void setInmobiliario(Clasificado inmueble){
        Map<Integer, Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>>>  inmuebles = (Map)cache.get(INMOBILIARIO);
        if(inmuebles == null ){
            inmuebles = new HashMap<Integer, Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>>>();
            cache.put(INMOBILIARIO, inmuebles);
        }
        Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>> mapa1 = inmuebles.get(inmueble.getSubtipo1().getId());
        if(mapa1 == null){
            mapa1 = new HashMap<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>>();
            inmuebles.put(inmueble.getSubtipo1().getId(), mapa1);
        }
        Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> mapa2 = mapa1.get(inmueble.getSubtipo2().getId());
        if(mapa2 == null){
            mapa2 = new HashMap<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>();
            mapa1.put(inmueble.getSubtipo2().getId(), mapa2);
        }
        Map<Integer, Map<Integer, List<Clasificado>>> mapa3 = mapa2.get(inmueble.getSubtipo3().getId());
        if(mapa3 == null){
            mapa3 = new HashMap<Integer, Map<Integer, List<Clasificado>>>();
            mapa2.put(inmueble.getSubtipo3().getId(), mapa3);
        }
        Map<Integer, List<Clasificado>> mapa4 = mapa3.get(inmueble.getSubtipo4().getId());
        if(mapa4 == null){
            mapa4 = new HashMap<Integer, List<Clasificado>>();
            mapa3.put(inmueble.getSubtipo4().getId(), mapa4);
        }
        List<Clasificado> conjunto = mapa4.get(inmueble.getSubtipo5().getId());
        if(conjunto == null){
            conjunto = new ArrayList<Clasificado>();
            mapa4.put(inmueble.getSubtipo5().getId(), conjunto);
        }
        conjunto.add(inmueble);
    }
    
    private void setVehiculos(Clasificado vehiculo){
        Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>  vehiculos = (Map)cache.get(VEHICULOS);
        if(vehiculos == null ){
            vehiculos = new HashMap<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>();
            cache.put(VEHICULOS, vehiculos);
        }
        
        Map<Integer, Map<Integer, List<Clasificado>>> mapa1 = vehiculos.get(vehiculo.getSubtipo1().getId());
        if(mapa1 == null){
            mapa1 = new HashMap<Integer, Map<Integer, List<Clasificado>>>();
            vehiculos.put(vehiculo.getSubtipo1().getId(), mapa1);
        }
        Map<Integer, List<Clasificado>> mapa2 = mapa1.get(vehiculo.getSubtipo2().getId());
        if(mapa2 == null){
            mapa2 = new HashMap<Integer, List<Clasificado>>();
            mapa1.put(vehiculo.getSubtipo2().getId(), mapa2);
        }
        List<Clasificado> conjunto = mapa2.get(vehiculo.getSubtipo3().getId());
        if(conjunto == null){
            conjunto = new ArrayList<Clasificado>();
            mapa2.put(vehiculo.getSubtipo3().getId(), conjunto);
        }
        conjunto.add(vehiculo);
        
    }
    
    private void setVarios(Clasificado clasificado){
        Map<Integer, List<Clasificado>>  clasificados = (Map)cache.get(VARIOS);
        if(clasificados == null ){
            clasificados = new HashMap<Integer, List<Clasificado>>();
            cache.put(VARIOS, clasificados);
        }
        
        List<Clasificado> conjunto = clasificados.get(clasificado.getSubtipo1().getId());
        if(conjunto == null){
            conjunto = new ArrayList<Clasificado>();
            clasificados.put(clasificado.getSubtipo1().getId(), conjunto);
        }
        conjunto.add(clasificado);
        
    }
    
    
    
}
