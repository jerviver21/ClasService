ALTER TABLE clasificado ADD CONSTRAINT ruta_clas_fk FOREIGN KEY (id_ruta_imagenes) REFERENCES ruta_imagenes(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE tipo_publicacion ADD prioridad int4;
ALTER TABLE ruta_imagenes DROP COLUMN ruta;
ALTER TABLE ruta_imagenes ADD ruta varchar(1000);
