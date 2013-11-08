ALTER TABLE tipo_publicacion ADD precio int4 DEFAULT 0;
ALTER TABLE tipo_publicacion ADD duracion int4 DEFAULT 8;
CREATE TABLE ruta_imagenes (
	id bigserial NOT NULL,
	ruta varchar(1000) NOT NULL
);
ALTER TABLE ruta_imagenes ADD CONSTRAINT ruta_imagenes_pk PRIMARY KEY(id);
ALTER TABLE clasificado DROP COLUMN ruta_imagenes;
ALTER TABLE clasificado ADD id_ruta_imagenes bigint;
