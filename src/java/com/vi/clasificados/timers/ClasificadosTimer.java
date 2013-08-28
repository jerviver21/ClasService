/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.timers;

import com.vi.clasificados.services.ClasificadosService;
import com.vi.clasificados.services.PedidoService;
import com.vi.comun.util.FechaUtils;
import com.vi.comun.util.Log;
import java.util.Calendar;
import java.util.Collection;
import java.util.Iterator;
import java.util.logging.Level;
import javax.annotation.Resource;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.ejb.Timeout;
import javax.ejb.Timer;

/**
 *
 * @author jerviver21
 */
@Stateless
@LocalBean
public class ClasificadosTimer {
    
    @EJB
    PedidoService pedidoService;
    
    @EJB
    ClasificadosService clasificadosService;
    
    @Resource
    javax.ejb.TimerService timerService;

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
    public void ejecutarTareaProgramada(Timer timer){
        
        Log.getLogger().log(Level.INFO,"Inicia Revisión de de estados en tarea Programada...");
        
        try {
            clasificadosService.actualizarEstados();

            pedidoService.actualizarEstados();
            
            //Recarga de cache para las consultas de clasificados online
            clasificadosService.recargarCache();
        } catch (Exception e) {
            Log.getLogger().log(Level.SEVERE, " Error: {0}", e.getMessage());
        }
        
        Log.getLogger().log(Level.INFO, "Termina Revisi\u00f3n de estados... Pr\u00f3xima ejecuci\u00f3n en: {0} horas", (timer.getTimeRemaining()/(1000*60*60)));
        
    }

}
