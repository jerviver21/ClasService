/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.utils;

import com.vi.clasificados.dominio.EstadosClasificado;

/**
 *
 * @author jerviver21
 */
public class ClasificadoEstados {
    
    public static EstadosClasificado PEDIDOXPAGAR = new EstadosClasificado(1);
    public static EstadosClasificado PUBLICADO = new EstadosClasificado(2);
    public static EstadosClasificado CANCELADO = new EstadosClasificado(3);
    public static EstadosClasificado PEDIDOVENCIDO = new EstadosClasificado(4);
    public static EstadosClasificado VENDIDO = new EstadosClasificado(5);
    public static EstadosClasificado EXPIRADO = new EstadosClasificado(6);
    
    
}
