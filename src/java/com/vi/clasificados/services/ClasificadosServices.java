
package com.vi.clasificados.services;

import java.util.List;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 * @author jerviver21
 */
@Stateless
@LocalBean
public class ClasificadosServices {
    @PersistenceContext(unitName = "ClasificadosPU")
    private EntityManager em;
    
    
}
