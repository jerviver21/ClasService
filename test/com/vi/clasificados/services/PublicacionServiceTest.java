/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Clasificado;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import javax.ejb.embeddable.EJBContainer;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author jerviver21
 */
public class PublicacionServiceTest {
    
    public PublicacionServiceTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
        System.out.println("Inicio");
    }
    
    @AfterClass
    public static void tearDownClass() {
        System.out.println("Fin");
    }
    

    /**
     * Test of init method, of class PublicacionService.
     */
    @Test
    public void testInit() throws Exception {
        System.out.println("init");
        EJBContainer container = javax.ejb.embeddable.EJBContainer.createEJBContainer();
        PublicacionService instance = (PublicacionService)container.getContext().lookup("java:global/classes/PublicacionService");
        instance.init();
        container.close();
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of procesarClasificado method, of class PublicacionService.
     */
    @Test
    public void testProcesarClasificado() throws Exception {
        System.out.println("procesarClasificado");
        Clasificado clasificado = null;
        EJBContainer container = javax.ejb.embeddable.EJBContainer.createEJBContainer();
        PublicacionService instance = (PublicacionService)container.getContext().lookup("java:global/classes/PublicacionService");
        List expResult = null;
        List result = instance.procesarClasificado(clasificado);
        assertEquals(expResult, result);
        container.close();
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of procesarEdicion method, of class PublicacionService.
     */
    @Test
    public void testProcesarEdicion() throws Exception {
        System.out.println("procesarEdicion");
        Clasificado clasificado = null;
        EJBContainer container = javax.ejb.embeddable.EJBContainer.createEJBContainer();
        PublicacionService instance = (PublicacionService)container.getContext().lookup("java:global/classes/PublicacionService");
        Clasificado expResult = null;
        Clasificado result = instance.procesarEdicion(clasificado);
        assertEquals(expResult, result);
        container.close();
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of calcularValores method, of class PublicacionService.
     */
    @Test
    public void testCalcularValores() throws Exception {
        System.out.println("calcularValores");
        Clasificado clasificado = null;
        Map preciosXDia = null;
        EJBContainer container = javax.ejb.embeddable.EJBContainer.createEJBContainer();
        PublicacionService instance = (PublicacionService)container.getContext().lookup("java:global/classes/PublicacionService");
        instance.calcularValores(clasificado, preciosXDia);
        container.close();
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }

    /**
     * Test of calcularTotalPedido method, of class PublicacionService.
     */
    @Test
    public void testCalcularTotalPedido() throws Exception {
        System.out.println("calcularTotalPedido");
        List<Clasificado> clasificados = null;
        EJBContainer container = javax.ejb.embeddable.EJBContainer.createEJBContainer();
        PublicacionService instance = (PublicacionService)container.getContext().lookup("java:global/classes/PublicacionService");
        BigDecimal expResult = null;
        BigDecimal result = instance.calcularTotalPedido(clasificados);
        assertEquals(expResult, result);
        container.close();
        // TODO review the generated test code and remove the default call to fail.
        fail("The test case is a prototype.");
    }
}
