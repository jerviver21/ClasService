/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.Pedido;
import java.util.Date;
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
    
    public Pedido save(Pedido pedido){
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
        System.out.println(pedido.getEntidad().getMensajePago());
        pedido.setMensajePago(pedido.getEntidad().getMensajePago().replace("COD_PAGO", pedido.getCodPago()));
        return pedido;
    }

}
