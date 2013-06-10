CREATE TABLE clasificado (
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
ALTER TABLE clasificado ADD CONSTRAINT clasificado_pk PRIMARY KEY(id);
CREATE TABLE tipo_clasificado (
	id serial NOT NULL,
	id_padre int4,
	dato varchar(500) NOT NULL
);
ALTER TABLE tipo_clasificado ADD CONSTRAINT tipo_clasificado_pk PRIMARY KEY(id);
ALTER TABLE tipo_clasificado ADD CONSTRAINT tipo_padre_fk FOREIGN KEY (id_padre) REFERENCES tipo_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE clasificado ADD CONSTRAINT tipo_principal_fk FOREIGN KEY (id_tipo) REFERENCES tipo_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE clasificado ADD CONSTRAINT subtipo1_fk FOREIGN KEY (id_subtipo1) REFERENCES tipo_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE clasificado ADD CONSTRAINT subtipo2_fk FOREIGN KEY (id_subtipo2) REFERENCES tipo_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE clasificado ADD CONSTRAINT subtipo3_fk FOREIGN KEY (id_subtipo3) REFERENCES tipo_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE clasificado ADD CONSTRAINT subtipo4_fk FOREIGN KEY (id_subtipo4) REFERENCES tipo_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE clasificado ADD CONSTRAINT subtipo5_fk FOREIGN KEY (id_subtipo5) REFERENCES tipo_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
