
package com.vi.clasificados.locator;

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
public class ClasificadosCachingLocator {
    private final static Integer objectId = 1000000;
    
    public final static int INMOBILIARIO = 1;
    public final static int EMPLEO = 2;
    public final static int VEHICULOS = 3;
    public final static int VARIOS = 4;
    
    private static ClasificadosCachingLocator instance;
    
    private Map cache;
    
    private ClasificadosCachingLocator(){
        
    }
    
    public static ClasificadosCachingLocator getInstance(List<Clasificado> clasificados){
        if(instance == null){
            try {
                instance = new ClasificadosCachingLocator();
            } catch (Exception e) {
                System.err.println(e);
                e.printStackTrace(System.err);
            }
        }
        if(instance.cache == null){
            instance.setCacheClasificados(clasificados);
        }
        return instance;
    }
    
    
    //Cache para los clasificados que se han publicado para Intenet, todos los días se actualiza   
    public List<Clasificado> getEmpleoFiltro(int tipo, int area, int rango) {
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        Object estructura = cache.get(EMPLEO);
        if(estructura == null){
            return new ArrayList<Clasificado>();
        }
        Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> mapaClasificados = (Map)cache.get(EMPLEO);
        
        Set<Map<Integer, List<Clasificado>>> listaAreas = new HashSet< Map<Integer, List<Clasificado>>>();
        Set<List<Clasificado>> listaPrecios = new HashSet<List<Clasificado>>();
        
        //Primer Filtro Tipo: (No permite seleccionar todos los tipos)
        Map<Integer, Map<Integer, List<Clasificado>>> mapa1 = mapaClasificados.get(tipo);
        if(mapa1 == null){
            return clasificados;
        }
        
        //Segundo Filtro Area: (0 - selecciona todas las áreas)
        if(area == 0){
            Set<Integer> subs = mapa1.keySet();
            for(Integer sub:subs){
                listaAreas.add(mapa1.get(sub));
            }
        }else{
            Map<Integer, List<Clasificado>> mapa2 = mapa1.get(area);
            if(mapa2 != null){
                listaAreas.add(mapa2);
            }
        }
        
        //Tercer Filtro Precios: (0 - selecciona todas los precios)
        if(rango == 0){
            for(Map<Integer, List<Clasificado>> lista:listaAreas){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    listaPrecios.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, List<Clasificado>> lista:listaAreas){
                List<Clasificado> conjunto = lista.get(rango);
                if(conjunto != null){
                    listaPrecios.add(conjunto);
                }
            }
        }
        
        //Agrega todas las listas al resultado
        for(List<Clasificado> conjunto:listaPrecios){
            clasificados.addAll(conjunto);
        }
        
        return clasificados;
    }
    
    public List<Clasificado> getVehiculosFiltro(int tipo, int marca, int rango) {
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        Object estructura = cache.get(VEHICULOS);
        if(estructura == null){
            return new ArrayList<Clasificado>();
        }
        Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> mapaClasificados = (Map)cache.get(VEHICULOS);
        
        Set<Map<Integer, List<Clasificado>>> listaMarcas = new HashSet< Map<Integer, List<Clasificado>>>();
        Set<List<Clasificado>> listaPrecios = new HashSet<List<Clasificado>>();
        
        //Primer Filtro Tipo: (No permite seleccionar todos los tipos)
        Map<Integer, Map<Integer, List<Clasificado>>> mapa1 = mapaClasificados.get(tipo);
        if(mapa1 == null){
            return clasificados;
        }
        
        //Segundo Filtro Marca: (0 - selecciona todas las áreas)
        if(marca == 0){
            Set<Integer> subs = mapa1.keySet();
            for(Integer sub:subs){
                listaMarcas.add(mapa1.get(sub));
            }
        }else{
            Map<Integer, List<Clasificado>> mapa2 = mapa1.get(marca);
            if(mapa2 != null){
                listaMarcas.add(mapa2);
            }
        }
        
        //Tercer Filtro Precios: (0 - selecciona todas los precios)
        if(rango == 0){
            for(Map<Integer, List<Clasificado>> lista:listaMarcas){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    listaPrecios.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, List<Clasificado>> lista:listaMarcas){
                List<Clasificado> conjunto = lista.get(rango);
                if(conjunto != null){
                    listaPrecios.add(conjunto);
                }
            }
        }
        
        //Agrega todas las listas al resultado
        for(List<Clasificado> conjunto:listaPrecios){
            clasificados.addAll(conjunto);
        }
        
        return clasificados;
    }
    
    public List<Clasificado> getVariosFiltro(int tipoClasificado) {
        Object estructura = cache.get(VARIOS);
        if(estructura == null){
            return new ArrayList<Clasificado>();
        }
        Map<Integer, List<Clasificado>> mapaClasificados = (Map)cache.get(VARIOS);
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        Set<List<Clasificado>> listaTipos = new HashSet<List<Clasificado>>();
        
        //Filtro Tipo: (0 - Incluye todos los tipos)
        if(tipoClasificado == 0){
            Set<Integer> subs = mapaClasificados.keySet();
            for(Integer sub:subs){
                listaTipos.add(mapaClasificados.get(sub));
            }
        }else{
            List<Clasificado> conjunto = mapaClasificados.get(tipoClasificado);
            if(conjunto != null){
                listaTipos.add(conjunto);
            }
        }

        //Se agregan todas las listas seleccionadas del filtro al resultado
        for(List<Clasificado> conjunto:listaTipos){
            clasificados.addAll(conjunto);
        }
        
        return clasificados;
    }
    
    public List<Clasificado> getInmobiliarioFiltro(int tipoOferta, int tipoInmueble, int ubicacion, int area, int rangoPrecio) {
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        Object estructura = cache.get(INMOBILIARIO);
        if(estructura == null){
            return clasificados;
        }
        
        Map<Integer, Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>>> mapaClasificados = (Map)cache.get(INMOBILIARIO);
        
        //Estos sets permiten tener en cuenta cuando el usuario selecciona todas las ubicaciones, todas las áreas o todos los precios
        Set<Map<Integer, Map<Integer, List<Clasificado>>>> ubicaciones = new HashSet<Map<Integer, Map<Integer, List<Clasificado>>>>();
        Set<Map<Integer, List<Clasificado>>> areas = new HashSet< Map<Integer, List<Clasificado>>>();
        Set<List<Clasificado>> precios = new HashSet<List<Clasificado>>();
        
        //Primer filtro Tipo de Oferta: 1-Venta, 2-Alquiler (No tiene la opción de todos)
        Map<Integer, Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>>> mapa1 = mapaClasificados.get(tipoOferta);
        if(mapa1 == null){
            return clasificados;
        }

        //Segundo filtro Tipo de Inmueble: (No tiene la opción de todos)
        Map<Integer, Map<Integer, Map<Integer, List<Clasificado>>>> mapa2 = mapa1.get(tipoInmueble);
        if(mapa2 == null){
            return new ArrayList<Clasificado>();
        }
        
        //Tercer Filtros - Ubicación: Si es 0, debe incluir todas las ubicaciones
        if(ubicacion == 0){
            Set<Integer> subs = mapa2.keySet();
            for(Integer sub:subs){
                ubicaciones.add(mapa2.get(sub));
            }
        }else{
            Map<Integer, Map<Integer, List<Clasificado>>> mapa3 = mapa2.get(ubicacion);
            if(mapa2 != null){
                ubicaciones.add(mapa3);
            }
        }
        
        //Cuarto Filtro - área: Si es 0 incluye todas las áreas
        if(area == 0){
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:ubicaciones){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    areas.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, Map<Integer, List<Clasificado>>> lista:ubicaciones){
                Map<Integer, List<Clasificado>> mapa = lista.get(area);
                if(mapa != null){
                    areas.add(mapa);
                }
            }
        }
        
        //Quinto Filtro - rango de precios: Si es 0 incluye todas los precios
        if(rangoPrecio == 0){
            for(Map<Integer, List<Clasificado>> lista:areas){
                Set<Integer> subs = lista.keySet();
                for(Integer sub:subs){
                    precios.add(lista.get(sub));
                }
            }
        }else{
            for(Map<Integer, List<Clasificado>> lista:areas){
                List<Clasificado> conjunto = lista.get(rangoPrecio);
                if(conjunto != null){
                    precios.add(conjunto);
                }
            }
        }
        
        //Todas las listas seleccionadas según los filtros se agregan a los clasificados de la lista de salida
        for(List<Clasificado> conjunto:precios){
            clasificados.addAll(conjunto);
        }
        
        return clasificados;
    }
    
    public void setCacheClasificados(List<Clasificado> clasificados){
        synchronized(objectId){
            cache = Collections.synchronizedMap(new HashMap());
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
        int tipo = inmueble.getSubtipo5() == null?inmueble.getSubtipo6().getId():inmueble.getSubtipo5().getId();
        List<Clasificado> conjunto = mapa4.get(tipo);
        if(conjunto == null){
            conjunto = new ArrayList<Clasificado>();
            mapa4.put(tipo, conjunto);
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
