CREATE TABLE campos_tipo (
	id bigserial NOT NULL,
	id_tipoclasificado int4 NOT NULL,
	subtipo1 boolean NOT NULL DEFAULT false,
	subtipo2 boolean NOT NULL DEFAULT false,
	subtipo3 boolean NOT NULL DEFAULT false,
	subtipo4 boolean NOT NULL DEFAULT false,
	subtipo5 boolean NOT NULL DEFAULT false,
	precio boolean NOT NULL,
	area boolean NOT NULL
);
ALTER TABLE campos_tipo ADD CONSTRAINT campos_tipo_pk PRIMARY KEY(id);
CREATE TABLE aud_campos_tipo (
	id bigserial NOT NULL,
	id_tipoclasificado int4 NOT NULL,
	subtipo1 boolean NOT NULL DEFAULT false,
	subtipo2 boolean NOT NULL DEFAULT false,
	subtipo3 boolean NOT NULL DEFAULT false,
	subtipo4 boolean NOT NULL DEFAULT false,
	subtipo5 boolean NOT NULL DEFAULT false,
	precio boolean NOT NULL,
	area boolean NOT NULL,
	usuario_bd varchar(1500) NOT NULL,
	fecha_hora timestamp NOT NULL DEFAULT now(),
	operacion varchar(1500) NOT NULL
);
ALTER TABLE aud_campos_tipo ADD CONSTRAINT campos_tipo_pk_CLONE PRIMARY KEY(id);
ALTER TABLE campos_tipo ADD CONSTRAINT campos_subtipo_fk FOREIGN KEY (id_tipoclasificado) REFERENCES tipo_clasificado(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE clasificado ADD id_tipo_impresion int4;
CREATE TABLE tipo_impresion (
	id serial NOT NULL,
	nombre varchar(255) NOT NULL,
	precio numeric(10, 2) NOT NULL
);
ALTER TABLE tipo_impresion ADD CONSTRAINT tipo_impresion_pk PRIMARY KEY(id);
ALTER TABLE clasificado ADD CONSTRAINT clasificado_tipoimp_fk FOREIGN KEY (id_tipo_impresion) REFERENCES tipo_impresion(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE tipo_impresion RENAME TO tipo_publicacion;
ALTER TABLE tipo_publicacion DROP COLUMN precio;
ALTER TABLE tipo_publicacion DROP CONSTRAINT tipo_impresion_pk;
ALTER TABLE tipo_publicacion ADD CONSTRAINT tipo_publicacion_pk PRIMARY KEY(id);
ALTER TABLE clasificado DROP COLUMN fecha_fin_web;
ALTER TABLE clasificado DROP COLUMN fecha_ini_web;
ALTER TABLE clasificado RENAME COLUMN fecha_ini_impreso TO fecha_ini;
ALTER TABLE clasificado RENAME COLUMN fecha_fin_impreso TO fecha_fin;
ALTER TABLE clasificado RENAME COLUMN id_tipo_impresion TO id_tipo_publicacion;
DROP TABLE aud_clasificado;
CREATE TABLE precios_clasificados (
	id serial NOT NULL,
	id_tipo_publicacion int4 NOT NULL,
	iddia int4 NOT NULL,
	nombre_dia varchar(250) NOT NULL,
	precio numeric(10, 2) NOT NULL
);
ALTER TABLE precios_clasificados ADD CONSTRAINT precios_clasificados_pk PRIMARY KEY(id);
ALTER TABLE precios_clasificados ADD CONSTRAINT precios_tipos_fk FOREIGN KEY (id_tipo_publicacion) REFERENCES tipo_publicacion(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE clasificado DROP COLUMN publicarimpreso;
ALTER TABLE clasificado DROP COLUMN publicarweb;
ALTER TABLE clasificado DROP COLUMN precio_web;
ALTER TABLE clasificado DROP COLUMN precio_impresion;
