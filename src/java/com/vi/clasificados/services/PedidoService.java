/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.EstadosPedido;
import com.vi.clasificados.dominio.Pedido;
import com.vi.clasificados.dominio.RutaImagenes;
import com.vi.clasificados.to.ImgClasificadoTO;
import com.vi.clasificados.utils.ClasificadoEstados;
import com.vi.clasificados.utils.EntidadesDePago;
import com.vi.clasificados.utils.PedidoEstados;
import com.vi.comun.exceptions.ParametroException;
import com.vi.comun.locator.ParameterLocator;
import com.vi.comun.util.FechaUtils;
import com.vi.comun.util.FilesUtils;
import com.vi.comun.util.Log;
import com.vi.usuarios.dominio.Users;
import com.vi.usuarios.services.UsuariosServicesLocal;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;
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
    
    @EJB
    PagoService pagoService;
    
    
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
    
    
    //Métodos de publicación
    public Pedido guardarPedido(Pedido pedido)throws ParametroException, FileNotFoundException, IOException{
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
            //Para los clasificados que contengan imagenes se guardan las imagenes en el disco.
            cargarImagenes(clasificado);
        }
        
        boolean esAsesor = usuarioService.findRolesUser(pedido.getUsuario()).contains("ASESOR PAGOS");
        System.out.println("Es asesor: "+esAsesor);
        
        if(esAsesor){
            pedido.setEntidad(EntidadesDePago.PERIODICO);
            pedido.setEstado(PedidoEstados.PAGO);
            for(Clasificado clasificado : pedido.getClasificados()){
                clasificado.setEstado(ClasificadoEstados.PUBLICADO);
                clasificado.setPedido(pedido);
            }
            pedido = em.merge(pedido);
            pedido.setMensajePago("Pedido realizado con exito.");
        }else{
            pedido.setFechaVencimiento(fechaLimitePago);
            Users usr = usuarioService.findByUser(pedido.getUsuario());
            pedido.setNombreCliente(usr.getNombre());
            pedido.setDniCliente(usr.getNumId());
            pedido = em.merge(pedido);
            if(pedido.getValorTotal().equals(BigDecimal.ZERO)){
                pedido.setEstado(PedidoEstados.PAGO);
                for(Clasificado clasificado : pedido.getClasificados()){
                    clasificado.setEstado(ClasificadoEstados.PUBLICADO);
                }
                pedido.setMensajePago("Su pedido ha sido enviado, su contenido será revisado y se publicará en las próximas 24 horas");
            }else{
                //Aqui habra que decidir la cuestion de acuerdo a la entidad de pago
                pedido.setCodPago(String.format("%012d", pedido.getId()));
                pagoService.generarSolicitudPago(pedido.getCodPago(), pedido.getValorTotal(), fechaLimitePago);
                pedido.setMensajePago(pedido.getEntidad().getMensajePago().replace("COD_PAGO", pedido.getCodPago()));
            }
            pedido = em.merge(pedido);
        }
        return pedido;
    }
    
    
    public void cargarImagenes(Clasificado clasificado)throws ParametroException, FileNotFoundException, IOException{
        if(!clasificado.getImagenes().isEmpty()){
            RutaImagenes ruta = new RutaImagenes();
            ruta= em.merge(ruta);//Guarda el id, que nos permite crear la ruta para guardar las imagenes del clasificado.
            String rutaImgs = locator.getParameter("rutaImagenes");
            if(rutaImgs == null){
                throw new ParametroException("El parámetro dirCertificados no existe " );
            }
            ruta.setRuta(rutaImgs+File.separator+ruta.getId());
            clasificado.setRutaImagenes(ruta);
            clasificado.setNumImagenes(clasificado.getImagenes().size());
            int consecutivoImg = 0;
            for(ImgClasificadoTO img : clasificado.getImagenes()){
                FilesUtils.crearArchivo(ruta.getRuta(), "IMG"+consecutivoImg+"."+img.getExtension(), img.getImg());
                img.getImg().close();
                consecutivoImg++;
            }
        }
    }
   

}
