
CREATE TABLE aud_clasificado (
	id bigserial NOT NULL,
	id_tipo int4 NOT NULL,
	id_subtipo1 int4,
	id_subtipo2 int4,
	id_subtipo4 int4,
	id_subtipo5 int4,
	clasificado text NOT NULL,
	usuario varchar(500) NOT NULL,
	fecha_ini_impreso date,
	fecha_fin_impreso date,
	fecha_ini_web date,
	fecha_fin_web date,
	precio numeric(10, 2),
	id_estado int4 NOT NULL,
	cod_pago varchar(25),
	precio_impresion numeric(10, 2),
	precio_web numeric(10, 2),
	id_subtipo3 int4
);
ALTER TABLE aud_clasificado ADD CONSTRAINT clasificado_pk_CLONE PRIMARY KEY(id);
ALTER TABLE aud_clasificado ADD usuario_bd varchar(1500) NOT NULL;
ALTER TABLE aud_clasificado ADD fecha_hora timestamp NOT NULL;
ALTER TABLE aud_clasificado ADD operacion varchar(1500) NOT NULL;


ALTER TABLE users ADD nro_usuario varchar(25) NOT NULL;
