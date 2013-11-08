ALTER TABLE clasificado DROP CONSTRAINT imagen_clasificado_pk;
DROP TABLE img_clasificado;
ALTER TABLE clasificado DROP COLUMN id_imagenes;
ALTER TABLE clasificado ADD ruta_imagenes varchar(1000);
