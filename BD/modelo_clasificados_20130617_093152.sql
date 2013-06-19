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
