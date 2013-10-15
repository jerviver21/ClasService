ALTER TABLE clasificado ADD ruta_imagen int4;
ALTER TABLE clasificado ADD num_imagenes int4;
ALTER TABLE clasificado ADD prioridad int4;
ALTER TABLE clasificado DROP COLUMN ruta_imagen;
ALTER TABLE clasificado ADD ruta_imagen varchar(1000);
