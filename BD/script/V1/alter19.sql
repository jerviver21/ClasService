CREATE TABLE ruta_imagenes (
	id bigserial NOT NULL,
	ruta varchar(1000) NOT NULL
);
ALTER TABLE ruta_imagenes ADD CONSTRAINT ruta_imagenes_pk PRIMARY KEY(id);
ALTER TABLE clasificado DROP COLUMN ruta_imagenes;
ALTER TABLE clasificado ADD id_ruta_imagenes bigint;
ALTER TABLE clasificado ADD CONSTRAINT ruta_clas_fk FOREIGN KEY (id_ruta_imagenes) REFERENCES ruta_imagenes(id) ON DELETE CASCADE ON UPDATE CASCADE;
