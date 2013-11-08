package com.vi.clasificados.to;

import com.vi.comun.util.Log;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.logging.Level;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;

/**
 *
 * @author jerviver21
 */
public class ImgClasificadoTO {
    private StreamedContent primeImg;
    private String rutaImg;
    private int consecutivo;
    private InputStream img;
    private String extension;

    /**
     * @return the img
     */
    public InputStream getImg() {
        return img;
    }

    /**
     * @param img the img to set
     */
    public void setImg(InputStream img) {
        this.img = img;
    }

    /**
     * @return the extension
     */
    public String getExtension() {
        return extension;
    }

    /**
     * @param extension the extension to set
     */
    public void setExtension(String extension) {
        this.extension = extension;
    }

    /**
     * @return the primeImg
     */
    public StreamedContent getPrimeImg() {
        try {
            StreamedContent defaultFileContent = new DefaultStreamedContent(new FileInputStream(new File("/home/server/appfiles/img_clasificados/3/silla1.jpg")), "image/jpg");
            
            if(img == null){
                File inFile = new File(rutaImg);
                img = new FileInputStream(inFile);  
            }
            primeImg = new DefaultStreamedContent(img, "image/"+extension);
        } catch (Exception e) {
            System.out.println("Error al tratar de retornar el streamcontent de la imagen");
            Log.getLogger().log(Level.SEVERE, e.getMessage(), e);
        }
        return primeImg;
    }

    /**
     * @param primeImg the primeImg to set
     */
    public void setPrimeImg(StreamedContent primeImg) {
        this.primeImg = primeImg;
    }

    /**
     * @return the rutaImg
     */
    public String getRutaImg() {
        return rutaImg;
    }

    /**
     * @param rutaImg the rutaImg to set
     */
    public void setRutaImg(String rutaImg) {
        this.rutaImg = rutaImg;
    }

    /**
     * @return the consecutivo
     */
    public int getConsecutivo() {
        return consecutivo;
    }

    /**
     * @param consecutivo the consecutivo to set
     */
    public void setConsecutivo(int consecutivo) {
        this.consecutivo = consecutivo;
    }
    
}
