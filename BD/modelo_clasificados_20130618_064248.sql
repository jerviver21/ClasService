ALTER TABLE precios_clasificados ADD id_tipo_precio int4 NOT NULL;
CREATE TABLE tipo_precio (
	id serial NOT NULL,
	descripcion varchar(250) NOT NULL
);
ALTER TABLE tipo_precio ADD CONSTRAINT tipo_precio_pk PRIMARY KEY(id);
ALTER TABLE precios_clasificados ADD CONSTRAINT precio_tipo_fk FOREIGN KEY (id_tipo_precio) REFERENCES tipo_precio(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
