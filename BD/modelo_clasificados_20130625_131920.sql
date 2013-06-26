CREATE TABLE entidades_pago (
	id int4 NOT NULL,
	nombre varchar(255) NOT NULL,
	num_cuenta_recaudo varchar(500),
	clave varchar(500),
	direccion_ip varchar(500),
	nombre_usuario varchar(500)
);
ALTER TABLE entidades_pago ADD CONSTRAINT entidades_pago_pk PRIMARY KEY(id);
ALTER TABLE pedido ADD id_entidad_pago int4;
ALTER TABLE pedido ADD CONSTRAINT entidad_pago_fk FOREIGN KEY (id_entidad_pago) REFERENCES entidades_pago(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
