/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.Pedido;
import com.vi.clasificados.utils.PedidoEstados;
import com.vi.comun.locator.ParameterLocator;
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
public class PedidoService {
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;
    ParameterLocator locator;
    
    
    public PedidoService(){
        locator = ParameterLocator.getInstance();
    }
    
    public Pedido findByNro(String codigo){
        List<Pedido> pedido = em.createNamedQuery("Pedido.findByCodigo").setParameter("codigo", codigo).getResultList();
        if(pedido.isEmpty()){
            return null;
        }
        return pedido.get(0);
    }
    
    public Pedido save(Pedido pedido)throws FileNotFoundException, IOException{
        Date fechaLimitePago = null;
        for(Clasificado clasificado : pedido.getClasificados()){
            if(fechaLimitePago == null){
                fechaLimitePago = clasificado.getFechaIni();
            }else{
               if(clasificado.getFechaIni().before(fechaLimitePago)){
                   fechaLimitePago = clasificado.getFechaIni();
               } 
            }
            clasificado.setPedido(pedido);
        }
        pedido.setFechaVencimiento(fechaLimitePago);
        pedido = em.merge(pedido);
        //Aqui habra que decidir la cuestion de acuerdo a la entidad de pago
        pedido.setCodPago(String.format("%012d", pedido.getId()));
        pedido = em.merge(pedido);
        pedido.setMensajePago(pedido.getEntidad().getMensajePago().replace("COD_PAGO", pedido.getCodPago()));
        generarSolicitudPago(pedido.getCodPago(), pedido.getValorTotal(), fechaLimitePago);
        return pedido;
    }

    public List<Pedido> getPedidosActivos(String usr) {
        List<Pedido> pedidos = em.createNamedQuery("Pedido.findByUsrAndEstado")
                .setParameter("usr", usr)
                .setParameter("estado", PedidoEstados.VENCIDO).getResultList();
        return pedidos;
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
        SimpleDateFormat fd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String ruta = locator.getParameter("rutaPago");
        File dirPagos = new File(ruta+File.separator+"recibidos");
        if(!dirPagos.exists()){
            dirPagos.mkdirs();
        }
        String[] pagos = dirPagos.list();
        for(String nombre : pagos){
            File archivo = new File(dirPagos.getAbsolutePath()+File.separator+nombre);
            BufferedReader lector = new BufferedReader(new FileReader(archivo));
            String linea = lector.readLine();
            String[] datos = linea.split(",");
            String nroPago = datos[0];
            Date fechaHoraPago = fd.parse(datos[1]);
            Pedido pedido = findByNro(nroPago);
            pedido.setEstado(PedidoEstados.PAGO);
            pedido.setFechaHoraPago(fechaHoraPago);
            em.merge(pedido);
            FilesUtils.moverArchivo(archivo.getAbsolutePath(), ruta+File.separator+"archivados"+File.separator+nombre);
        }
    }
    
    

}
