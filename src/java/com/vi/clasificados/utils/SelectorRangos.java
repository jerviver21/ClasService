package com.vi.clasificados.utils;

import com.vi.clasificados.dominio.Clasificado;
import com.vi.clasificados.dominio.TipoClasificado;

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
    
    
    
    public void setRangoValores(Clasificado clasificado){
        TipoClasificado tipo = null;
        if(clasificado.getTipo().equals(ClasificadosTipo.INMOBILIARIO)){
            if(clasificado.getSubtipo1().getId().equals(5)){//Venta
                if(clasificado.getValorOferta() == null){
                    tipo =  SININFOIMB;
                }else if(clasificado.getValorOferta().doubleValue() <= 30000){
                    tipo =  HASTA30000IMB;
                }else if(clasificado.getValorOferta().doubleValue() > 30000 && clasificado.getValorOferta().doubleValue() <= 60000){
                    tipo =  E30000Y60000IMB;
                }if(clasificado.getValorOferta().doubleValue() > 60000 && clasificado.getValorOferta().doubleValue() <= 90000){
                    tipo =  E60000Y90000IMB;
                }if(clasificado.getValorOferta().doubleValue() > 90000 && clasificado.getValorOferta().doubleValue() <= 120000){
                    tipo =  E90000Y120000IMB;
                }if(clasificado.getValorOferta().doubleValue() > 120000 && clasificado.getValorOferta().doubleValue() <= 150000){
                    tipo =  E120000Y150000IMB;
                }if(clasificado.getValorOferta().doubleValue() > 150000){
                    tipo =  MAS150000IMB;
                }
            }else{
                if(clasificado.getValorOferta() == null){
                    tipo =  SININFOIMBA;
                }else if(clasificado.getValorOferta().doubleValue() <= 500){
                    tipo =  HASTA500IMBA;
                }else if(clasificado.getValorOferta().doubleValue() > 500 && clasificado.getValorOferta().doubleValue() <= 800){
                    tipo =  E500Y800IMBA;
                }if(clasificado.getValorOferta().doubleValue() > 800 && clasificado.getValorOferta().doubleValue() <= 1200){
                    tipo =  E800Y1200IMBA;
                }if(clasificado.getValorOferta().doubleValue() > 1200 && clasificado.getValorOferta().doubleValue() <= 1800){
                    tipo =  E1200Y1800IMBA;
                }if(clasificado.getValorOferta().doubleValue() > 1800){
                    tipo =  MAS1800IMBA;
                }
            }
            clasificado.setSubtipo5(tipo);
        }else if(clasificado.getTipo().equals(ClasificadosTipo.EMPLEO)){
            if(clasificado.getValorOferta() == null){
                tipo =  ACONVENIR;
            }else if(clasificado.getValorOferta().doubleValue() <= 1000){
                tipo =  HASTA1000EMP;
            }else if(clasificado.getValorOferta().doubleValue() > 1000 && clasificado.getValorOferta().doubleValue() <= 2000){
                tipo =  E1000Y2000EMP;
            }if(clasificado.getValorOferta().doubleValue() > 2000 && clasificado.getValorOferta().doubleValue() <= 3000){
                tipo =  E2000Y3000EMP;
            }if(clasificado.getValorOferta().doubleValue() > 3000 && clasificado.getValorOferta().doubleValue() <= 4000){
                tipo =  E3000Y4000EMP;
            }if(clasificado.getValorOferta().doubleValue() > 4000 && clasificado.getValorOferta().doubleValue() <= 5000){
                tipo =  E4000Y5000EMP;
            }if(clasificado.getValorOferta().doubleValue() > 5000){
                tipo =  MAS5000EMP;
            }
            clasificado.setSubtipo3(tipo);
        }else if(clasificado.getTipo().equals(ClasificadosTipo.VEHICULO)){
            if(clasificado.getValorOferta() == null){
                tipo =  SININFOIVEH;
            }else if(clasificado.getValorOferta().doubleValue() <= 5000){
                tipo =  HASTA5000VEH;
            }else if(clasificado.getValorOferta().doubleValue() > 5000 && clasificado.getValorOferta().doubleValue() <= 9000){
                tipo =  E5000Y9000VEH;
            }if(clasificado.getValorOferta().doubleValue() > 9000 && clasificado.getValorOferta().doubleValue() <= 14000){
                tipo =  E9000Y14000VEH;
            }if(clasificado.getValorOferta().doubleValue() > 14000 && clasificado.getValorOferta().doubleValue() <= 20000){
                tipo =  E14000Y20000VEH;
            }if(clasificado.getValorOferta().doubleValue() > 20000){
                tipo =  MAS20000VEH;
            }
            clasificado.setSubtipo3(tipo);
        }
        
    }
    
    
   
    
    
}
