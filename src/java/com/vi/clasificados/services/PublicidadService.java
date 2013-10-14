/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vi.clasificados.services;

import com.vi.clasificados.dominio.Publicidad;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author jerviver21
 */
@Stateless
@LocalBean
public class PublicidadService {
    
    public static final String BANNER_SUPERIOR = "BS";
    public static final String BANNER_LIEmp = "BLIE";
    public static final String BANNER_LIImb = "BLII";
    public static final String BANNER_LIVeh = "BLIV";
    public static final String BANNER_LIOtr = "BLIO";
    public static final String BANNER_LD1Emp = "BLD1E";
    public static final String BANNER_LD2Emp = "BLD2E";
    public static final String BANNER_LD3Emp = "BLD3E";
    public static final String BANNER_LD1Imb = "BLD1I";
    public static final String BANNER_LD2Imb = "BLD2I";
    public static final String BANNER_LD3Imb = "BLD3I";
    public static final String BANNER_LD1Veh = "BLD1V";
    public static final String BANNER_LD2Veh = "BLD2V";
    public static final String BANNER_LD3Veh = "BLD3V";
    public static final String BANNER_LD1Otr = "BLD1O";
    public static final String BANNER_LD2Otr = "BLD2O";
    public static final String BANNER_LD3Otr = "BLD3O";

    
    
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;

    public Publicidad getBanner(String BANNER){
        List<Publicidad> banners = em.createNamedQuery("Publicidad.findByBanner").setParameter("fecha", new Date()).setParameter("banner", BANNER).getResultList();
        if(banners.isEmpty()){
            return null;
        }
        return banners.get(0);
    }

}
