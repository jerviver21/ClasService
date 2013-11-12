/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.Pedido;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.EntidadesDePago;
import com.vi.clasificados.utils.PedidoEstados;
import com.vi.comun.exceptions.ValidacionException;
import com.vi.comun.locator.ParameterLocator;
import com.vi.comun.util.FechaUtils;
import com.vi.comun.util.FilesUtils;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author jerviver21
 */
@Stateless
@LocalBean
public class PagoService {
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;
    ParameterLocator locator;

    @EJB
    PedidoService pedidoService;
    
    
    public PagoService(){
        locator = ParameterLocator.getInstance();
    }
    
    public void generarSolicitudPago(String nroPago, BigDecimal valor, Date fechaLimite)throws FileNotFoundException, IOException{
        String ruta = locator.getParameter("rutaPago");
        File dirSolicitud = new File(ruta+File.separator+"solicitudes");
        if(!dirSolicitud.exists()){
            dirSolicitud.mkdirs();
        }
        RandomAccessFile archivo = new RandomAccessFile(dirSolicitud+File.separator+nroPago, "rw");
        archivo.writeBytes(nroPago+","+valor+","+fechaLimite);
    }
    
    public void recibirPago()throws FileNotFoundException, IOException, ParseException{
        SimpleDateFormat fd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String ruta = locator.getParameter("rutaPago");
        File dirPagos = new File(ruta+File.separator+"recibidos");
        if(!dirPagos.exists()){
            dirPagos.mkdirs();
        }
        File dirArchivados = new File(ruta+File.separator+"archivados");
        if(!dirArchivados.exists()){
            dirArchivados.mkdirs();
        }
        String[] pagos = dirPagos.list();
        for(String nombre : pagos){
            File archivo = new File(dirPagos.getAbsolutePath()+File.separator+nombre);
            BufferedReader lector = new BufferedReader(new FileReader(archivo));
            String linea = lector.readLine();
            String[] datos = linea.split(",");
            String nroPago = datos[0];
            Date fechaHoraPago = fd.parse(datos[1]);
            Pedido pedido = pedidoService.findByNro(nroPago);
            System.out.println(pedido+" - "+nroPago);
            pedido.setEstado(PedidoEstados.PAGO);
            pedido.setFechaHoraPago(fechaHoraPago);
            List<Clasificado> clasificados = pedido.getClasificados();
            for(Clasificado clasificado:clasificados){
                clasificado.setEstado(ClasificadoEstados.PUBLICADO);
                em.merge(clasificado);
            }
            em.merge(pedido);
            FilesUtils.moverArchivo(archivo.getAbsolutePath(), dirArchivados.getAbsolutePath()+File.separator+nombre);
        }
    }

    public void simularPago(String codPago)throws FileNotFoundException, IOException {
        SimpleDateFormat fd = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String ruta = locator.getParameter("rutaPago");
        File dirSolicitud = new File(ruta+File.separator+"recibidos");
        if(!dirSolicitud.exists()){
            dirSolicitud.mkdirs();
        }
        RandomAccessFile archivo = new RandomAccessFile(dirSolicitud+File.separator+codPago, "rw");
        archivo.writeBytes(codPago+","+fd.format(new Date()));
    }
    
    public void realizarPago(String codPago)throws ValidacionException {
        Pedido pedido = pedidoService.findByNro(codPago);
        
        
        System.out.println(FechaUtils.getFechaHoy()+" - "+pedido.getFechaVencimiento());
        if(FechaUtils.getFechaHoy().after(pedido.getFechaVencimiento())){
            throw new ValidacionException("El pedido se encuentra vencido");
        }

        pedido.setEntidad(EntidadesDePago.PERIODICO);
        pedido.setEstado(PedidoEstados.PAGO);
        pedido.setFechaHoraPago(new Date());
        List<Clasificado> clasificados = pedido.getClasificados();
        for(Clasificado clasificado:clasificados){
            clasificado.setEstado(ClasificadoEstados.PUBLICADO);
            em.merge(clasificado);
        } 
        em.merge(pedido);
    }

}
