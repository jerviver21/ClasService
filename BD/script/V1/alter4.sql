ALTER TABLE precios_clasificados ADD id_tipo_precio int4 NOT NULL;
CREATE TABLE tipo_precio (
	id serial NOT NULL,
	descripcion varchar(250) NOT NULL
);
ALTER TABLE tipo_precio ADD CONSTRAINT tipo_precio_pk PRIMARY KEY(id);
ALTER TABLE precios_clasificados ADD CONSTRAINT precio_tipo_fk FOREIGN KEY (id_tipo_precio) REFERENCES tipo_precio(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE clasificado ALTER precio TYPE numeric(10, 2);
ALTER TABLE clasificado ADD num_dias int4;
ALTER TABLE clasificado ADD num_palabras int4;
ALTER TABLE tipo_precio ADD precio numeric(10, 2);
ALTER TABLE precios_clasificados DROP COLUMN precio;
ALTER TABLE precios_clasificados ADD procesar_x_palabra boolean NOT NULL DEFAULT true;
ALTER TABLE tipo_precio RENAME TO precios;
ALTER TABLE precios_clasificados RENAME TO dias_precios;
CREATE TABLE festivos (
	fecha date NOT NULL
);
ALTER TABLE festivos ADD CONSTRAINT festivos_pk PRIMARY KEY(fecha);
ALTER TABLE dias_precios RENAME COLUMN id_tipo_precio TO id_precio;
ALTER TABLE precios ADD procesar_x_palabra boolean;
ALTER TABLE dias_precios DROP COLUMN procesar_x_palabra;
ALTER TABLE clasificado ADD salario_oferta numeric(10, 2);
ALTER TABLE campos_tipo ADD salario boolean NOT NULL DEFAULT false;
