CREATE TABLE img_clasificado (
	id bigserial NOT NULL,
	ruta_imagenes varchar(10) NOT NULL
);
ALTER TABLE img_clasificado ADD CONSTRAINT img_clasificado_pk PRIMARY KEY(id);
ALTER TABLE clasificado RENAME COLUMN ruta_imagen TO id_imagenes;
ALTER TABLE clasificado DROP COLUMN id_imagenes;
ALTER TABLE clasificado ADD COLUMN id_imagenes TYPE bigint;
ALTER TABLE clasificado ADD CONSTRAINT imagen_clasificado_pk FOREIGN KEY (id_imagenes) REFERENCES img_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
