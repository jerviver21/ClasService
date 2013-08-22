
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.Currencies;
import com.vi.clasificados.dominio.DetallePrecioClasificado;
import com.vi.clasificados.dominio.DiasPrecios;
import com.vi.clasificados.dominio.EstadosClasificado;
import com.vi.clasificados.dominio.Pedido;
import com.vi.clasificados.dominio.TipoPublicacion;
import com.vi.clasificados.locator.ClasificadosCachingLocator;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.PedidoEstados;
import com.vi.clasificados.utils.PublicacionesTipos;
import com.vi.clasificados.utils.SelectorRangos;
import com.vi.comun.exceptions.ParametroException;
import com.vi.comun.locator.ParameterLocator;
import com.vi.comun.util.FechaUtils;
import com.vi.comun.util.Log;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.ejb.Timeout;
import javax.ejb.Timer;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * @author jerviver21
 */
@Stateless
@LocalBean
public class ClasificadosService {
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;
    
    @EJB
    TiposPublicacionService tipoPubService;
    @EJB
    ConsultasService consultaService;
    
    Map<String, TipoPublicacion> tiposPublicacion;
    ParameterLocator locator;
    ClasificadosCachingLocator caching;
    
    
    @Resource
    javax.ejb.TimerService timerService;
    
    @PostConstruct
    public void init(){
        tiposPublicacion = tipoPubService.findAllTiposMapa();
        locator = ParameterLocator.getInstance();
        caching = ClasificadosCachingLocator.getInstance(getClasificadosActivos());
    }
    
    public ClasificadosService(){
        
    }
    
    //Métodos básicos del EJB
    public void edit(Clasificado clasificado) {
        em.merge(clasificado);
    }
    
    
    //Métodos de procesamiento de la lógica del negocio
    public List<Clasificado> procesarClasificado(Clasificado clasificado){
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        for(String tipo : clasificado.getOpcionesPublicacion()){
            Clasificado nuevoClas = new Clasificado(clasificado);
            nuevoClas.setTipoPublicacion(tiposPublicacion.get(tipo));
            Map preciosXDia = tiposPublicacion.get(tipo).getMapaPrecios();
            calcularValores(nuevoClas, preciosXDia);
            clasificados.add(nuevoClas);
        }
        return clasificados;
    }
    
    public Clasificado editarClasificado(Clasificado clasificado){
        clasificado.setNumDias(0);
        clasificado.setNumPalabras(0);
        clasificado.setPrecio(BigDecimal.ZERO);
        clasificado.setDetallePrecio(new ArrayList<DetallePrecioClasificado>());
        Map preciosXDia = clasificado.getTipoPublicacion().getMapaPrecios();
        calcularValores(clasificado, preciosXDia);
        return clasificado;
    }
    
    public void calcularValores(Clasificado clasificado, Map preciosXDia){
        int numPalabras = clasificado.getClasificado().split("[\\s_-]").length;
        Map<Integer, DetallePrecioClasificado> mapaDetalle = new HashMap<Integer, DetallePrecioClasificado>();
        Calendar calendario = Calendar.getInstance();
        calendario.setTime(clasificado.getFechaIni());
        while(calendario.getTime().getTime() <= clasificado.getFechaFin().getTime()){
            DiasPrecios precio = (DiasPrecios)preciosXDia.get(calendario.get(FechaUtils.isFestivo(calendario.getTime())?100:Calendar.DAY_OF_WEEK));//100 indica que es un festivo
            if(precio.getPrecio().getProcesarXPalabra()){
               clasificado.setPrecio(clasificado.getPrecio().add(precio.getPrecio().getPrecio().multiply(new BigDecimal(numPalabras)))); 
            }else{
               clasificado.setPrecio(clasificado.getPrecio().add(precio.getPrecio().getPrecio())); 
            }
            calendario.add(Calendar.DATE, 1);
            clasificado.setNumDias(clasificado.getNumDias()+1);
            clasificado.setNumPalabras(numPalabras);
            DetallePrecioClasificado detalle = mapaDetalle.get(precio.getPrecio().getId());
            if(detalle == null){
                detalle = new DetallePrecioClasificado();
                detalle.setPrecio(precio.getPrecio());
                detalle.setNumPalabras(clasificado.getNumPalabras());
                clasificado.getDetallePrecio().add(detalle);
                mapaDetalle.put(precio.getPrecio().getId(), detalle);
            }
            detalle.setNumDias(detalle.getNumDias()+1);
        }
        Currencies moneda = (Currencies)em.find(Currencies.class, clasificado.getMoneda().getId());
        new SelectorRangos().setRangoValores(clasificado, moneda);  
    }

    public BigDecimal calcularTotalPedido(List<Clasificado> clasificados) {
        BigDecimal total = BigDecimal.ZERO;
        for(Clasificado clasificado: clasificados){
            total = total.add(clasificado.getPrecio());
        }
        return total;
    }

    //Métodos de Consultas básicas
    public List<Clasificado> getClasificados(String usr, EstadosClasificado estado) {
        List<Clasificado> clasificados;
        if(estado == null){
            clasificados = em.createNamedQuery("Clasificado.findByUsr").setParameter("usr", usr).getResultList();
        }else{
            clasificados = em.createNamedQuery("Clasificado.findByUsrEstado")
                    .setParameter("usr", usr).setParameter("estado", estado).getResultList();
        }
        return clasificados;
    }

    

    public List<Clasificado> getClasificadosActivos() {
        List<Clasificado> clasificados = em.createNamedQuery("Clasificado.findForFiltroCache")
                .setParameter("estado", ClasificadoEstados.PUBLICADO)
                .setParameter("tipop", PublicacionesTipos.INTERNET).getResultList();
        return clasificados;
    }
    
    
    //Métodos de consulta de filtros
    public List<Clasificado> getFiltro(int TIPO, int... parametros){
        boolean utilizarCache = Boolean.parseBoolean(locator.getParameter("consultas_x_cache"));
        
        List<Clasificado> clasificados = new ArrayList<Clasificado>();
        switch(TIPO){
            case ClasificadosCachingLocator.INMOBILIARIO:
                clasificados = utilizarCache ? caching.getInmobiliarioFiltro(parametros[0], parametros[1], parametros[2], parametros[3], parametros[4])
                        :consultaService.consultarInmobiliarios(parametros[0], parametros[1], parametros[2], parametros[3], parametros[4]);
                break;
            case ClasificadosCachingLocator.EMPLEO:
                clasificados = utilizarCache ?  caching.getEmpleoFiltro(parametros[0], parametros[1], parametros[2])
                        :consultaService.consultarEmpleos(parametros[0], parametros[1], parametros[2]);
                break;
            case ClasificadosCachingLocator.VEHICULOS:
                clasificados = utilizarCache ?  caching.getVehiculosFiltro(parametros[0], parametros[1], parametros[2])
                        :consultaService.consultarVehiculos(parametros[0], parametros[1], parametros[2]);
                break;
            case ClasificadosCachingLocator.VARIOS:
                clasificados = utilizarCache ?  caching.getVariosFiltro(parametros[0])
                        :consultaService.consultarVarios(parametros[0]);
                break;
        }
        
        return clasificados;
    }
    
    public void recargarCache(){
        caching.setCacheClasificados(getClasificadosActivos());
    }
    
    //******************************************************************************************
    //Tarea automática que se ejecuta a diario para revisar el vencimiento de las licencias
    
    public void initTimer(){
        //Primero cancela los timers que se hayan iniciado con anterioridad 
        Collection col = timerService.getTimers();
        Iterator iterator = col.iterator();
        while(iterator.hasNext()){
           Timer timer = (Timer)iterator.next();
           timer.cancel();
           Log.getLogger().log(Level.INFO,"Timer Cancelado");
        }
        
        //Se calcula la fecha de activación del timer
        Calendar calendario = Calendar.getInstance();
        calendario.add(Calendar.DATE, 1);
        calendario.set(Calendar.HOUR_OF_DAY, 00);
        calendario.set(Calendar.MINUTE, 00);
        calendario.set(Calendar.SECOND, 45);
        
        //Se programan de nuevo los timers de ejecución automática
        timerService.createTimer(calendario.getTime(), FechaUtils.MILLISECONDS_DIA, null);
        Log.getLogger().log(Level.INFO, "Nuevo timer iniciado! -{0}-", timerService.getTimers().size());
        iterator = timerService.getTimers().iterator();
        while(iterator.hasNext()){
           Timer timer = (Timer)iterator.next();
           Log.getLogger().log(Level.INFO, "Próxima ejecución: --> {0} - Faltan: {1} Horas", new Object[]{timer.getNextTimeout(), (timer.getTimeRemaining()/(1000*60*60))});
        }
    }
    
    @Timeout
    public void actualizarEstados(Timer timer)throws ParametroException{
        
        Log.getLogger().log(Level.INFO,"Inicia Revisión de de estados...");
        boolean depurar = Boolean.parseBoolean(locator.getParameter("depurar"));
        
        Date fechaHoy = FechaUtils.getFechaHoy();
        
        List<Clasificado> clasificados = em.createNamedQuery("Clasificado.findByEstado")
                .setParameter("estado", ClasificadoEstados.PUBLICADO).getResultList();
        
        if(depurar){
            Log.getLogger().log(Level.INFO, "Clasificados publicados: -> {0}", clasificados.size());
        }
        
        for(Clasificado clasificado:clasificados){
            if(clasificado.getFechaFin().before(fechaHoy)){
                clasificado.setEstado(ClasificadoEstados.EXPIRADO);
                em.merge(clasificado);
            }
            
            if(depurar){
                Log.getLogger().log(Level.INFO, "Fecha Hoy: {0} - Fecha Fin: {1} - Clasificado: {2} - Nuevo estado: {3}", new Object[]{fechaHoy, clasificado.getFechaFin(), clasificado.getClasificado(), clasificado.getEstado().getId()});
            }
        }

        List<Pedido> pedidos = em.createNamedQuery("Pedido.findByEstado").setParameter("estado", PedidoEstados.ACTIVO_PAGO).getResultList();
        
        if(depurar){
            Log.getLogger().log(Level.INFO, "Pedidos por pagar: -> {0}", clasificados.size());
        }
        
        for(Pedido pedido:pedidos){
            if(pedido.getFechaVencimiento()== null || fechaHoy.after(pedido.getFechaVencimiento())){
                pedido.setEstado(PedidoEstados.VENCIDO);
                //Si el pedido está vencido todos los clasificados asociados quedaran automaticamente vencidos
                for(Clasificado clasificado:pedido.getClasificados()){
                    
                    if(depurar){
                        Log.getLogger().log(Level.INFO, "Fecha Inicial del Clasificado: : {0} - Fecha de Hoy: {1} - Pedido: {2} - Nuevo Estado: {3}", new Object[]{clasificado.getFechaIni(), fechaHoy, clasificado.getPedido().getId(), clasificado.getEstado().getId()} );
                    }
                    
                    clasificado.setEstado(ClasificadoEstados.PEDIDOVENCIDO);
                    em.merge(clasificado);
                }
                em.merge(pedido);
            }
            
            if(depurar){
                Log.getLogger().log(Level.INFO, "Pedido: {0} - Fecha vencimiento del Pedido: : {1} - Fecha de Hoy: {2} - Nuevo Estado: {3}", new Object[]{pedido.getId(), pedido.getFechaVencimiento(), fechaHoy, pedido.getEstado().getId()} );
            }
        }
        
        //Recarga de cache para las consultas de clasificados online
        recargarCache();

        Log.getLogger().log(Level.INFO, "Termina Revisi\u00f3n de estados... Pr\u00f3xima ejecuci\u00f3n en: {0} horas", (timer.getTimeRemaining()/(1000*60*60)));
        
    }



    
    
    
}
