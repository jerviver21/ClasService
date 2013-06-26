CREATE TABLE pedido (
	id bigserial NOT NULL,
	usuario varchar(500) NOT NULL,
	cod_pago varchar(25),
	valor_total numeric(10, 2) NOT NULL,
	fecha_vencimiento date NOT NULL,
	id_estado int4 NOT NULL,
	fecha_hora_pago date,
	cod_confirmacion varchar(25)
);
ALTER TABLE pedido ADD CONSTRAINT pedido_pk PRIMARY KEY(id);
ALTER TABLE clasificado DROP COLUMN cod_pago;
ALTER TABLE clasificado DROP COLUMN id_estado;
CREATE TABLE estados_pedido (
	id int4 NOT NULL,
	nombre varchar(25) NOT NULL
);
ALTER TABLE estados_pedido ADD CONSTRAINT estados_pedido_pk PRIMARY KEY(id);
ALTER TABLE clasificado ADD id_pedido bigint NOT NULL;
ALTER TABLE clasificado DROP COLUMN usuario;
ALTER TABLE clasificado ADD CONSTRAINT pedido_clasificado_fk FOREIGN KEY (id_pedido) REFERENCES pedido(id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE pedido ADD CONSTRAINT pedido_estado_fk FOREIGN KEY (id_estado) REFERENCES estados_pedido(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
CREATE TABLE estados_clasificado (
	id int4 NOT NULL,
	nombre varchar(25) NOT NULL
);
ALTER TABLE estados_clasificado ADD CONSTRAINT estados_clasificado_pk PRIMARY KEY(id);
ALTER TABLE clasificado ADD id_estado int4;
ALTER TABLE clasificado ADD CONSTRAINT estado_clasificado_fk FOREIGN KEY (id_estado) REFERENCES estados_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
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
ALTER TABLE entidades_pago ADD mensaje_pago varchar(2000);
