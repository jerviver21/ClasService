/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.utils;

import com.vi.clasificados.dominio.EstadosClasificado;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author jerviver21
 */
public class ClasificadoEstados {
    
    public static EstadosClasificado PEDIDOXPAGAR = new EstadosClasificado(1, "PENDIENTE DE PAGO");
    public static EstadosClasificado PUBLICADO = new EstadosClasificado(2, "PUBLICADO");
    public static EstadosClasificado CANCELADO = new EstadosClasificado(3, "CANCELADO");
    public static EstadosClasificado PEDIDOVENCIDO = new EstadosClasificado(4, "PEDIDO VENCIDO");
    public static EstadosClasificado VENDIDO = new EstadosClasificado(5, "VENDIDO");
    public static EstadosClasificado EXPIRADO = new EstadosClasificado(6, "EXPIRADO");
    
    public static List<EstadosClasificado> getEstados() {
        List<EstadosClasificado> estados = new ArrayList<EstadosClasificado>();
        estados.add(PEDIDOXPAGAR);
        estados.add(PUBLICADO);
        estados.add(CANCELADO);
        estados.add(PEDIDOVENCIDO);
        estados.add(VENDIDO);
        estados.add(EXPIRADO);
        return estados;
    }
    
    public static List<EstadosClasificado> getEstadosEditables() {
        List<EstadosClasificado> estados = new ArrayList<EstadosClasificado>();
        estados.add(PUBLICADO);
        estados.add(CANCELADO);
        estados.add(VENDIDO);
        return estados;
    }
    
    
}
