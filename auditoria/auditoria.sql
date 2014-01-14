
--create language plpgsql;
DROP TABLE IF EXISTS  aud_clasificado;
CREATE TABLE aud_clasificado (
    id bigserial NOT NULL,
    id_tipo integer NOT NULL,
    id_subtipo1 integer,
    id_subtipo2 integer,
    id_subtipo4 integer,
    id_subtipo5 integer,
    clasificado text NOT NULL,
    fecha_ini date,
    fecha_fin date,
    precio numeric(10,2),
    id_subtipo3 integer,
    id_tipo_publicacion integer,
    num_dias integer,
    num_palabras integer,
    id_pedido bigint NOT NULL,
    id_estado integer,
    valor_oferta numeric(10,2),
    id_subtipo6 integer,
    id_currency_oferta integer,
    id_subtipo_publicacion integer,
    url_img0 character varying(1000),
    fecha_hora timestamp without time zone DEFAULT now() NOT NULL,
    operacion character varying(1500),
    usuario character varying(1500)
);

ALTER TABLE ONLY aud_clasificado
    ADD CONSTRAINT aud_clasificado_pk PRIMARY KEY (id);


DROP TRIGGER IF EXISTS trg_aud_clasificado on clasificado;
create or replace function aud_clasificado_func() returns trigger as $$
	begin
		IF TG_OP = 'DELETE' THEN
			INSERT INTO aud_clasificado (id_tipo, id_subtipo1, id_subtipo2, id_subtipo3, id_subtipo4, id_subtipo5, clasificado, fecha_ini, fecha_fin, precio, id_tipo_publicacion, num_dias, num_palabras, id_pedido, id_estado, valor_oferta, id_subtipo6, id_currency_oferta, id_subtipo_publicacion, url_img0, operacion, usuario)
			VALUES (OLD.id_tipo, OLD.id_subtipo1, OLD.id_subtipo2, OLD.id_subtipo3, OLD.id_subtipo4, OLD.id_subtipo5, OLD.clasificado, OLD.fecha_ini, OLD.fecha_fin, OLD.precio, OLD.id_tipo_publicacion, OLD.num_dias, OLD.num_palabras, OLD.id_pedido, OLD.id_estado, OLD.valor_oferta, OLD.id_subtipo6, OLD.id_currency_oferta, OLD.id_subtipo_publicacion, OLD.url_img0, TG_OP, current_user);
		END IF; 
		IF (TG_OP = 'INSERT' OR  TG_OP = 'UPDATE') THEN
			INSERT INTO aud_clasificado (id_tipo, id_subtipo1, id_subtipo2, id_subtipo3, id_subtipo4, id_subtipo5, clasificado, fecha_ini, fecha_fin, precio, id_tipo_publicacion, num_dias, num_palabras, id_pedido, id_estado, valor_oferta, id_subtipo6, id_currency_oferta, id_subtipo_publicacion, url_img0, operacion, usuario)
			VALUES (NEW.id_tipo, NEW.id_subtipo1, NEW.id_subtipo2, NEW.id_subtipo3, NEW.id_subtipo4, NEW.id_subtipo5, NEW.clasificado, NEW.fecha_ini, NEW.fecha_fin, NEW.precio, NEW.id_tipo_publicacion, NEW.num_dias, NEW.num_palabras, NEW.id_pedido, NEW.id_estado, NEW.valor_oferta, NEW.id_subtipo6, NEW.id_currency_oferta, NEW.id_subtipo_publicacion, NEW.url_img0, TG_OP, current_user);
		END IF;	
	return null;
end; $$ language plpgsql;
CREATE TRIGGER trg_aud_clasificado after INSERT OR UPDATE OR DELETE ON clasificado for each row execute procedure aud_clasificado_func();



DROP TABLE IF EXISTS  aud_pedido;
CREATE TABLE aud_pedido (
    id bigserial NOT NULL,
    usuario character varying(500) NOT NULL,
    cod_pago character varying(25),
    valor_total numeric(10,2) NOT NULL,
    id_estado integer NOT NULL,
    cod_confirmacion character varying(25),
    id_entidad_pago integer,
    fecha_hora_pago timestamp without time zone,
    dni_cliente character varying(20),
    nombre_cliente character varying(255),
    fecha_vencimiento date,
    tipo_pedido character varying(50),
    fecha_hora timestamp without time zone DEFAULT now() NOT NULL,
    operacion character varying(1500),
    usuario_aud character varying(1500)
);

ALTER TABLE ONLY aud_pedido
    ADD CONSTRAINT aud_pedido_pk PRIMARY KEY (id);

DROP TRIGGER IF EXISTS trg_aud_pedido on pedido;
create or replace function aud_pedido_func() returns trigger as $$
	begin
		IF TG_OP = 'DELETE' THEN
			INSERT INTO aud_pedido (usuario, cod_pago, valor_total, id_estado, cod_confirmacion, id_entidad_pago, fecha_hora_pago, dni_cliente, nombre_cliente, fecha_vencimiento, tipo_pedido, operacion, usuario_aud)
			VALUES (OLD.usuario, OLD.cod_pago, OLD.valor_total, OLD.id_estado, OLD.cod_confirmacion, OLD.id_entidad_pago, OLD.fecha_hora_pago, OLD.dni_cliente, OLD.nombre_cliente, OLD.fecha_vencimiento, OLD.tipo_pedido, TG_OP, current_user);
		END IF; 
		IF (TG_OP = 'INSERT' OR  TG_OP = 'UPDATE') THEN
			INSERT INTO aud_pedido (usuario, cod_pago, valor_total, id_estado, cod_confirmacion, id_entidad_pago, fecha_hora_pago, dni_cliente, nombre_cliente, fecha_vencimiento, tipo_pedido, operacion, usuario_aud)
			VALUES (NEW.usuario, NEW.cod_pago, NEW.valor_total, NEW.id_estado, NEW.cod_confirmacion,  NEW.id_entidad_pago, NEW.fecha_hora_pago, NEW.dni_cliente, NEW.nombre_cliente, NEW.fecha_vencimiento, NEW.tipo_pedido, TG_OP, current_user);
		END IF;	
	return null;
end; $$ language plpgsql;
CREATE TRIGGER trg_aud_pedido after INSERT OR UPDATE OR DELETE ON pedido for each row execute procedure aud_pedido_func();


