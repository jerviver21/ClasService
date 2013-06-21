/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.dominio;

import java.math.BigDecimal;

/**
 * @author jerviver21
 */
public class DetallePrecioClasificado {
    private Precios precio;
    private int numDias;
    private int numPalabras;
    private BigDecimal precioTotal = BigDecimal.ZERO;

    /**
     * @return the precio
     */
    public Precios getPrecio() {
        return precio;
    }

    /**
     * @param precio the precio to set
     */
    public void setPrecio(Precios precio) {
        this.precio = precio;
    }

    /**
     * @return the numDias
     */
    public int getNumDias() {
        return numDias;
    }

    /**
     * @param numDias the numDias to set
     */
    public void setNumDias(int numDias) {
        this.numDias = numDias;
    }

    /**
     * @return the numPalabras
     */
    public int getNumPalabras() {
        return numPalabras;
    }

    /**
     * @param numPalabras the numPalabras to set
     */
    public void setNumPalabras(int numPalabras) {
        this.numPalabras = numPalabras;
    }

    /**
     * @return the precioTotal
     */
    public BigDecimal getPrecioTotal() {
        if(precio.getProcesarXPalabra()){
          precioTotal = precio.getPrecio().multiply(new BigDecimal(numPalabras)).multiply(new BigDecimal(numDias));  
        }else{
          precioTotal = precio.getPrecio().multiply(new BigDecimal(numDias));    
        }
        
        return precioTotal;
    }

    /**
     * @param precioTotal the precioTotal to set
     */
    public void setPrecioTotal(BigDecimal precioTotal) {
        this.precioTotal = precioTotal;
    }
    
}
