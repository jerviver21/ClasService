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
ALTER TABLE img_clasificado ADD CONSTRAINT img_clasificado_pk FOREIGN KEY (id_clasificado) REFERENCES img_clasificado(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE img_clasificado DROP CONSTRAINT img_clasificado_pk;
ALTER TABLE img_clasificado DROP COLUMN id_clasificado;
ALTER TABLE img_clasificado ADD id_clasificado bigint NOT NULL;
