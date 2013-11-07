package com.vi.clasificados.utils;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.Currencies;
import com.vi.clasificados.dominio.TipoClasificado;
import java.math.BigDecimal;

/**
 * @author jerviver21
 */
public class SelectorRangos {
    //Precios inmbobiliario venta
    private final TipoClasificado SININFOIMB = new TipoClasificado(116);
    private final TipoClasificado HASTA30000IMB = new TipoClasificado(117);
    private final TipoClasificado E30000Y60000IMB = new TipoClasificado(118);
    private final TipoClasificado E60000Y90000IMB = new TipoClasificado(119);
    private final TipoClasificado E90000Y120000IMB = new TipoClasificado(120);
    private final TipoClasificado E120000Y150000IMB = new TipoClasificado(121);
    private final TipoClasificado MAS150000IMB = new TipoClasificado(122);
    
    //Precios inmbobiliario alquiler
    private final TipoClasificado SININFOIMBA = new TipoClasificado(133);
    private final TipoClasificado HASTA500IMBA = new TipoClasificado(134);
    private final TipoClasificado E500Y800IMBA = new TipoClasificado(135);
    private final TipoClasificado E800Y1200IMBA = new TipoClasificado(136);
    private final TipoClasificado E1200Y1800IMBA = new TipoClasificado(137);
    private final TipoClasificado MAS1800IMBA = new TipoClasificado(138);
    
     //Precios vehiculos
    private final TipoClasificado SININFOIVEH = new TipoClasificado(139);
    private final TipoClasificado HASTA5000VEH = new TipoClasificado(128);
    private final TipoClasificado E5000Y9000VEH = new TipoClasificado(129);
    private final TipoClasificado E9000Y14000VEH = new TipoClasificado(130);
    private final TipoClasificado E14000Y20000VEH = new TipoClasificado(131);
    private final TipoClasificado MAS20000VEH = new TipoClasificado(132);
    
    //Salarios
    private final TipoClasificado ACONVENIR = new TipoClasificado(109);
    private final TipoClasificado HASTA1000EMP = new TipoClasificado(110);
    private final TipoClasificado E1000Y2000EMP = new TipoClasificado(111);
    private final TipoClasificado E2000Y3000EMP = new TipoClasificado(112);
    private final TipoClasificado E3000Y4000EMP = new TipoClasificado(113);
    private final TipoClasificado E4000Y5000EMP = new TipoClasificado(114);
    private final TipoClasificado MAS5000EMP = new TipoClasificado(115);
    
    
    
    public void setRangoValores(Clasificado clasificado, Currencies moneda){
        TipoClasificado tipo = null;
        BigDecimal valor = BigDecimal.ZERO;
        if(clasificado.getValorOferta() != null){
            valor = clasificado.getValorOferta();
        }
        if(clasificado.getTipo().equals(ClasificadosTipo.INMOBILIARIO)){
            if(clasificado.getSubtipo1().getId().equals(5)){//Venta
                if(clasificado.getValorOferta() != null && moneda.equals(Monedas.SOLES)){
                    valor = clasificado.getValorOferta().multiply(moneda.getCambio());
                }
                if(clasificado.getValorOferta() == null){
                    tipo =  SININFOIMB;
                }else if(valor.intValue() <= 30000){
                    tipo =  HASTA30000IMB;
                }else if(valor.intValue() > 30000 && valor.intValue() <= 60000){
                    tipo =  E30000Y60000IMB;
                }if(valor.intValue() > 60000 && valor.intValue() <= 90000){
                    tipo =  E60000Y90000IMB;
                }if(valor.intValue() > 90000 && valor.intValue() <= 120000){
                    tipo =  E90000Y120000IMB;
                }if(valor.intValue() > 120000 && valor.intValue() <= 150000){
                    tipo =  E120000Y150000IMB;
                }if(valor.intValue() > 150000){
                    tipo =  MAS150000IMB;
                }
                clasificado.setSubtipo5(tipo);
            }else{//Alquiler
                if(clasificado.getValorOferta() != null && moneda.equals(Monedas.DOLARES)){
                    valor = clasificado.getValorOferta().multiply(moneda.getCambio());
                }
                if(clasificado.getValorOferta() == null){
                    tipo =  SININFOIMBA;
                }else if(valor.intValue() <= 500){
                    tipo =  HASTA500IMBA;
                }else if(valor.intValue() > 500 && valor.intValue() <= 800){
                    tipo =  E500Y800IMBA;
                }else if(valor.intValue() > 800 && valor.intValue() <= 1200){
                    tipo =  E800Y1200IMBA;
                }else if(valor.intValue() > 1200 && valor.intValue() <= 1800){
                    tipo =  E1200Y1800IMBA;
                }else if(valor.intValue() > 1800){
                    tipo =  MAS1800IMBA;
                }
                clasificado.setSubtipo5(tipo);
            }
            
        }else if(clasificado.getTipo().equals(ClasificadosTipo.EMPLEO)){
            if(clasificado.getValorOferta() != null && moneda.equals(Monedas.DOLARES)){
               valor = clasificado.getValorOferta().multiply(moneda.getCambio());
            }
            if(clasificado.getValorOferta() == null){
                tipo =  ACONVENIR;
            }else if(valor.intValue() <= 1000){
                tipo =  HASTA1000EMP;
            }else if(valor.intValue() > 1000 && valor.intValue() <= 2000){
                tipo =  E1000Y2000EMP;
            }else if(valor.intValue() > 2000 && valor.intValue() <= 3000){
                tipo =  E2000Y3000EMP;
            }else if(valor.intValue() > 3000 && valor.intValue() <= 4000){
                tipo =  E3000Y4000EMP;
            }else if(valor.intValue() > 4000 && valor.intValue() <= 5000){
                tipo =  E4000Y5000EMP;
            }else if(valor.intValue() > 5000){
                tipo =  MAS5000EMP;
            }
            clasificado.setSubtipo3(tipo);
        }else if(clasificado.getTipo().equals(ClasificadosTipo.VEHICULO)){
            if(clasificado.getValorOferta() != null && moneda.equals(Monedas.SOLES)){
                valor = clasificado.getValorOferta().multiply(moneda.getCambio());
            }
            if(clasificado.getValorOferta() == null){
                tipo =  SININFOIVEH;
            }else if(valor.intValue() <= 5000){
                tipo =  HASTA5000VEH;
            }else if(valor.intValue() > 5000 && valor.intValue() <= 9000){
                tipo =  E5000Y9000VEH;
            }else if(valor.intValue() > 9000 && valor.intValue() <= 14000){
                tipo =  E9000Y14000VEH;
            }else if(valor.intValue() > 14000 && valor.intValue() <= 20000){
                tipo =  E14000Y20000VEH;
            }else if(valor.intValue() > 20000){
                tipo =  MAS20000VEH;
            }
            clasificado.setSubtipo3(tipo);
        }
    }
    
    
   
    
    
}
