/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.EstadosPedido;
import com.vi.clasificados.dominio.Pedido;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.EntidadesDePago;
import com.vi.clasificados.utils.PedidoEstados;
import com.vi.comun.exceptions.ParametroException;
import com.vi.comun.exceptions.ValidacionException;
import com.vi.comun.locator.ParameterLocator;
import com.vi.comun.util.FechaUtils;
import com.vi.comun.util.FilesUtils;
import com.vi.comun.util.Log;
import com.vi.usuarios.dominio.Users;
import com.vi.usuarios.services.UsuariosServicesLocal;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
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
public class PedidoService {
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;
    ParameterLocator locator;
    
    @EJB
    UsuariosServicesLocal usuarioService;
    
    
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
    
    public Pedido habilitarPago(Pedido pedido)throws FileNotFoundException, IOException{
        Date fechaLimitePago = null;
        for(Clasificado clasificado : pedido.getClasificados()){
            if(fechaLimitePago == null){
                fechaLimitePago = FechaUtils.getFechaMasPeriodo(clasificado.getFechaIni(), -1, Calendar.DATE);
            }else{
               if(clasificado.getFechaIni().before(fechaLimitePago)){
                   fechaLimitePago = FechaUtils.getFechaMasPeriodo(clasificado.getFechaIni(), -1, Calendar.DATE);
               } 
            }
            clasificado.setPedido(pedido);
        }
        pedido.setFechaVencimiento(fechaLimitePago);
        Users usr = usuarioService.findByUser(pedido.getUsuario());
        pedido.setNombreCliente(usr.getNombre());
        pedido.setDniCliente(usr.getNumId());
        
        pedido = em.merge(pedido);
        //Aqui habra que decidir la cuestion de acuerdo a la entidad de pago
        pedido.setCodPago(String.format("%012d", pedido.getId()));
        pedido = em.merge(pedido);
        pedido.setMensajePago(pedido.getEntidad().getMensajePago().replace("COD_PAGO", pedido.getCodPago()));
        generarSolicitudPago(pedido.getCodPago(), pedido.getValorTotal(), fechaLimitePago);
        return pedido;
    }
    
    public Pedido guardarPedido(Pedido pedido)throws FileNotFoundException, IOException{
        pedido.setEntidad(EntidadesDePago.PERIODICO);
        pedido.setEstado(PedidoEstados.PAGO);
        for(Clasificado clasificado : pedido.getClasificados()){
            clasificado.setEstado(ClasificadoEstados.PUBLICADO);
            clasificado.setPedido(pedido);
        }
        pedido = em.merge(pedido);
        pedido.setMensajePago("Pedido realizado con exito.");
        return pedido;
    }
    
    public List<Pedido> getPedidos(String usuario, EstadosPedido estado) {
        List<Pedido> pedidos = em.createNamedQuery("Pedido.findByUsrAndEstado")
                .setParameter("usr", usuario)
                .setParameter("estado", estado).getResultList();
        return pedidos;
    }
    
    public List<Clasificado> getClasificados(Pedido pedido){
        pedido = em.merge(pedido);
        pedido.getClasificados().size();
        return pedido.getClasificados();
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
            Pedido pedido = findByNro(nroPago);
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
        Pedido pedido = findByNro(codPago);
        
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
    
    public void actualizarEstados()throws ParametroException{
        Boolean depurar = Boolean.parseBoolean(locator.getParameter("depurar"));
        if(depurar == null){
            throw  new ParametroException("No existe el parámetro depurar");
        }
        
        Date fechaHoy = FechaUtils.getFechaHoy();

        List<Pedido> pedidos = em.createNamedQuery("Pedido.findByEstado").setParameter("estado", PedidoEstados.ACTIVO_PAGO).getResultList();
        
        if(depurar){
            Log.getLogger().log(Level.INFO, "Pedidos por pagar: -> {0}", pedidos.size());
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
        
    }

    
    
    

}
