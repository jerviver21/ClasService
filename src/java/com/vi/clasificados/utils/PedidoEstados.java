/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.utils;

import com.vi.clasificados.dominio.EstadosPedido;

/**
 *
 * @author jerviver21
 */
public class PedidoEstados {
    public static EstadosPedido ACTIVO_PAGO = new EstadosPedido(1);
    public static EstadosPedido PAGO = new EstadosPedido(2);
    public static EstadosPedido VENCIDO = new EstadosPedido(3);
    public static EstadosPedido CANCELADO = new EstadosPedido(4);
    
}
