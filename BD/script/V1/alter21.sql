ALTER TABLE ruta_imagenes RENAME COLUMN rutaimgo TO img0;
ALTER TABLE ruta_imagenes RENAME COLUMN ruta TO url_root;
ALTER TABLE ruta_imagenes ADD ruta varchar(1000);
