CREATE TABLE estados_clasificado (
	id int4 NOT NULL,
	nombre varchar(25) NOT NULL
);
ALTER TABLE estados_clasificado ADD CONSTRAINT estados_clasificado_pk PRIMARY KEY(id);
ALTER TABLE clasificado ADD id_estado int4;
ALTER TABLE clasificado ADD CONSTRAINT estado_clasificado_fk FOREIGN KEY (id_estado) REFERENCES estados_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
