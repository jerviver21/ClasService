ALTER TABLE ruta_imagenes DROP COLUMN ruta;
ALTER TABLE clasificado DROP CONSTRAINT ruta_clas_fk;
ALTER TABLE clasificado DROP COLUMN id_ruta_imagenes;
DROP TABLE ruta_imagenes;
CREATE TABLE img_clasificado (
	id bigserial NOT NULL,
	url varchar(1000),
	extension varchar(25),
	id_clasificado bigint NOT NULL
);
ALTER TABLE img_clasificado ADD CONSTRAINT img_clasificado_pk PRIMARY KEY(id);
