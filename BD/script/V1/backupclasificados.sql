--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: aud_clasificado_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION aud_clasificado_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		IF TG_OP = 'DELETE' THEN
			INSERT INTO aud_clasificado (id_tipo, id_subtipo1, id_subtipo2, id_subtipo3, id_subtipo4, id_subtipo5, clasificado, fecha_ini, fecha_fin, precio, num_dias, num_palabras, id_pedido, id_estado, valor_oferta, id_subtipo6, id_currency_oferta, id_subtipo_publicacion, url_img0, operacion, usuario)
			VALUES (OLD.id_tipo, OLD.id_subtipo1, OLD.id_subtipo2, OLD.id_subtipo3, OLD.id_subtipo4, OLD.id_subtipo5, OLD.clasificado, OLD.fecha_ini, OLD.fecha_fin, OLD.precio, OLD.num_dias, OLD.num_palabras, OLD.id_pedido, OLD.id_estado, OLD.valor_oferta, OLD.id_subtipo6, OLD.id_currency_oferta, OLD.id_subtipo_publicacion, OLD.url_img0, TG_OP, current_user);
		END IF; 
		IF (TG_OP = 'INSERT' OR  TG_OP = 'UPDATE') THEN
			INSERT INTO aud_clasificado (id_tipo, id_subtipo1, id_subtipo2, id_subtipo3, id_subtipo4, id_subtipo5, clasificado, fecha_ini, fecha_fin, precio, num_dias, num_palabras, id_pedido, id_estado, valor_oferta, id_subtipo6, id_currency_oferta, id_subtipo_publicacion, url_img0, operacion, usuario)
			VALUES (NEW.id_tipo, NEW.id_subtipo1, NEW.id_subtipo2, NEW.id_subtipo3, NEW.id_subtipo4, NEW.id_subtipo5, NEW.clasificado, NEW.fecha_ini, NEW.fecha_fin, NEW.precio, NEW.num_dias, NEW.num_palabras, NEW.id_pedido, NEW.id_estado, NEW.valor_oferta, NEW.id_subtipo6, NEW.id_currency_oferta, NEW.id_subtipo_publicacion, NEW.url_img0, TG_OP, current_user);
		END IF;	
	return null;
end; $$;


ALTER FUNCTION public.aud_clasificado_func() OWNER TO postgres;

--
-- Name: aud_pedido_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION aud_pedido_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
end; $$;


ALTER FUNCTION public.aud_pedido_func() OWNER TO postgres;

--
-- Name: aud_users_func(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION aud_users_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	begin
		IF TG_OP = 'DELETE' THEN
			INSERT INTO aud_users (usr, pwd, nombre, mail, estado, operacion, usuario)
			VALUES (OLD.usr, OLD.pwd, OLD.nombre, OLD.mail, OLD.estado, TG_OP, current_user);
		END IF; 
		IF (TG_OP = 'INSERT' OR  TG_OP = 'UPDATE') THEN
			INSERT INTO aud_users (usr, pwd, nombre, mail, estado, operacion, usuario)
			VALUES (NEW.usr, NEW.pwd, NEW.nombre, NEW.mail, NEW.estado, TG_OP, current_user);
		END IF;	
	return null;
end; $$;


ALTER FUNCTION public.aud_users_func() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: archivo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE archivo (
    nombre character varying(100) NOT NULL,
    nombre_archivo character varying(2000) NOT NULL,
    nombre_jasper character varying(1000) NOT NULL,
    id_tipo_archivo integer NOT NULL,
    id_reporte integer
);


ALTER TABLE public.archivo OWNER TO postgres;

--
-- Name: aud_campos_tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE aud_campos_tipo (
    id bigint NOT NULL,
    id_tipoclasificado integer NOT NULL,
    subtipo1 boolean DEFAULT false NOT NULL,
    subtipo2 boolean DEFAULT false NOT NULL,
    subtipo3 boolean DEFAULT false NOT NULL,
    subtipo4 boolean DEFAULT false NOT NULL,
    subtipo5 boolean DEFAULT false NOT NULL,
    precio boolean NOT NULL,
    area boolean NOT NULL,
    usuario_bd character varying(1500) NOT NULL,
    fecha_hora timestamp without time zone DEFAULT now() NOT NULL,
    operacion character varying(1500) NOT NULL
);


ALTER TABLE public.aud_campos_tipo OWNER TO postgres;

--
-- Name: aud_campos_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE aud_campos_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aud_campos_tipo_id_seq OWNER TO postgres;

--
-- Name: aud_campos_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE aud_campos_tipo_id_seq OWNED BY aud_campos_tipo.id;


--
-- Name: aud_clasificado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE aud_clasificado (
    id bigint NOT NULL,
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


ALTER TABLE public.aud_clasificado OWNER TO postgres;

--
-- Name: aud_clasificado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE aud_clasificado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aud_clasificado_id_seq OWNER TO postgres;

--
-- Name: aud_clasificado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE aud_clasificado_id_seq OWNED BY aud_clasificado.id;


--
-- Name: aud_mail; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE aud_mail (
    id bigint NOT NULL,
    destinatario character varying(1000) NOT NULL,
    asunto character varying(1000) NOT NULL,
    mensaje text NOT NULL,
    fecha_hora timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.aud_mail OWNER TO postgres;

--
-- Name: aud_mail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE aud_mail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aud_mail_id_seq OWNER TO postgres;

--
-- Name: aud_mail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE aud_mail_id_seq OWNED BY aud_mail.id;


--
-- Name: aud_pedido; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE aud_pedido (
    id bigint NOT NULL,
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


ALTER TABLE public.aud_pedido OWNER TO postgres;

--
-- Name: aud_pedido_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE aud_pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aud_pedido_id_seq OWNER TO postgres;

--
-- Name: aud_pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE aud_pedido_id_seq OWNED BY aud_pedido.id;


--
-- Name: aud_sesion; Type: TABLE; Schema: public; Owner: jbossuser; Tablespace: 
--

CREATE TABLE aud_sesion (
    id bigint NOT NULL,
    usr character varying(300) NOT NULL,
    operacion character varying(10) NOT NULL,
    fecha_hora timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.aud_sesion OWNER TO jbossuser;

--
-- Name: aud_sesion_id_seq; Type: SEQUENCE; Schema: public; Owner: jbossuser
--

CREATE SEQUENCE aud_sesion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aud_sesion_id_seq OWNER TO jbossuser;

--
-- Name: aud_sesion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jbossuser
--

ALTER SEQUENCE aud_sesion_id_seq OWNED BY aud_sesion.id;


--
-- Name: aud_users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE aud_users (
    id bigint NOT NULL,
    usr character varying(300),
    pwd character varying(250),
    nombre character varying(1500),
    mail character varying(1500),
    estado integer,
    fecha_hora timestamp without time zone DEFAULT now() NOT NULL,
    operacion character varying(1500),
    usuario character varying(1500)
);


ALTER TABLE public.aud_users OWNER TO postgres;

--
-- Name: aud_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE aud_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.aud_users_id_seq OWNER TO postgres;

--
-- Name: aud_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE aud_users_id_seq OWNED BY aud_users.id;


--
-- Name: campos_formulario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE campos_formulario (
    id integer NOT NULL,
    id_formulario integer NOT NULL
);


ALTER TABLE public.campos_formulario OWNER TO postgres;

--
-- Name: campos_formulario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE campos_formulario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campos_formulario_id_seq OWNER TO postgres;

--
-- Name: campos_formulario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE campos_formulario_id_seq OWNED BY campos_formulario.id;


--
-- Name: campos_tipo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE campos_tipo (
    id bigint NOT NULL,
    id_tipoclasificado integer NOT NULL,
    subtipo1 boolean DEFAULT false NOT NULL,
    subtipo2 boolean DEFAULT false NOT NULL,
    subtipo3 boolean DEFAULT false NOT NULL,
    subtipo4 boolean DEFAULT false NOT NULL,
    subtipo5 boolean DEFAULT false NOT NULL,
    valor boolean NOT NULL,
    nombre_ofertante boolean DEFAULT false NOT NULL,
    titulo_oferta boolean DEFAULT false NOT NULL
);


ALTER TABLE public.campos_tipo OWNER TO postgres;

--
-- Name: campos_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE campos_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campos_tipo_id_seq OWNER TO postgres;

--
-- Name: campos_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE campos_tipo_id_seq OWNED BY campos_tipo.id;


--
-- Name: campos_validacion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE campos_validacion (
    id integer NOT NULL,
    id_campo integer,
    id_validacion integer
);


ALTER TABLE public.campos_validacion OWNER TO postgres;

--
-- Name: campos_validacion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE campos_validacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.campos_validacion_id_seq OWNER TO postgres;

--
-- Name: campos_validacion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE campos_validacion_id_seq OWNED BY campos_validacion.id;


--
-- Name: clasificado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clasificado (
    id bigint NOT NULL,
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
    id_subtipo_publicacion integer,
    num_dias integer,
    num_palabras integer,
    id_pedido bigint NOT NULL,
    id_estado integer,
    valor_oferta numeric(10,2),
    id_subtipo6 integer,
    id_currency_oferta integer,
    url_img0 character varying(1000),
    nombre_ofertante character varying(1000),
    titulo_oferta character varying(1000)
);


ALTER TABLE public.clasificado OWNER TO postgres;

--
-- Name: clasificado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE clasificado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clasificado_id_seq OWNER TO postgres;

--
-- Name: clasificado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE clasificado_id_seq OWNED BY clasificado.id;


--
-- Name: currencies; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE currencies (
    id integer NOT NULL,
    nombre character varying(25) NOT NULL,
    cambio numeric(10,2) NOT NULL,
    simbolo character varying(10)
);


ALTER TABLE public.currencies OWNER TO postgres;

--
-- Name: data; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE data (
    nombre character varying(100) NOT NULL,
    descripcion character varying(1000),
    id integer NOT NULL
);


ALTER TABLE public.data OWNER TO postgres;

--
-- Name: dias_precios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dias_precios (
    id integer NOT NULL,
    id_subtipo_publicacion integer NOT NULL,
    iddia integer NOT NULL,
    nombre_dia character varying(250) NOT NULL,
    id_precio integer NOT NULL
);


ALTER TABLE public.dias_precios OWNER TO postgres;

--
-- Name: entidades_pago; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE entidades_pago (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    num_cuenta_recaudo character varying(500),
    clave character varying(500),
    direccion_ip character varying(500),
    nombre_usuario character varying(500),
    mensaje_pago character varying(2000)
);


ALTER TABLE public.entidades_pago OWNER TO postgres;

--
-- Name: estados_clasificado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estados_clasificado (
    id integer NOT NULL,
    nombre character varying(25) NOT NULL
);


ALTER TABLE public.estados_clasificado OWNER TO postgres;

--
-- Name: estados_pedido; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE estados_pedido (
    id integer NOT NULL,
    nombre character varying(25) NOT NULL
);


ALTER TABLE public.estados_pedido OWNER TO postgres;

--
-- Name: festivos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE festivos (
    fecha date NOT NULL
);


ALTER TABLE public.festivos OWNER TO postgres;

--
-- Name: formulario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE formulario (
    id integer NOT NULL,
    nombre character varying(250) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.formulario OWNER TO postgres;

--
-- Name: formulario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE formulario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.formulario_id_seq OWNER TO postgres;

--
-- Name: formulario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE formulario_id_seq OWNED BY formulario.id;


--
-- Name: group_rol; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE group_rol (
    id integer NOT NULL,
    id_rol bigint NOT NULL,
    id_group bigint NOT NULL
);


ALTER TABLE public.group_rol OWNER TO postgres;

--
-- Name: group_rol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE group_rol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_rol_id_seq OWNER TO postgres;

--
-- Name: group_rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE group_rol_id_seq OWNED BY group_rol.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE groups (
    id bigint NOT NULL,
    codigo character varying(100) NOT NULL,
    descripcion character varying(300)
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.groups_id_seq OWNER TO postgres;

--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: idiomas; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE idiomas (
    id character varying(2) NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.idiomas OWNER TO postgres;

--
-- Name: imagenes_publicidad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE imagenes_publicidad (
    id bigint NOT NULL,
    url_fuente character varying(1000) NOT NULL,
    nombre_cliente character varying(1000) NOT NULL,
    nid character varying(50) NOT NULL,
    telefono character varying(50),
    url_aterrizaje character varying(1000),
    id_tipo_fuente integer
);


ALTER TABLE public.imagenes_publicidad OWNER TO postgres;

--
-- Name: imagenes_publicidad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE imagenes_publicidad_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.imagenes_publicidad_id_seq OWNER TO postgres;

--
-- Name: imagenes_publicidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE imagenes_publicidad_id_seq OWNED BY imagenes_publicidad.id;


--
-- Name: img_clasificado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE img_clasificado (
    id bigint NOT NULL,
    url character varying(1000),
    extension character varying(25),
    id_clasificado bigint NOT NULL
);


ALTER TABLE public.img_clasificado OWNER TO postgres;

--
-- Name: img_clasificado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE img_clasificado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.img_clasificado_id_seq OWNER TO postgres;

--
-- Name: img_clasificado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE img_clasificado_id_seq OWNED BY img_clasificado.id;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE menu (
    id bigint NOT NULL,
    nombre character varying(2000) NOT NULL,
    id_menu bigint,
    idioma character varying(2),
    descripcion character varying(2000)
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.menu_id_seq OWNER TO postgres;

--
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE menu_id_seq OWNED BY menu.id;


--
-- Name: parametro; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE parametro (
    id bigint NOT NULL,
    nombre character varying(50) NOT NULL,
    valor text NOT NULL,
    tipo character varying(20)
);


ALTER TABLE public.parametro OWNER TO postgres;

--
-- Name: parametro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE parametro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parametro_id_seq OWNER TO postgres;

--
-- Name: parametro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE parametro_id_seq OWNED BY parametro.id;


--
-- Name: parametros_reporte; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE parametros_reporte (
    nombre character varying(100) NOT NULL,
    etiqueta character varying(1000) NOT NULL,
    id_tipo integer NOT NULL,
    id integer NOT NULL,
    id_data integer,
    id_reporte integer
);


ALTER TABLE public.parametros_reporte OWNER TO postgres;

--
-- Name: pedido; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pedido (
    id bigint NOT NULL,
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
    tipo_pedido character varying(50)
);


ALTER TABLE public.pedido OWNER TO postgres;

--
-- Name: pedido_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pedido_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pedido_id_seq OWNER TO postgres;

--
-- Name: pedido_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pedido_id_seq OWNED BY pedido.id;


--
-- Name: precios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE precios (
    id integer NOT NULL,
    descripcion character varying(250) NOT NULL,
    precio numeric(10,2),
    procesar_x_palabra boolean
);


ALTER TABLE public.precios OWNER TO postgres;

--
-- Name: precios_clasificados_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE precios_clasificados_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.precios_clasificados_id_seq OWNER TO postgres;

--
-- Name: precios_clasificados_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE precios_clasificados_id_seq OWNED BY dias_precios.id;


--
-- Name: publicidad; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE publicidad (
    id bigint NOT NULL,
    fecha_ini date NOT NULL,
    id_imagen bigint NOT NULL,
    seccion_page character varying(10),
    num_clicks bigint DEFAULT 0 NOT NULL,
    fecha_fin date,
    num_impresiones bigint DEFAULT 0 NOT NULL,
    heigh integer,
    width integer
);


ALTER TABLE public.publicidad OWNER TO postgres;

--
-- Name: publicidad_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE publicidad_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publicidad_id_seq OWNER TO postgres;

--
-- Name: publicidad_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE publicidad_id_seq OWNED BY publicidad.id;


--
-- Name: reporte; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reporte (
    nombre character varying(100) NOT NULL,
    roles text DEFAULT 'ALL'::text NOT NULL,
    id_proceso integer,
    id integer NOT NULL
);


ALTER TABLE public.reporte OWNER TO postgres;

--
-- Name: resource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE resource (
    id bigint NOT NULL,
    nombre character varying(2000) NOT NULL,
    descripcion character varying(300),
    id_menu bigint NOT NULL,
    url character varying(500) NOT NULL,
    idioma character varying(2)
);


ALTER TABLE public.resource OWNER TO postgres;

--
-- Name: resource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE resource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.resource_id_seq OWNER TO postgres;

--
-- Name: resource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE resource_id_seq OWNED BY resource.id;


--
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rol (
    id bigint NOT NULL,
    codigo character varying(100) NOT NULL,
    descripcion character varying(2000)
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- Name: rol_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rol_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rol_id_seq OWNER TO postgres;

--
-- Name: rol_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rol_id_seq OWNED BY rol.id;


--
-- Name: rol_resource; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rol_resource (
    id bigint NOT NULL,
    id_resource bigint NOT NULL,
    id_rol bigint
);


ALTER TABLE public.rol_resource OWNER TO postgres;

--
-- Name: rol_resource_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rol_resource_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rol_resource_id_seq OWNER TO postgres;

--
-- Name: rol_resource_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rol_resource_id_seq OWNED BY rol_resource.id;


--
-- Name: subtipo_publicacion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE subtipo_publicacion (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    precio integer DEFAULT 0,
    duracion integer DEFAULT 8,
    prioridad integer DEFAULT 100,
    id_tipo_publicacion integer
);


ALTER TABLE public.subtipo_publicacion OWNER TO postgres;

--
-- Name: tipo_archivo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_archivo (
    id integer NOT NULL,
    tipo character varying(100)
);


ALTER TABLE public.tipo_archivo OWNER TO postgres;

--
-- Name: tipo_clasificado; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_clasificado (
    id integer NOT NULL,
    id_padre integer,
    dato character varying(500) NOT NULL,
    subtipo integer,
    nombre character varying(25)
);


ALTER TABLE public.tipo_clasificado OWNER TO postgres;

--
-- Name: tipo_clasificado_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_clasificado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_clasificado_id_seq OWNER TO postgres;

--
-- Name: tipo_clasificado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_clasificado_id_seq OWNED BY tipo_clasificado.id;


--
-- Name: tipo_fuente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_fuente (
    id integer NOT NULL,
    nombre character varying(25) NOT NULL
);


ALTER TABLE public.tipo_fuente OWNER TO postgres;

--
-- Name: tipo_id; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_id (
    id integer NOT NULL,
    codigo character varying(100)
);


ALTER TABLE public.tipo_id OWNER TO postgres;

--
-- Name: tipo_impresion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_impresion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_impresion_id_seq OWNER TO postgres;

--
-- Name: tipo_impresion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_impresion_id_seq OWNED BY subtipo_publicacion.id;


--
-- Name: tipo_parametro_reporte; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_parametro_reporte (
    tipo character varying(100) NOT NULL,
    id integer NOT NULL,
    descripcion character varying(1000)
);


ALTER TABLE public.tipo_parametro_reporte OWNER TO postgres;

--
-- Name: tipo_precio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tipo_precio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_precio_id_seq OWNER TO postgres;

--
-- Name: tipo_precio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tipo_precio_id_seq OWNED BY precios.id;


--
-- Name: tipo_proceso_reporte; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_proceso_reporte (
    id integer NOT NULL,
    nombre character varying(1000)
);


ALTER TABLE public.tipo_proceso_reporte OWNER TO postgres;

--
-- Name: tipo_publicacion; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_publicacion (
    id integer NOT NULL,
    nombre character varying(255)
);


ALTER TABLE public.tipo_publicacion OWNER TO postgres;

--
-- Name: user_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE user_group (
    id integer NOT NULL,
    id_user bigint NOT NULL,
    id_group bigint NOT NULL
);


ALTER TABLE public.user_group OWNER TO postgres;

--
-- Name: user_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_group_id_seq OWNER TO postgres;

--
-- Name: user_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_group_id_seq OWNED BY user_group.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE users (
    id bigint NOT NULL,
    usr character varying(300) NOT NULL,
    pwd character varying(250) NOT NULL,
    nombre character varying(1500),
    mail character varying(1500),
    estado integer NOT NULL,
    cod_restauracion character varying(255),
    clave character varying(255),
    nro_usuario character varying(25),
    num_id character varying(25)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: validaciones_formulario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE validaciones_formulario (
    id integer NOT NULL,
    id_campo_formulario integer NOT NULL
);


ALTER TABLE public.validaciones_formulario OWNER TO postgres;

--
-- Name: validaciones_formulario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE validaciones_formulario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.validaciones_formulario_id_seq OWNER TO postgres;

--
-- Name: validaciones_formulario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE validaciones_formulario_id_seq OWNED BY validaciones_formulario.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aud_campos_tipo ALTER COLUMN id SET DEFAULT nextval('aud_campos_tipo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aud_clasificado ALTER COLUMN id SET DEFAULT nextval('aud_clasificado_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aud_mail ALTER COLUMN id SET DEFAULT nextval('aud_mail_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aud_pedido ALTER COLUMN id SET DEFAULT nextval('aud_pedido_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: jbossuser
--

ALTER TABLE ONLY aud_sesion ALTER COLUMN id SET DEFAULT nextval('aud_sesion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY aud_users ALTER COLUMN id SET DEFAULT nextval('aud_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campos_formulario ALTER COLUMN id SET DEFAULT nextval('campos_formulario_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campos_tipo ALTER COLUMN id SET DEFAULT nextval('campos_tipo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campos_validacion ALTER COLUMN id SET DEFAULT nextval('campos_validacion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado ALTER COLUMN id SET DEFAULT nextval('clasificado_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dias_precios ALTER COLUMN id SET DEFAULT nextval('precios_clasificados_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY formulario ALTER COLUMN id SET DEFAULT nextval('formulario_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_rol ALTER COLUMN id SET DEFAULT nextval('group_rol_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY imagenes_publicidad ALTER COLUMN id SET DEFAULT nextval('imagenes_publicidad_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY img_clasificado ALTER COLUMN id SET DEFAULT nextval('img_clasificado_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menu ALTER COLUMN id SET DEFAULT nextval('menu_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parametro ALTER COLUMN id SET DEFAULT nextval('parametro_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido ALTER COLUMN id SET DEFAULT nextval('pedido_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY precios ALTER COLUMN id SET DEFAULT nextval('tipo_precio_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY publicidad ALTER COLUMN id SET DEFAULT nextval('publicidad_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resource ALTER COLUMN id SET DEFAULT nextval('resource_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rol ALTER COLUMN id SET DEFAULT nextval('rol_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rol_resource ALTER COLUMN id SET DEFAULT nextval('rol_resource_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subtipo_publicacion ALTER COLUMN id SET DEFAULT nextval('tipo_impresion_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_clasificado ALTER COLUMN id SET DEFAULT nextval('tipo_clasificado_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_group ALTER COLUMN id SET DEFAULT nextval('user_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY validaciones_formulario ALTER COLUMN id SET DEFAULT nextval('validaciones_formulario_id_seq'::regclass);


--
-- Data for Name: archivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY archivo (nombre, nombre_archivo, nombre_jasper, id_tipo_archivo, id_reporte) FROM stdin;
A1	P{fechaIni}.replaceAll("(\\d{4})-(\\d{2})-(\\d{2})", "$1$2$3");P{fechaFin}.replaceAll("(\\d{4})-(\\d{2})-(\\d{2})","$1$2$3");.PDF	rep1.jasper	2	1
clasificadosxdia	clasificadosP{fecha}.pdf	clasificadosxdia.jasper	2	2
\.


--
-- Data for Name: aud_campos_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aud_campos_tipo (id, id_tipoclasificado, subtipo1, subtipo2, subtipo3, subtipo4, subtipo5, precio, area, usuario_bd, fecha_hora, operacion) FROM stdin;
\.


--
-- Name: aud_campos_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('aud_campos_tipo_id_seq', 1, false);


--
-- Data for Name: aud_clasificado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aud_clasificado (id, id_tipo, id_subtipo1, id_subtipo2, id_subtipo4, id_subtipo5, clasificado, fecha_ini, fecha_fin, precio, id_subtipo3, id_tipo_publicacion, num_dias, num_palabras, id_pedido, id_estado, valor_oferta, id_subtipo6, id_currency_oferta, id_subtipo_publicacion, url_img0, fecha_hora, operacion, usuario) FROM stdin;
1	1	5	8	124	120	EDIFICIO RESIDENCIAL SANTA ELISA - POR LOS ANGELES DE CAYMA\r\n\r\nEDIFICIO RESIDENCIAL SANTA ELISA, 18 DEPARTAMENTOS CON LOS MEJORES ACABADOS EN ZONA EXCLUSIVA, EN PRE VENTA.\r\n\r\n\r\n75 M2 - 91,000 US$\r\n\r\n\r\n95 M2 - 115,000 US$\r\n\r\n\r\n119 M2 - 144, 00 US$\r\n\r\n\r\n169 M2 - 191,000 US$\r\n\r\n\r\nDatos de contacto:\r\nLortie Bienes Raices\r\n(054) 799091\r\n	2014-01-16	2014-01-30	15.00	14	\N	0	0	123	1	100000.00	\N	1	5	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 10:12:45.313193	INSERT	postgres
2	1	5	8	124	120	EDIFICIO RESIDENCIAL SANTA ELISA - POR LOS ANGELES DE CAYMA\r\n\r\nEDIFICIO RESIDENCIAL SANTA ELISA, 18 DEPARTAMENTOS CON LOS MEJORES ACABADOS EN ZONA EXCLUSIVA, EN PRE VENTA.\r\n\r\n\r\n75 M2 - 91,000 US$\r\n\r\n\r\n95 M2 - 115,000 US$\r\n\r\n\r\n119 M2 - 144, 00 US$\r\n\r\n\r\n169 M2 - 191,000 US$\r\n\r\n\r\nDatos de contacto:\r\nLortie Bienes Raices\r\n(054) 799091\r\n	2014-01-16	2014-01-30	15.00	14	\N	0	0	123	1	100000.00	\N	1	5	http://s3.amazonaws.com/clasificadosp1/330/IMG0.jpg	2014-01-16 10:12:45.313193	UPDATE	postgres
3	1	5	8	124	120	EDIFICIO RESIDENCIAL SANTA ELISA - POR LOS ANGELES DE CAYMA\r\n\r\nEDIFICIO RESIDENCIAL SANTA ELISA, 18 DEPARTAMENTOS CON LOS MEJORES ACABADOS EN ZONA EXCLUSIVA, EN PRE VENTA.\r\n\r\n\r\n75 M2 - 91,000 US$\r\n\r\n\r\n95 M2 - 115,000 US$\r\n\r\n\r\n119 M2 - 144, 00 US$\r\n\r\n\r\n169 M2 - 191,000 US$\r\n\r\n\r\nDatos de contacto:\r\nLortie Bienes Raices\r\n(054) 799091\r\n	2014-01-16	2014-01-30	15.00	14	\N	0	0	123	2	100000.00	\N	1	5	http://s3.amazonaws.com/clasificadosp1/330/IMG0.jpg	2014-01-16 10:13:23.717148	UPDATE	postgres
4	1	5	8	124	121	Precio 125 mil dolares, muy bien ubicado en Yanahuara. frente al Club internacional, en quinta residencial privada de 110 metros,\r\n\r\nconsta de 3 dormitorios con closet, cocina, comedor con reposteros, sala, comedor, hall y lavanderia, INFORMES: 508701	2014-01-16	2014-02-13	0.00	38	\N	0	0	124	2	125000.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 10:31:33.067912	INSERT	postgres
5	1	5	8	124	121	Precio 125 mil dolares, muy bien ubicado en Yanahuara. frente al Club internacional, en quinta residencial privada de 110 metros,\r\n\r\nconsta de 3 dormitorios con closet, cocina, comedor con reposteros, sala, comedor, hall y lavanderia, INFORMES: 508701	2014-01-16	2014-02-13	0.00	38	\N	0	0	124	2	125000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/331/IMG0.jpg	2014-01-16 10:31:33.067912	UPDATE	postgres
6	1	5	8	124	122	Vendo bonito y amplio departamento 1er piso, en Urb. privada residencial con vigilacia las 24 horas, cuenta con 3 dormitorios,sala, comedor, cocina con reposteros altos y bajos, cochera , patio.\r\n\r\nAT: 145m2\r\n\r\nPRECIO:US$155,000\r\n\r\nINFORMES:250584 - 792967 - 959509654 958958629	2014-01-16	2014-02-13	0.00	38	\N	0	0	125	2	155000.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 10:42:21.066332	INSERT	postgres
7	1	5	8	124	122	Vendo bonito y amplio departamento 1er piso, en Urb. privada residencial con vigilacia las 24 horas, cuenta con 3 dormitorios,sala, comedor, cocina con reposteros altos y bajos, cochera , patio.\r\n\r\nAT: 145m2\r\n\r\nPRECIO:US$155,000\r\n\r\nINFORMES:250584 - 792967 - 959509654 958958629	2014-01-16	2014-02-13	0.00	38	\N	0	0	125	2	155000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/332/IMG0.jpg	2014-01-16 10:42:21.066332	UPDATE	postgres
8	1	5	7	125	122	Departamento amplio y bien iluminado,amplios dormitorios, sala de star, estudio,dormitorio principal con walking closet y baño privado, baño familiar, baño social, cocina con lavandería de diario, área de servicio exclusiva en azotea, cochera techada y deposito:\r\n\r\nPrecio: US$ 170 000 Número de habitaciones: 3 Tamaño: 170 m² Municipalidad: Yanahuara Dirección: Umacollo Tipo: Departamentos, Se vende	2014-01-16	2014-02-13	0.00	38	\N	0	0	126	2	170000.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 11:02:50.453888	INSERT	postgres
9	1	5	7	125	122	Departamento amplio y bien iluminado,amplios dormitorios, sala de star, estudio,dormitorio principal con walking closet y baño privado, baño familiar, baño social, cocina con lavandería de diario, área de servicio exclusiva en azotea, cochera techada y deposito:\r\n\r\nPrecio: US$ 170 000 Número de habitaciones: 3 Tamaño: 170 m² Municipalidad: Yanahuara Dirección: Umacollo Tipo: Departamentos, Se vende	2014-01-16	2014-02-13	0.00	38	\N	0	0	126	2	170000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/333/IMG0.jpg	2014-01-16 11:02:50.453888	UPDATE	postgres
10	1	5	8	123	118	VENDO LINDO MINIDEPARTAMENTO EN CERRO COLORADO\r\n\r\nAREA: 55M2 APROX.\r\n\r\nHABITACIONES: 2\r\n\r\nBAÑOS: 1\r\n\r\nPRECIO: $50000\r\n\r\nDESRIPCION: DOS HABITACIONES, 1 SALA DE ESTUDIO, 1 BAÑO, COCINA, PEQUEÑA SALA.\r\n\r\nTELÉFONOS: 996132877 / RPM #986482 / RPM #0230116 / RPC 953502867.	2014-01-16	2014-02-13	0.00	15	\N	0	0	127	2	50000.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 11:17:11.944018	INSERT	postgres
11	1	5	8	123	118	VENDO LINDO MINIDEPARTAMENTO EN CERRO COLORADO\r\n\r\nAREA: 55M2 APROX.\r\n\r\nHABITACIONES: 2\r\n\r\nBAÑOS: 1\r\n\r\nPRECIO: $50000\r\n\r\nDESRIPCION: DOS HABITACIONES, 1 SALA DE ESTUDIO, 1 BAÑO, COCINA, PEQUEÑA SALA.\r\n\r\nTELÉFONOS: 996132877 / RPM #986482 / RPM #0230116 / RPC 953502867.	2014-01-16	2014-02-13	0.00	15	\N	0	0	127	2	50000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/334/IMG0.jpg	2014-01-16 11:17:11.944018	UPDATE	postgres
12	1	5	8	123	117	Departamentos en la mejor zona Ecológica de Arequipa, excelente clima, a 10 minutos del centro, con estacionamientos, Edificios con ascensor, financiados hasta 20 años con 10% de inicial\r\n\r\nWilfredo Ramos Navarro:959000025\r\nPrecio: 42.000\r\nCercado: Arequipa	2014-01-16	2014-02-13	0.00	13	\N	0	0	128	2	42000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 11:18:34.43023	INSERT	postgres
13	1	5	8	123	117	Departamentos en la mejor zona Ecológica de Arequipa, excelente clima, a 10 minutos del centro, con estacionamientos, Edificios con ascensor, financiados hasta 20 años con 10% de inicial\r\n\r\nWilfredo Ramos Navarro:959000025\r\nPrecio: 42.000\r\nCercado: Arequipa	2014-01-16	2014-02-13	0.00	13	\N	0	0	128	2	42000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/335/IMG0.jpg	2014-01-16 11:18:34.43023	UPDATE	postgres
14	1	5	8	123	117	AREA : 70 M2 APROX\r\n\r\nDISTRITO : CAYMA\r\n\r\nREFERENCIA : A 5 CUADRAS DE SAGA\r\n\r\nPRECIO : $50 000\r\n\r\nDESCRIPCION: UBICADO EN UNA QUINTA PRIVADA EN YANAHUARA IDEAL PARA EJECUTIVO O PAREJAS SOLAS DE 70 M2 CONSTA DE UNA SALA STAR, UN DORMITORIO, UN BAÑO, COCINA, CON COCHERA\r\n\r\nPrimer Piso.\r\n\r\nTELEFONOS: 996132877 RPM #986482 #0230116 RPC 953502867 977297939	2014-01-16	2014-02-13	0.00	14	\N	0	0	129	2	50000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 11:21:20.652756	INSERT	postgres
15	1	5	8	123	117	AREA : 70 M2 APROX\r\n\r\nDISTRITO : CAYMA\r\n\r\nREFERENCIA : A 5 CUADRAS DE SAGA\r\n\r\nPRECIO : $50 000\r\n\r\nDESCRIPCION: UBICADO EN UNA QUINTA PRIVADA EN YANAHUARA IDEAL PARA EJECUTIVO O PAREJAS SOLAS DE 70 M2 CONSTA DE UNA SALA STAR, UN DORMITORIO, UN BAÑO, COCINA, CON COCHERA\r\n\r\nPrimer Piso.\r\n\r\nTELEFONOS: 996132877 RPM #986482 #0230116 RPC 953502867 977297939	2014-01-16	2014-02-13	0.00	14	\N	0	0	129	2	50000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/336/IMG0.jpg	2014-01-16 11:21:20.652756	UPDATE	postgres
31	1	5	7	125	121	Departamento amplio y bien iluminado,amplios dormitorios, sala de star, estudio,dormitorio principal con walking closet y baño privado, baño familiar, baño social, cocina con lavandería de diario, área de servicio exclusiva en azotea, cochera techada y deposito:\r\n\r\nPrecio: US$ 170 000 Número de habitaciones: 3 Tamaño: 170 m² Municipalidad: Yanahuara Dirección: Umacollo Tipo: Departamentos, Se vende	2014-01-16	2014-02-13	0.00	38	\N	0	0	126	2	170000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/333/IMG0.jpg	2014-01-16 12:55:53.225337	UPDATE	postgres
16	1	5	8	123	118	VENDO MINI DEPARTAMENTO $50 000\r\n\r\nAREA : 70 M2 APROX\r\n\r\nDISTRITO : CAYMA\r\n\r\nREFERENCIA : A 5 CUADRAS DE SAGA\r\n\r\nPRECIO : $50 000 conversable\r\n\r\nDESCRIPCION: UBICADO EN UNA QUINTA PRIVADA EN YANAHUARA, ZONA TRANQUILA Y EXCLUSIVA, EN UN PRIMER PISO, IDEAL PARA EJECUTIVO O PAREJAS SOLAS DE 70 M2 CONSTA DE UNA SALA STAR, UN DORMITORIO, UN BAÑO, COCINA, CON COCHERA, ACABADOS DE PRIMERA\r\n\r\nUNICASAAQP\r\n\r\nunicasaaqpinmobiliaria@gmail.com\r\n\r\ncalle cortaderas 107-Yanahuara\r\n\r\nteléfonos 054 - 274927 / RPM #986482 / RPC 953502867	2014-01-16	2014-02-13	0.00	14	\N	0	0	130	2	50000.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 11:23:20.029864	INSERT	postgres
17	1	5	8	123	118	VENDO MINI DEPARTAMENTO $50 000\r\n\r\nAREA : 70 M2 APROX\r\n\r\nDISTRITO : CAYMA\r\n\r\nREFERENCIA : A 5 CUADRAS DE SAGA\r\n\r\nPRECIO : $50 000 conversable\r\n\r\nDESCRIPCION: UBICADO EN UNA QUINTA PRIVADA EN YANAHUARA, ZONA TRANQUILA Y EXCLUSIVA, EN UN PRIMER PISO, IDEAL PARA EJECUTIVO O PAREJAS SOLAS DE 70 M2 CONSTA DE UNA SALA STAR, UN DORMITORIO, UN BAÑO, COCINA, CON COCHERA, ACABADOS DE PRIMERA\r\n\r\nUNICASAAQP\r\n\r\nunicasaaqpinmobiliaria@gmail.com\r\n\r\ncalle cortaderas 107-Yanahuara\r\n\r\nteléfonos 054 - 274927 / RPM #986482 / RPC 953502867	2014-01-16	2014-02-13	0.00	14	\N	0	0	130	2	50000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/337/IMG0.jpg	2014-01-16 11:23:20.029864	UPDATE	postgres
19	1	5	8	123	118	Se vende bonito departamento en segundo piso, con cochera, tres dormitorios, piso de parquet, closets, reposteros altos y bajos, a 5 minutos del centro,del Parque Lambramani y Aventura Plaza.\r\n\r\nRony Zegarra:969991617\r\nPrecio: US$ 47 000\r\nArequipa Cercado	2014-01-16	2014-02-13	0.00	13	\N	0	0	132	2	47000.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 11:30:54.700296	INSERT	postgres
20	1	5	8	123	118	Se vende bonito departamento en segundo piso, con cochera, tres dormitorios, piso de parquet, closets, reposteros altos y bajos, a 5 minutos del centro,del Parque Lambramani y Aventura Plaza.\r\n\r\nRony Zegarra:969991617\r\nPrecio: US$ 47 000\r\nArequipa Cercado	2014-01-16	2014-02-13	0.00	13	\N	0	0	132	2	47000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/339/IMG0.jpg	2014-01-16 11:30:54.700296	UPDATE	postgres
21	1	5	8	124	122	Vendo bonito y amplio departamento 1er piso, en Urb. privada residencial con vigilacia las 24 horas, cuenta con 3 dormitorios,sala, comedor, cocina con reposteros altos y bajos, cochera , patio.\r\n\r\nAT: 145m2\r\n\r\nPRECIO:US$155,000\r\n\r\nINFORMES:250584 - 792967 - 959509654 958958629	2014-01-16	2014-02-13	0.00	38	\N	0	0	125	2	155000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/332/IMG0.jpg	2014-01-16 12:52:24.79718	UPDATE	postgres
22	1	5	7	125	122	Departamento amplio y bien iluminado,amplios dormitorios, sala de star, estudio,dormitorio principal con walking closet y baño privado, baño familiar, baño social, cocina con lavandería de diario, área de servicio exclusiva en azotea, cochera techada y deposito:\r\n\r\nPrecio: US$ 170 000 Número de habitaciones: 3 Tamaño: 170 m² Municipalidad: Yanahuara Dirección: Umacollo Tipo: Departamentos, Se vende	2014-01-16	2014-02-13	0.00	38	\N	0	0	126	2	170000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/333/IMG0.jpg	2014-01-16 12:52:24.79718	UPDATE	postgres
23	1	5	8	123	118	VENDO LINDO MINIDEPARTAMENTO EN CERRO COLORADO\r\n\r\nAREA: 55M2 APROX.\r\n\r\nHABITACIONES: 2\r\n\r\nBAÑOS: 1\r\n\r\nPRECIO: $50000\r\n\r\nDESRIPCION: DOS HABITACIONES, 1 SALA DE ESTUDIO, 1 BAÑO, COCINA, PEQUEÑA SALA.\r\n\r\nTELÉFONOS: 996132877 / RPM #986482 / RPM #0230116 / RPC 953502867.	2014-01-16	2014-02-13	0.00	15	\N	0	0	127	2	50000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/334/IMG0.jpg	2014-01-16 12:52:24.79718	UPDATE	postgres
24	1	5	8	123	117	Departamentos en la mejor zona Ecológica de Arequipa, excelente clima, a 10 minutos del centro, con estacionamientos, Edificios con ascensor, financiados hasta 20 años con 10% de inicial\r\n\r\nWilfredo Ramos Navarro:959000025\r\nPrecio: 42.000\r\nCercado: Arequipa	2014-01-16	2014-02-13	0.00	13	\N	0	0	128	2	42000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/335/IMG0.jpg	2014-01-16 12:52:24.79718	UPDATE	postgres
25	1	5	8	123	117	AREA : 70 M2 APROX\r\n\r\nDISTRITO : CAYMA\r\n\r\nREFERENCIA : A 5 CUADRAS DE SAGA\r\n\r\nPRECIO : $50 000\r\n\r\nDESCRIPCION: UBICADO EN UNA QUINTA PRIVADA EN YANAHUARA IDEAL PARA EJECUTIVO O PAREJAS SOLAS DE 70 M2 CONSTA DE UNA SALA STAR, UN DORMITORIO, UN BAÑO, COCINA, CON COCHERA\r\n\r\nPrimer Piso.\r\n\r\nTELEFONOS: 996132877 RPM #986482 #0230116 RPC 953502867 977297939	2014-01-16	2014-02-13	0.00	14	\N	0	0	129	2	50000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/336/IMG0.jpg	2014-01-16 12:52:24.79718	UPDATE	postgres
26	1	5	8	123	118	VENDO MINI DEPARTAMENTO $50 000\r\n\r\nAREA : 70 M2 APROX\r\n\r\nDISTRITO : CAYMA\r\n\r\nREFERENCIA : A 5 CUADRAS DE SAGA\r\n\r\nPRECIO : $50 000 conversable\r\n\r\nDESCRIPCION: UBICADO EN UNA QUINTA PRIVADA EN YANAHUARA, ZONA TRANQUILA Y EXCLUSIVA, EN UN PRIMER PISO, IDEAL PARA EJECUTIVO O PAREJAS SOLAS DE 70 M2 CONSTA DE UNA SALA STAR, UN DORMITORIO, UN BAÑO, COCINA, CON COCHERA, ACABADOS DE PRIMERA\r\n\r\nUNICASAAQP\r\n\r\nunicasaaqpinmobiliaria@gmail.com\r\n\r\ncalle cortaderas 107-Yanahuara\r\n\r\nteléfonos 054 - 274927 / RPM #986482 / RPC 953502867	2014-01-16	2014-02-13	0.00	14	\N	0	0	130	2	50000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/337/IMG0.jpg	2014-01-16 12:52:24.79718	UPDATE	postgres
27	1	5	8	123	118	Se vende bonito departamento en segundo piso, con cochera, tres dormitorios, piso de parquet, closets, reposteros altos y bajos, a 5 minutos del centro,del Parque Lambramani y Aventura Plaza.\r\n\r\nRony Zegarra:969991617\r\nPrecio: US$ 47 000\r\nArequipa Cercado	2014-01-16	2014-02-13	0.00	13	\N	0	0	132	2	47000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/339/IMG0.jpg	2014-01-16 12:52:24.79718	UPDATE	postgres
28	1	5	8	124	120	EDIFICIO RESIDENCIAL SANTA ELISA - POR LOS ANGELES DE CAYMA\r\n\r\nEDIFICIO RESIDENCIAL SANTA ELISA, 18 DEPARTAMENTOS CON LOS MEJORES ACABADOS EN ZONA EXCLUSIVA, EN PRE VENTA.\r\n\r\n\r\n75 M2 - 91,000 US$\r\n\r\n\r\n95 M2 - 115,000 US$\r\n\r\n\r\n119 M2 - 144, 00 US$\r\n\r\n\r\n169 M2 - 191,000 US$\r\n\r\n\r\nDatos de contacto:\r\nLortie Bienes Raices\r\n(054) 799091\r\n	2014-01-16	2014-01-30	15.00	14	\N	0	0	123	2	100000.00	\N	1	5	http://s3.amazonaws.com/clasificadosp1/330/IMG0.jpg	2014-01-16 12:52:24.79718	UPDATE	postgres
29	1	5	8	124	121	Precio 125 mil dolares, muy bien ubicado en Yanahuara. frente al Club internacional, en quinta residencial privada de 110 metros,\r\n\r\nconsta de 3 dormitorios con closet, cocina, comedor con reposteros, sala, comedor, hall y lavanderia, INFORMES: 508701	2014-01-16	2014-02-13	0.00	38	\N	0	0	124	2	125000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/331/IMG0.jpg	2014-01-16 12:52:24.79718	UPDATE	postgres
30	1	5	8	124	120	Vendo bonito y amplio departamento 1er piso, en Urb. privada residencial con vigilacia las 24 horas, cuenta con 3 dormitorios,sala, comedor, cocina con reposteros altos y bajos, cochera , patio.\r\n\r\nAT: 145m2\r\n\r\nPRECIO:US$155,000\r\n\r\nINFORMES:250584 - 792967 - 959509654 958958629	2014-01-16	2014-02-13	0.00	38	\N	0	0	125	2	155000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/332/IMG0.jpg	2014-01-16 12:55:39.952656	UPDATE	postgres
32	1	5	8	123	118	Departamentos en la mejor zona Ecológica de Arequipa, excelente clima, a 10 minutos del centro, con estacionamientos, Edificios con ascensor, financiados hasta 20 años con 10% de inicial\r\n\r\nWilfredo Ramos Navarro:959000025\r\nPrecio: 42.000\r\nCercado: Arequipa	2014-01-16	2014-02-13	0.00	13	\N	0	0	128	2	42000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/335/IMG0.jpg	2014-01-16 12:56:32.094002	UPDATE	postgres
33	1	5	8	123	118	AREA : 70 M2 APROX\r\n\r\nDISTRITO : CAYMA\r\n\r\nREFERENCIA : A 5 CUADRAS DE SAGA\r\n\r\nPRECIO : $50 000\r\n\r\nDESCRIPCION: UBICADO EN UNA QUINTA PRIVADA EN YANAHUARA IDEAL PARA EJECUTIVO O PAREJAS SOLAS DE 70 M2 CONSTA DE UNA SALA STAR, UN DORMITORIO, UN BAÑO, COCINA, CON COCHERA\r\n\r\nPrimer Piso.\r\n\r\nTELEFONOS: 996132877 RPM #986482 #0230116 RPC 953502867 977297939	2014-01-16	2014-02-13	0.00	14	\N	0	0	129	2	50000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/336/IMG0.jpg	2014-01-16 12:56:41.084469	UPDATE	postgres
34	1	5	8	124	119	EDIFICIO RESIDENCIAL SANTA ELISA - POR LOS ANGELES DE CAYMA\r\n\r\nEDIFICIO RESIDENCIAL SANTA ELISA, 18 DEPARTAMENTOS CON LOS MEJORES ACABADOS EN ZONA EXCLUSIVA, EN PRE VENTA.\r\n\r\n\r\n75 M2 - 91,000 US$\r\n\r\n\r\n95 M2 - 115,000 US$\r\n\r\n\r\n119 M2 - 144, 00 US$\r\n\r\n\r\n169 M2 - 191,000 US$\r\n\r\n\r\nDatos de contacto:\r\nLortie Bienes Raices\r\n(054) 799091\r\n	2014-01-16	2014-01-30	15.00	14	\N	0	0	123	2	100000.00	\N	1	5	http://s3.amazonaws.com/clasificadosp1/330/IMG0.jpg	2014-01-16 12:57:07.042086	UPDATE	postgres
35	1	5	8	124	120	Precio 125 mil dolares, muy bien ubicado en Yanahuara. frente al Club internacional, en quinta residencial privada de 110 metros,\r\n\r\nconsta de 3 dormitorios con closet, cocina, comedor con reposteros, sala, comedor, hall y lavanderia, INFORMES: 508701	2014-01-16	2014-02-13	0.00	38	\N	0	0	124	2	125000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/331/IMG0.jpg	2014-01-16 12:57:20.987967	UPDATE	postgres
36	1	6	8	125	138	EXCLUSIVO DEPARTAMENTO EN ALQUILER CERCA ASILO LIRA\r\n\r\nCodigo: D-00460\r\n\r\nExclusivo departamento amoblado en alquiler cerca Asilo Lira, cuenta con vigilancia privada las 24 horas, vista a jardin, balcón, acceso area de parrilladas en último piso.\r\n\r\nDescripción:\r\n\r\nAC 180m2\r\n\r\nSala, comedor, cocina, habitacion principal con walking closet y baño incorporado con sauna, dos habitaciones que comparten un baño, área de lavandería.\r\n\r\nTotalmente equipada.\r\n\r\nRenta Mensual S/.2800\r\n\r\nUNICASAAQP INMOBILIARIA Teléfonos : 996132877 / RPC 953502867 / 977297939 / RPM #0230116\r\n\r\nEmail : info@unicasaaqp.com	2014-01-16	2014-02-13	0.00	38	\N	0	0	133	2	2800.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 13:31:51.690397	INSERT	postgres
37	1	6	8	125	138	EXCLUSIVO DEPARTAMENTO EN ALQUILER CERCA ASILO LIRA\r\n\r\nCodigo: D-00460\r\n\r\nExclusivo departamento amoblado en alquiler cerca Asilo Lira, cuenta con vigilancia privada las 24 horas, vista a jardin, balcón, acceso area de parrilladas en último piso.\r\n\r\nDescripción:\r\n\r\nAC 180m2\r\n\r\nSala, comedor, cocina, habitacion principal con walking closet y baño incorporado con sauna, dos habitaciones que comparten un baño, área de lavandería.\r\n\r\nTotalmente equipada.\r\n\r\nRenta Mensual S/.2800\r\n\r\nUNICASAAQP INMOBILIARIA Teléfonos : 996132877 / RPC 953502867 / 977297939 / RPM #0230116\r\n\r\nEmail : info@unicasaaqp.com	2014-01-16	2014-02-13	0.00	38	\N	0	0	133	2	2800.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/340/IMG0.jpg	2014-01-16 13:31:51.690397	UPDATE	postgres
38	1	6	8	124	136	1ERA OPCION inmobiliaria alquilo como departamento en el Cercado, ambientes acogedores y bien iluminados\r\n\r\nDescripcion:\r\n\r\nsala comedor\r\n\r\ncocina con reposteros\r\n\r\n02 dormitorios\r\n\r\n01 baño\r\n\r\nPara mayor informacion (054) 340951 - 9580154001 rpm	2014-01-16	2014-02-13	0.00	13	\N	0	0	134	2	900.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 13:43:19.62064	INSERT	postgres
39	1	6	8	124	136	1ERA OPCION inmobiliaria alquilo como departamento en el Cercado, ambientes acogedores y bien iluminados\r\n\r\nDescripcion:\r\n\r\nsala comedor\r\n\r\ncocina con reposteros\r\n\r\n02 dormitorios\r\n\r\n01 baño\r\n\r\nPara mayor informacion (054) 340951 - 9580154001 rpm	2014-01-16	2014-02-13	0.00	13	\N	0	0	134	2	900.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/341/IMG0.jpg	2014-01-16 13:43:19.62064	UPDATE	postgres
40	1	6	8	125	138	ALQUILO DEPARTAMENTO AMPLIO EN URB. SEÑORIAL CAYMA\r\n\r\nCodigo: D-00277\r\n\r\nAlquilo amplio Departamento familiar amoblado ubicado a pocas cuadras de la Av. Cayma en zona exclusiva. Estratégicamente ubicado, cercano a bancos, restaurantes, centros comerciales.\r\n\r\nDescripcion:\r\n\r\nArea 170m2.\r\n\r\nUbicado en tercer piso.\r\n\r\nConsta de Amplia cochera, Sala comedor, Cocina con comedor de diario, baño social, sala de estudio, habitacion principal con walking closet y baño incluido, dos habitaciones con closets en melamine y un baño commpleto.\r\n\r\nArea de servicio y lavanderia.\r\n\r\nRenta Mensual S/. 3000.00\r\n\r\nTeléfonos : 996132877 / RPC 953502867 / 977297939 / RPM #0230116\r\n\r\nEmail : info@unicasaaqp.com	2014-01-16	2014-02-13	0.00	14	\N	0	0	135	2	3000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 13:46:28.868308	INSERT	postgres
41	1	6	8	125	138	ALQUILO DEPARTAMENTO AMPLIO EN URB. SEÑORIAL CAYMA\r\n\r\nCodigo: D-00277\r\n\r\nAlquilo amplio Departamento familiar amoblado ubicado a pocas cuadras de la Av. Cayma en zona exclusiva. Estratégicamente ubicado, cercano a bancos, restaurantes, centros comerciales.\r\n\r\nDescripcion:\r\n\r\nArea 170m2.\r\n\r\nUbicado en tercer piso.\r\n\r\nConsta de Amplia cochera, Sala comedor, Cocina con comedor de diario, baño social, sala de estudio, habitacion principal con walking closet y baño incluido, dos habitaciones con closets en melamine y un baño commpleto.\r\n\r\nArea de servicio y lavanderia.\r\n\r\nRenta Mensual S/. 3000.00\r\n\r\nTeléfonos : 996132877 / RPC 953502867 / 977297939 / RPM #0230116\r\n\r\nEmail : info@unicasaaqp.com	2014-01-16	2014-02-13	0.00	14	\N	0	0	135	2	3000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/342/IMG0.jpg	2014-01-16 13:46:28.868308	UPDATE	postgres
42	1	5	7	123	117	Alquilo departamento amoblado en Vallecito de un dormitorio, salita, kichenett, servicios higienicos completos\r\n\r\nS/. 1000\r\n\r\nInteresados contactarse al RPC 940163354 ó al RPM #959372141	2014-01-16	2014-02-13	0.00	12	\N	0	0	136	2	1000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 13:48:33.63501	INSERT	postgres
43	1	5	7	123	117	Alquilo departamento amoblado en Vallecito de un dormitorio, salita, kichenett, servicios higienicos completos\r\n\r\nS/. 1000\r\n\r\nInteresados contactarse al RPC 940163354 ó al RPM #959372141	2014-01-16	2014-02-13	0.00	12	\N	0	0	136	2	1000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/343/IMG0.jpg	2014-01-16 13:48:33.63501	UPDATE	postgres
44	1	6	8	124	137	Alquilo hermoso departamento en Piedra Santa, Residencial privada 1er piso, tres dormitorios con closet empotrados el dormitorio principal con baño privado, sala comedor, cocina con reposteros altos y bajos, 3 baños, cuarto y baño de servicio, lavanderia, cochera, patio, tendales. Tiene amplios y comodos ambientes el departamento es el semi estreno, ambientes bien iluminados.\r\n\r\nINFORMES:RPC 958958629 - 958958628 - #648266 #648267 - 250584\r\n	2014-01-16	2014-02-13	0.00	38	\N	0	0	137	2	1700.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-16 13:51:25.366035	INSERT	postgres
66	4	102	\N	\N	\N	Vendo Sony DSCF707 ,con estuche ,sin cargador algun descripciones : Precio drogo S/. 300 soles	2014-01-17	2014-02-14	0.00	\N	\N	0	0	151	2	300.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/358/IMG0.jpg	2014-01-17 13:07:36.081672	UPDATE	postgres
45	1	6	8	124	137	Alquilo hermoso departamento en Piedra Santa, Residencial privada 1er piso, tres dormitorios con closet empotrados el dormitorio principal con baño privado, sala comedor, cocina con reposteros altos y bajos, 3 baños, cuarto y baño de servicio, lavanderia, cochera, patio, tendales. Tiene amplios y comodos ambientes el departamento es el semi estreno, ambientes bien iluminados.\r\n\r\nINFORMES:RPC 958958629 - 958958628 - #648266 #648267 - 250584\r\n	2014-01-16	2014-02-13	0.00	38	\N	0	0	137	2	1700.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/344/IMG0.jpg	2014-01-16 13:51:25.366035	UPDATE	postgres
47	1	6	8	124	138	1ERA. OPCIÓN INMOBILIARIA - ALQUILA DEPARTAMENTO AMOBLADO - YANAHUARA\r\n\r\nDistribución:\r\n\r\n3er. Piso:\r\n\r\n03 Dormitorios con closets de madera\r\n\r\nSala-comedor\r\n\r\nKichenette\r\n\r\n3 Dormitorios\r\n\r\n2 Baños\r\n\r\nMenaje Completo\r\n\r\nIndependiente y Seguro\r\n\r\nCochera\r\n\r\nMayor información al 340951 o visítenos en Av. Ejercito 101 Edificio Nasya Of.312\r\n\r\n2000s	2014-01-17	2014-02-14	0.00	38	\N	0	0	139	2	2000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 10:25:01.245312	INSERT	postgres
48	1	6	8	124	138	1ERA. OPCIÓN INMOBILIARIA - ALQUILA DEPARTAMENTO AMOBLADO - YANAHUARA\r\n\r\nDistribución:\r\n\r\n3er. Piso:\r\n\r\n03 Dormitorios con closets de madera\r\n\r\nSala-comedor\r\n\r\nKichenette\r\n\r\n3 Dormitorios\r\n\r\n2 Baños\r\n\r\nMenaje Completo\r\n\r\nIndependiente y Seguro\r\n\r\nCochera\r\n\r\nMayor información al 340951 o visítenos en Av. Ejercito 101 Edificio Nasya Of.312\r\n\r\n2000s	2014-01-17	2014-02-14	0.00	38	\N	0	0	139	2	2000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/346/IMG0.jpg	2014-01-17 10:25:01.245312	UPDATE	postgres
50	3	66	73	\N	\N	Fabricado en 2011\r\nUsado\r\nKilómetros: 48705 km.\r\nPuertas: 4 puertas\r\nCombustible: Gasolina\r\nPublicado el 25/11/2013	2014-01-17	2014-02-14	0.00	128	\N	0	0	141	2	3000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 11:33:05.830929	INSERT	postgres
51	3	66	73	\N	\N	Fabricado en 2011\r\nUsado\r\nKilómetros: 48705 km.\r\nPuertas: 4 puertas\r\nCombustible: Gasolina\r\nPublicado el 25/11/2013	2014-01-17	2014-02-14	0.00	128	\N	0	0	141	2	3000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/348/IMG0.jpg	2014-01-17 11:33:05.830929	UPDATE	postgres
52	3	66	73	\N	\N	El nuevo Chevrolet Sail Hatchback llega al país para ofrecerte la mejor combinación entre equipamiento, diseño moderno, espacio y precio. Este compacto funcional valora quién eres y adónde quieres llegar en la vida. Deja superar tus expectativas con un auto ágil, seguro y totalmente accesible que incorpora asiento posterior rebatible para una mayor practicidad.\r\n\r\nMarca\tChevrolet\r\nModelo\tSail\r\nVersion\tHatchback\r\nKilometrajes\t0 Km\r\nPrecio\tUS$ 12,490 (S/. 37,470)	2014-01-17	2014-02-14	0.00	130	\N	0	0	142	2	12490.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 11:35:58.335577	INSERT	postgres
53	3	66	73	\N	\N	El nuevo Chevrolet Sail Hatchback llega al país para ofrecerte la mejor combinación entre equipamiento, diseño moderno, espacio y precio. Este compacto funcional valora quién eres y adónde quieres llegar en la vida. Deja superar tus expectativas con un auto ágil, seguro y totalmente accesible que incorpora asiento posterior rebatible para una mayor practicidad.\r\n\r\nMarca\tChevrolet\r\nModelo\tSail\r\nVersion\tHatchback\r\nKilometrajes\t0 Km\r\nPrecio\tUS$ 12,490 (S/. 37,470)	2014-01-17	2014-02-14	0.00	130	\N	0	0	142	2	12490.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/349/IMG0.jpg	2014-01-17 11:35:58.335577	UPDATE	postgres
54	3	66	73	\N	\N	Fabricado en 2010\r\nUsado\r\nEs de color rojo vino\r\nUbicado en san martin de porras, Lima, Lima\r\nKilómetros: 46000 km.\r\nPuertas: 4 puertas\r\nCombustible: Convertido a Gas\r\nDirección: Mecánica\r\nTimón: Original\r\nTapizado: cuero negro\r\nPublicado el 30/12/2013	2014-01-17	2014-02-14	0.00	130	\N	0	0	143	2	12500.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 11:40:30.750155	INSERT	postgres
55	3	66	73	\N	\N	Fabricado en 2010\r\nUsado\r\nEs de color rojo vino\r\nUbicado en san martin de porras, Lima, Lima\r\nKilómetros: 46000 km.\r\nPuertas: 4 puertas\r\nCombustible: Convertido a Gas\r\nDirección: Mecánica\r\nTimón: Original\r\nTapizado: cuero negro\r\nPublicado el 30/12/2013	2014-01-17	2014-02-14	0.00	130	\N	0	0	143	2	12500.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/350/IMG0.png	2014-01-17 11:40:30.750155	UPDATE	postgres
56	3	67	73	\N	\N	Fabricado en 2004\r\nUsado\r\nKilómetros: 88227 km.\r\nPuertas: 4 puertas\r\nCombustible: Gasolina\r\nPublicado el 7/12/2013	2014-01-17	2014-02-14	0.00	128	\N	0	0	144	2	4000.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 11:45:47.718725	INSERT	postgres
57	3	67	73	\N	\N	Fabricado en 2004\r\nUsado\r\nKilómetros: 88227 km.\r\nPuertas: 4 puertas\r\nCombustible: Gasolina\r\nPublicado el 7/12/2013	2014-01-17	2014-02-14	0.00	128	\N	0	0	144	2	4000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/351/IMG0.jpg	2014-01-17 11:45:47.718725	UPDATE	postgres
58	3	66	73	\N	\N	Sedan Malibú Modelo LTZ (El mas equipado, 100% Made in USA), Fantástica aceleración, sonido y conducción, Asientos de cuero dos tonos, SUNROOF electrico, Cuero original en dos tonos en asientos y timòn , super seguro-08 airbags de fabrica, frenos ABS, antipatinaje, Caja automatica Tiptronic c/ Paddle Shifters, El Motor es el mismo del CAMARO 2013= 3.6 Litros V6-doble eje de levas, 252 HP , doble tubo de escape cromado, CD changer, crucero y ONSTAR, Keyless y encendido a distancia, asientos electricos y A/C, pedal graduable,Dimensiones similares al Honda Accord , Nissan Altima, BMW535, BMW525i ,Lexus GS350 y Volvo S80 , posee Aros Cromados de 18" , llantas radiales perfil 50 , citas para verlo en Miraflores, al 991366060. Sin choques, excelente estado, Elegancia,Seguridad, Potencia y Confort maximos.(cambios manuales en timón y caja automatica) amplia maletera, Modelo LTZ Maximo modelo americano, se entrega con SOAT y placas UNICO DUEÑO. Video Youtube copie link: http://www.youtube.com/watch?v=PydHeowYGQg y Mas informacion solicitarla al mail: danieldavila2005@yahoo.es\r\n\r\nPrecio: US$ 19,500\r\n(S/. 50,700)	2014-01-17	2014-02-14	0.00	131	\N	0	0	145	2	19500.00	\N	1	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 11:48:31.260469	INSERT	postgres
67	4	102	\N	\N	\N	Precio\r\nS./670.00\r\n\r\nA PEDIDO, Totalmente nuevo 100% Garantía...\r\nSeparalo Ya..Desde el 10%\r\n\r\nllamar a 6710510	2014-01-17	2014-02-14	0.00	\N	\N	0	0	152	2	670.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 13:09:57.687784	INSERT	postgres
68	4	102	\N	\N	\N	Precio\r\nS./670.00\r\n\r\nA PEDIDO, Totalmente nuevo 100% Garantía...\r\nSeparalo Ya..Desde el 10%\r\n\r\nllamar a 6710510	2014-01-17	2014-02-14	0.00	\N	\N	0	0	152	2	670.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/359/IMG0.jpg	2014-01-17 13:09:57.687784	UPDATE	postgres
59	3	66	73	\N	\N	Sedan Malibú Modelo LTZ (El mas equipado, 100% Made in USA), Fantástica aceleración, sonido y conducción, Asientos de cuero dos tonos, SUNROOF electrico, Cuero original en dos tonos en asientos y timòn , super seguro-08 airbags de fabrica, frenos ABS, antipatinaje, Caja automatica Tiptronic c/ Paddle Shifters, El Motor es el mismo del CAMARO 2013= 3.6 Litros V6-doble eje de levas, 252 HP , doble tubo de escape cromado, CD changer, crucero y ONSTAR, Keyless y encendido a distancia, asientos electricos y A/C, pedal graduable,Dimensiones similares al Honda Accord , Nissan Altima, BMW535, BMW525i ,Lexus GS350 y Volvo S80 , posee Aros Cromados de 18" , llantas radiales perfil 50 , citas para verlo en Miraflores, al 991366060. Sin choques, excelente estado, Elegancia,Seguridad, Potencia y Confort maximos.(cambios manuales en timón y caja automatica) amplia maletera, Modelo LTZ Maximo modelo americano, se entrega con SOAT y placas UNICO DUEÑO. Video Youtube copie link: http://www.youtube.com/watch?v=PydHeowYGQg y Mas informacion solicitarla al mail: danieldavila2005@yahoo.es\r\n\r\nPrecio: US$ 19,500\r\n(S/. 50,700)	2014-01-17	2014-02-14	0.00	131	\N	0	0	145	2	19500.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/352/IMG0.jpg	2014-01-17 11:48:31.260469	UPDATE	postgres
60	2	48	50	\N	\N	AUXILIAR ADMINISTRATIVO\r\nEmpresa: PROSEGUR\r\n\r\n•\tElaborar cuadros de productividad por áreas.\r\n•\tAtender consultas de clientes con respecto a recepción y entrega de tarjetas.\r\n•\tElaborar documentos propios de las actividades del área.\r\n•\tElaborar reporte de producción y entregas para ser enviado al área de facturación en los plazos establecidos.\r\n•\tElaborar y archivar documentación interna y externa.\r\n•\tCoordinar con almacén y el cliente el abastecimiento oportuno de stock de formatería.\r\n•\tRealizar otras funciones que su jefe inmediato le asigne.\r\nREQUISITOS:\r\n\r\n•\tSecundaria completa.\r\n•\tExperiencia mínima de 1 año en el puesto realizando funciones similares.\r\n•\tManejo de Office a nivel intermedio o avanzado, de preferencia Excel.\r\n\r\nHorario de trabajo de Lunes a Viernes de 8:30am a 6:00pm y sábado 9am a 12:00 pm \r\n\r\nPresentarse el Viernes 17 de Enero a las 10:00 AM con DNI y CV impreso en Av. Morro Solar 1086 - Surco. Referencia: Prosegur de Panamericana Sur (Km. 8). Ingresar por Centro Bancario. Preguntar por Srta. Ratto	2014-01-17	2014-02-14	0.00	112	\N	0	0	146	2	2500.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 12:30:19.041835	INSERT	postgres
61	2	48	50	\N	\N	Parrilladas Peruanas Sociedad Anonima:\r\n\r\n-\tRegistro y revisión de ventas mensuales.\r\n-\tRevisión y validación de documentación contable compras, ventas, etc.\r\n-\tProgramación de pagos semanales, mensuales, trimestrales y anuales.\r\n-\tEmisión de cheques, transferencias interbancarias, pagos en línea.\r\n-\tControl de vencimientos (facturas, letras, seguros, pagarés, impuestos, AFPs, remuneraciones, etc.).\r\n-\tProvisión, archivo y ordenamiento de las facturas por pagar, servicios, contratos, etc.\r\n-\tElaboración de reportes de entregas a rendir.\r\n-\tElaboración de reportes bancarios\r\n-\tAdministración del mantenimiento de las instalaciones de la empresa, compras de bienes, suministros, servicios y coordinación con proveedores.\r\n-\tRealizar declaración de impuestos.\r\n-\tManejo de cobros y pagos en cuentas corrientes y caja chica.\r\n-\tResponsabilidad\r\n-\tProactividad\r\n-\tSentido de urgencia\r\n-\tComunicación efectiva\r\n-\tTrabajo en equipo\r\n-\tCapacidad de análisis\r\n-\tOrganización y planificación\r\n\r\n\r\n	2014-01-17	2014-02-14	0.00	111	\N	0	0	147	2	2000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 12:31:18.351169	INSERT	postgres
62	2	48	50	\N	\N	Pae Peru Ingenieria:\r\n\r\nNuestro cliente, importante empresa del rubro de servicios alimenticios, se encuentra en la búsqueda de un profesional para cubrir la vacante de:\r\n\r\n\r\nADMINISTRADOR DE CONTRATO (ADM-GC)\r\n\r\nRequisitos:\r\n•Con más de 2 años de experiencia en rubro de alimentos.\r\n•Experiencia mínima de 2 años en Jefaturas o coordinación.\r\n•Estudios Técnicos o Superiores en Administración, Administración Hotelera o afines.\r\n•Experiencia en realizar trabajo de campo, supervisando las operaciones en diferentes sedes.\r\n•Disponibilidad para trabajar según la operación lo amerite fines de semana.\r\nFunciones:\r\n•Supervisión directa de 11 sedes.\r\n•Responsable de la supervisión del personal.\r\n•Coordinación con la asistencia del personal.\r\n•Responsable de optimizar procesos.\r\n•Responsable en conjunto con el área Contable de analizar y optimizar costos.\r\n•Experiencia en elaboración de inventarios.\r\n\r\nBeneficios:\r\n\r\n•Ingreso a planilla y todos los beneficios de ley.\r\n•Oportunidad de línea de carrera.\r\n\r\n\r\nLos interesados enviar su CV con código (ADM-GC) a iamonteza(arrob.a)pae.cc indicando pretensiones salariales.	2014-01-17	2014-02-14	0.00	112	\N	0	0	148	2	3000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 12:32:14.045119	INSERT	postgres
63	2	48	50	\N	\N	PROSEGUR: Gestor de Cobranza \r\nNuestro cliente, importante empresa del rubro de servicios alimenticios, se encuentra en la búsqueda de un profesional para cubrir la vacante de:\r\n\r\n\r\nADMINISTRADOR DE CONTRATO (ADM-GC)\r\n\r\nRequisitos:\r\n•Con más de 2 años de experiencia en rubro de alimentos.\r\n•Experiencia mínima de 2 años en Jefaturas o coordinación.\r\n•Estudios Técnicos o Superiores en Administración, Administración Hotelera o afines.\r\n•Experiencia en realizar trabajo de campo, supervisando las operaciones en diferentes sedes.\r\n•Disponibilidad para trabajar según la operación lo amerite fines de semana.\r\nFunciones:\r\n•Supervisión directa de 11 sedes.\r\n•Responsable de la supervisión del personal.\r\n•Coordinación con la asistencia del personal.\r\n•Responsable de optimizar procesos.\r\n•Responsable en conjunto con el área Contable de analizar y optimizar costos.\r\n•Experiencia en elaboración de inventarios.\r\n\r\nBeneficios:\r\n\r\n•Ingreso a planilla y todos los beneficios de ley.\r\n•Oportunidad de línea de carrera.\r\n\r\n\r\nLos interesados enviar su CV con código (ADM-GC) a iamonteza(arrob.a)pae.cc indicando pretensiones salariales.	2014-01-17	2014-02-14	0.00	111	\N	0	0	149	2	2000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 12:33:05.422146	INSERT	postgres
64	2	48	50	\N	\N	Adeco: Supervisor autoservicio.\r\n\r\nFunciones:\r\nSupervisar y verificar el trabajo de los mercaderistas en lo referente a funciones encomendadas.\r\nSeguimiento constante del cumplimiento de los objetivos del personal a cargo y cliente.\r\nResponsable de la gestión administrativa del personal a cargo.\r\nMantener comunicación constante con jefes de área, canalizar adecuadamente al cliente sobre las acciones y estrategias de la competencia\r\nRequisitos:\r\n• Experiencia de 1 año como supervisor de autoservicios y/o canal mayorista, deseable experiencia en rubro de consumo masivo.\r\n• Conocimientos de office a nivel intermedio\r\n• Disponibilidad completa de horarios en especial de: 09:00 a.m. - 07:00 p.m. de Lunes a Domingo con un día de descanso.\r\n• Competencias: Liderazgo, sociable, responsable, empático y orientado al cliente.\r\n\r\nOfrecemos:\r\n• Remuneración: S/. 2,550\r\n• Asignación por movilidad.\r\n• Ingreso a planilla con todos los beneficios de acuerdo a ley.\r\n• Pertenecer a una compañía líder.\r\n\r\n	2014-01-17	2014-02-14	0.00	114	\N	0	0	150	2	5000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 12:47:12.919388	INSERT	postgres
65	4	102	\N	\N	\N	Vendo Sony DSCF707 ,con estuche ,sin cargador algun descripciones : Precio drogo S/. 300 soles	2014-01-17	2014-02-14	0.00	\N	\N	0	0	151	2	300.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 13:07:36.081672	INSERT	postgres
69	2	48	50	\N	\N	AUXILIAR ADMINISTRATIVO\r\nEmpresa: PROSEGUR\r\n\r\n•\tElaborar cuadros de productividad por áreas.\r\n•\tAtender consultas de clientes con respecto a recepción y entrega de tarjetas.\r\n•\tElaborar documentos propios de las actividades del área.\r\n•\tElaborar reporte de producción y entregas para ser enviado al área de facturación en los plazos establecidos.\r\n•\tElaborar y archivar documentación interna y externa.\r\n•\tCoordinar con almacén y el cliente el abastecimiento oportuno de stock de formatería.\r\n•\tRealizar otras funciones que su jefe inmediato le asigne.\r\nREQUISITOS:\r\n\r\n•\tSecundaria completa.\r\n•\tExperiencia mínima de 1 año en el puesto realizando funciones similares.\r\n•\tManejo de Office a nivel intermedio o avanzado, de preferencia Excel.\r\n\r\nHorario de trabajo de Lunes a Viernes de 8:30am a 6:00pm y sábado 9am a 12:00 pm \r\n\r\nPresentarse el Viernes 17 de Enero a las 10:00 AM con DNI y CV impreso en Av. Morro Solar 1086 - Surco. Referencia: Prosegur de Panamericana Sur (Km. 8). Ingresar por Centro Bancario. Preguntar por Srta. Ratto	2014-01-17	2014-02-14	0.00	112	\N	0	0	146	2	2500.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 15:59:56.734445	UPDATE	postgres
70	2	48	50	\N	\N	Parrilladas Peruanas Sociedad Anonima:\r\n\r\n-\tRegistro y revisión de ventas mensuales.\r\n-\tRevisión y validación de documentación contable compras, ventas, etc.\r\n-\tProgramación de pagos semanales, mensuales, trimestrales y anuales.\r\n-\tEmisión de cheques, transferencias interbancarias, pagos en línea.\r\n-\tControl de vencimientos (facturas, letras, seguros, pagarés, impuestos, AFPs, remuneraciones, etc.).\r\n-\tProvisión, archivo y ordenamiento de las facturas por pagar, servicios, contratos, etc.\r\n-\tElaboración de reportes de entregas a rendir.\r\n-\tElaboración de reportes bancarios\r\n-\tAdministración del mantenimiento de las instalaciones de la empresa, compras de bienes, suministros, servicios y coordinación con proveedores.\r\n-\tRealizar declaración de impuestos.\r\n-\tManejo de cobros y pagos en cuentas corrientes y caja chica.\r\n-\tResponsabilidad\r\n-\tProactividad\r\n-\tSentido de urgencia\r\n-\tComunicación efectiva\r\n-\tTrabajo en equipo\r\n-\tCapacidad de análisis\r\n-\tOrganización y planificación\r\n\r\n\r\n	2014-01-17	2014-02-14	0.00	111	\N	0	0	147	2	2000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:00:55.80534	UPDATE	postgres
71	2	48	50	\N	\N	Pae Peru Ingenieria:\r\n\r\nNuestro cliente, importante empresa del rubro de servicios alimenticios, se encuentra en la búsqueda de un profesional para cubrir la vacante de:\r\n\r\n\r\nADMINISTRADOR DE CONTRATO (ADM-GC)\r\n\r\nRequisitos:\r\n•Con más de 2 años de experiencia en rubro de alimentos.\r\n•Experiencia mínima de 2 años en Jefaturas o coordinación.\r\n•Estudios Técnicos o Superiores en Administración, Administración Hotelera o afines.\r\n•Experiencia en realizar trabajo de campo, supervisando las operaciones en diferentes sedes.\r\n•Disponibilidad para trabajar según la operación lo amerite fines de semana.\r\nFunciones:\r\n•Supervisión directa de 11 sedes.\r\n•Responsable de la supervisión del personal.\r\n•Coordinación con la asistencia del personal.\r\n•Responsable de optimizar procesos.\r\n•Responsable en conjunto con el área Contable de analizar y optimizar costos.\r\n•Experiencia en elaboración de inventarios.\r\n\r\nBeneficios:\r\n\r\n•Ingreso a planilla y todos los beneficios de ley.\r\n•Oportunidad de línea de carrera.\r\n\r\n\r\nLos interesados enviar su CV con código (ADM-GC) a iamonteza(arrob.a)pae.cc indicando pretensiones salariales.	2014-01-17	2014-02-14	0.00	112	\N	0	0	148	2	3000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:01:37.487998	UPDATE	postgres
72	2	48	50	\N	\N	PROSEGUR: Gestor de Cobranza \r\nNuestro cliente, importante empresa del rubro de servicios alimenticios, se encuentra en la búsqueda de un profesional para cubrir la vacante de:\r\n\r\n\r\nADMINISTRADOR DE CONTRATO (ADM-GC)\r\n\r\nRequisitos:\r\n•Con más de 2 años de experiencia en rubro de alimentos.\r\n•Experiencia mínima de 2 años en Jefaturas o coordinación.\r\n•Estudios Técnicos o Superiores en Administración, Administración Hotelera o afines.\r\n•Experiencia en realizar trabajo de campo, supervisando las operaciones en diferentes sedes.\r\n•Disponibilidad para trabajar según la operación lo amerite fines de semana.\r\nFunciones:\r\n•Supervisión directa de 11 sedes.\r\n•Responsable de la supervisión del personal.\r\n•Coordinación con la asistencia del personal.\r\n•Responsable de optimizar procesos.\r\n•Responsable en conjunto con el área Contable de analizar y optimizar costos.\r\n•Experiencia en elaboración de inventarios.\r\n\r\nBeneficios:\r\n\r\n•Ingreso a planilla y todos los beneficios de ley.\r\n•Oportunidad de línea de carrera.\r\n\r\n\r\nLos interesados enviar su CV con código (ADM-GC) a iamonteza(arrob.a)pae.cc indicando pretensiones salariales.	2014-01-17	2014-02-14	0.00	111	\N	0	0	149	2	2000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:02:07.37442	UPDATE	postgres
73	2	48	50	\N	\N	Adeco: Supervisor autoservicio.\r\n\r\nFunciones:\r\nSupervisar y verificar el trabajo de los mercaderistas en lo referente a funciones encomendadas.\r\nSeguimiento constante del cumplimiento de los objetivos del personal a cargo y cliente.\r\nResponsable de la gestión administrativa del personal a cargo.\r\nMantener comunicación constante con jefes de área, canalizar adecuadamente al cliente sobre las acciones y estrategias de la competencia\r\nRequisitos:\r\n• Experiencia de 1 año como supervisor de autoservicios y/o canal mayorista, deseable experiencia en rubro de consumo masivo.\r\n• Conocimientos de office a nivel intermedio\r\n• Disponibilidad completa de horarios en especial de: 09:00 a.m. - 07:00 p.m. de Lunes a Domingo con un día de descanso.\r\n• Competencias: Liderazgo, sociable, responsable, empático y orientado al cliente.\r\n\r\nOfrecemos:\r\n• Remuneración: S/. 2,550\r\n• Asignación por movilidad.\r\n• Ingreso a planilla con todos los beneficios de acuerdo a ley.\r\n• Pertenecer a una compañía líder.\r\n\r\n	2014-01-17	2014-02-14	0.00	114	\N	0	0	150	2	5000.00	\N	2	4	s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:02:43.46058	UPDATE	postgres
74	2	48	50	\N	\N	Parrilladas Peruanas Sociedad Anonima:\r\n\r\n-\tRegistro y revisión de ventas mensuales.\r\n-\tRevisión y validación de documentación contable compras, ventas, etc.\r\n-\tProgramación de pagos semanales, mensuales, trimestrales y anuales.\r\n-\tEmisión de cheques, transferencias interbancarias, pagos en línea.\r\n-\tControl de vencimientos (facturas, letras, seguros, pagarés, impuestos, AFPs, remuneraciones, etc.).\r\n-\tProvisión, archivo y ordenamiento de las facturas por pagar, servicios, contratos, etc.\r\n-\tElaboración de reportes de entregas a rendir.\r\n-\tElaboración de reportes bancarios\r\n-\tAdministración del mantenimiento de las instalaciones de la empresa, compras de bienes, suministros, servicios y coordinación con proveedores.\r\n-\tRealizar declaración de impuestos.\r\n-\tManejo de cobros y pagos en cuentas corrientes y caja chica.\r\n-\tResponsabilidad\r\n-\tProactividad\r\n-\tSentido de urgencia\r\n-\tComunicación efectiva\r\n-\tTrabajo en equipo\r\n-\tCapacidad de análisis\r\n-\tOrganización y planificación\r\n\r\n\r\n	2014-01-17	2014-02-14	0.00	111	\N	0	0	147	2	2000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:21:07.123722	UPDATE	postgres
82	3	67	73	\N	\N	Fabricado en 2004\r\nUsado\r\nKilómetros: 88227 km.\r\nPuertas: 4 puertas\r\nCombustible: Gasolina\r\nPublicado el 7/12/2013	2014-01-17	2014-02-14	0.00	128	\N	0	0	155	2	4000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:36:33.466349	INSERT	postgres
83	3	67	73	\N	\N	Fabricado en 2004\r\nUsado\r\nKilómetros: 88227 km.\r\nPuertas: 4 puertas\r\nCombustible: Gasolina\r\nPublicado el 7/12/2013	2014-01-17	2014-02-14	0.00	128	\N	0	0	155	2	4000.00	\N	1	4	http://s3.amazonaws.com/clasificadosp1/362/IMG0.jpg	2014-01-17 16:36:33.466349	UPDATE	postgres
75	2	48	50	\N	\N	Pae Peru Ingenieria:\r\n\r\nNuestro cliente, importante empresa del rubro de servicios alimenticios, se encuentra en la búsqueda de un profesional para cubrir la vacante de:\r\n\r\n\r\nADMINISTRADOR DE CONTRATO (ADM-GC)\r\n\r\nRequisitos:\r\n•Con más de 2 años de experiencia en rubro de alimentos.\r\n•Experiencia mínima de 2 años en Jefaturas o coordinación.\r\n•Estudios Técnicos o Superiores en Administración, Administración Hotelera o afines.\r\n•Experiencia en realizar trabajo de campo, supervisando las operaciones en diferentes sedes.\r\n•Disponibilidad para trabajar según la operación lo amerite fines de semana.\r\nFunciones:\r\n•Supervisión directa de 11 sedes.\r\n•Responsable de la supervisión del personal.\r\n•Coordinación con la asistencia del personal.\r\n•Responsable de optimizar procesos.\r\n•Responsable en conjunto con el área Contable de analizar y optimizar costos.\r\n•Experiencia en elaboración de inventarios.\r\n\r\nBeneficios:\r\n\r\n•Ingreso a planilla y todos los beneficios de ley.\r\n•Oportunidad de línea de carrera.\r\n\r\n\r\nLos interesados enviar su CV con código (ADM-GC) a iamonteza(arrob.a)pae.cc indicando pretensiones salariales.	2014-01-17	2014-02-14	0.00	112	\N	0	0	148	2	3000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:21:07.123722	UPDATE	postgres
76	2	48	50	\N	\N	PROSEGUR: Gestor de Cobranza \r\nNuestro cliente, importante empresa del rubro de servicios alimenticios, se encuentra en la búsqueda de un profesional para cubrir la vacante de:\r\n\r\n\r\nADMINISTRADOR DE CONTRATO (ADM-GC)\r\n\r\nRequisitos:\r\n•Con más de 2 años de experiencia en rubro de alimentos.\r\n•Experiencia mínima de 2 años en Jefaturas o coordinación.\r\n•Estudios Técnicos o Superiores en Administración, Administración Hotelera o afines.\r\n•Experiencia en realizar trabajo de campo, supervisando las operaciones en diferentes sedes.\r\n•Disponibilidad para trabajar según la operación lo amerite fines de semana.\r\nFunciones:\r\n•Supervisión directa de 11 sedes.\r\n•Responsable de la supervisión del personal.\r\n•Coordinación con la asistencia del personal.\r\n•Responsable de optimizar procesos.\r\n•Responsable en conjunto con el área Contable de analizar y optimizar costos.\r\n•Experiencia en elaboración de inventarios.\r\n\r\nBeneficios:\r\n\r\n•Ingreso a planilla y todos los beneficios de ley.\r\n•Oportunidad de línea de carrera.\r\n\r\n\r\nLos interesados enviar su CV con código (ADM-GC) a iamonteza(arrob.a)pae.cc indicando pretensiones salariales.	2014-01-17	2014-02-14	0.00	111	\N	0	0	149	2	2000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:21:07.123722	UPDATE	postgres
77	2	48	50	\N	\N	Adeco: Supervisor autoservicio.\r\n\r\nFunciones:\r\nSupervisar y verificar el trabajo de los mercaderistas en lo referente a funciones encomendadas.\r\nSeguimiento constante del cumplimiento de los objetivos del personal a cargo y cliente.\r\nResponsable de la gestión administrativa del personal a cargo.\r\nMantener comunicación constante con jefes de área, canalizar adecuadamente al cliente sobre las acciones y estrategias de la competencia\r\nRequisitos:\r\n• Experiencia de 1 año como supervisor de autoservicios y/o canal mayorista, deseable experiencia en rubro de consumo masivo.\r\n• Conocimientos de office a nivel intermedio\r\n• Disponibilidad completa de horarios en especial de: 09:00 a.m. - 07:00 p.m. de Lunes a Domingo con un día de descanso.\r\n• Competencias: Liderazgo, sociable, responsable, empático y orientado al cliente.\r\n\r\nOfrecemos:\r\n• Remuneración: S/. 2,550\r\n• Asignación por movilidad.\r\n• Ingreso a planilla con todos los beneficios de acuerdo a ley.\r\n• Pertenecer a una compañía líder.\r\n\r\n	2014-01-17	2014-02-14	0.00	114	\N	0	0	150	2	5000.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:21:07.123722	UPDATE	postgres
78	2	48	50	\N	\N	AUXILIAR ADMINISTRATIVO\r\nEmpresa: PROSEGUR\r\n\r\n•\tElaborar cuadros de productividad por áreas.\r\n•\tAtender consultas de clientes con respecto a recepción y entrega de tarjetas.\r\n•\tElaborar documentos propios de las actividades del área.\r\n•\tElaborar reporte de producción y entregas para ser enviado al área de facturación en los plazos establecidos.\r\n•\tElaborar y archivar documentación interna y externa.\r\n•\tCoordinar con almacén y el cliente el abastecimiento oportuno de stock de formatería.\r\n•\tRealizar otras funciones que su jefe inmediato le asigne.\r\nREQUISITOS:\r\n\r\n•\tSecundaria completa.\r\n•\tExperiencia mínima de 1 año en el puesto realizando funciones similares.\r\n•\tManejo de Office a nivel intermedio o avanzado, de preferencia Excel.\r\n\r\nHorario de trabajo de Lunes a Viernes de 8:30am a 6:00pm y sábado 9am a 12:00 pm \r\n\r\nPresentarse el Viernes 17 de Enero a las 10:00 AM con DNI y CV impreso en Av. Morro Solar 1086 - Surco. Referencia: Prosegur de Panamericana Sur (Km. 8). Ingresar por Centro Bancario. Preguntar por Srta. Ratto	2014-01-17	2014-02-14	0.00	112	\N	0	0	146	2	2500.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:21:07.123722	UPDATE	postgres
79	2	48	50	\N	\N	¡Buscamos personas ambiciosas, interesado en ganar dinero!\r\nTe invitamos a formar parte de nuestro equipo!\r\nRequisitos:\r\n- Egresados del programa de certficación de caja.\r\n- Experiencia mínima de 1 año realizando labores en caja.\r\n- Buena actitud para atención y servicio al cliente.\r\n- Manejo de herramientas de cómputo a nivel usuario.\r\n- Disponibilidad a tiempo completo.\r\nOfrecemos:\r\n- Ingreso directo a planilla, bonos individuales y por trabajo en equipo.\r\n- Seguro de vida, utilidades, capacitaciones constantes.\r\n- Línea de carrera.\r\n- Descuentos especiales en compra de nuestros productos.\r\n- Reconocimientos nacionales e internacionales a nuestros mejores trabajadores y sus familias.\r\n\r\nAnímate, arriesgate, esfuérzate y triunfa tú puedes ser parte de este grupo de gente exitosa!!\r\n\r\nPara Barranco, Chorrillos, San Juan de Miraflores, Canevaro, Aviación, Surco, Surquillo, La Molina y Manchay.	2014-01-17	2014-02-14	0.00	112	\N	0	0	153	2	2200.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:30:35.493723	INSERT	postgres
80	2	48	50	\N	\N	¡Buscamos personas ambiciosas, interesado en ganar dinero!\r\nTe invitamos a formar parte de nuestro equipo!\r\nRequisitos:\r\n- Egresados del programa de certficación de caja.\r\n- Experiencia mínima de 1 año realizando labores en caja.\r\n- Buena actitud para atención y servicio al cliente.\r\n- Manejo de herramientas de cómputo a nivel usuario.\r\n- Disponibilidad a tiempo completo.\r\nOfrecemos:\r\n- Ingreso directo a planilla, bonos individuales y por trabajo en equipo.\r\n- Seguro de vida, utilidades, capacitaciones constantes.\r\n- Línea de carrera.\r\n- Descuentos especiales en compra de nuestros productos.\r\n- Reconocimientos nacionales e internacionales a nuestros mejores trabajadores y sus familias.\r\n\r\nAnímate, arriesgate, esfuérzate y triunfa tú puedes ser parte de este grupo de gente exitosa!!\r\n\r\nPara Barranco, Chorrillos, San Juan de Miraflores, Canevaro, Aviación, Surco, Surquillo, La Molina y Manchay.	2014-01-17	2014-02-14	0.00	112	\N	0	0	153	2	2200.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/360/IMG0.jpg	2014-01-17 16:30:35.493723	UPDATE	postgres
81	2	48	50	\N	\N	Con experiencia académica \r\n\r\nRequisitos:\r\n-Título Profesional nivel superior en Secretariado Ejecutivo.\r\n-Experiencia laboral ejerciendo funciones en el cargo.\r\n-Experiencia docente en el área secretarial. \r\n-Experiencia en elaboración de planes auriculares y sílabos por competencias. \r\n-Habilidad para liderar y motivar grupos humanos. \r\n-Disponibilidad a tiempo completo.\r\n\r\nPresentarse el martes 14 de enero de 3 a 7pm. en Av. San Borja Norte 294 . San Borja	2014-01-17	2014-02-14	0.00	113	\N	0	0	154	2	3600.00	\N	2	4	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	2014-01-17 16:32:10.817766	INSERT	postgres
\.


--
-- Name: aud_clasificado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('aud_clasificado_id_seq', 83, true);


--
-- Data for Name: aud_mail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aud_mail (id, destinatario, asunto, mensaje, fecha_hora) FROM stdin;
2	jerviver@hotmail.com	Prueba plantilla mail 2	Hola	2013-05-05 11:45:29.119
3	jerviver@hotmail.com	Prueba plantilla mail 3	a	2013-05-05 11:53:07.887
4	jerviver@hotmail.com	Prueba plantilla mail 4	4	2013-05-05 11:58:47.633
5	jerviver21@hotmail.com	p	p	2013-05-05 12:05:23.888
6	jerviver21@hotmail.com	p1	p1	2013-05-05 12:06:14.835
7	bejar.gabriela@gmail.com	Love you!	Hola mi amor!\r\nComo va tu dia? te estoy enviando un mensaje desde mi sistema es para probar el sistema y de paso decirte que te amo!!!\r\n\r\nBye,\r\n\r\nPd: estudia, y recuerda que tu eres el pilar de la familia, si tu no trabajas, nos quebramos!	2013-05-05 12:14:57.639
8	jerviver21@hotmail.com	Restauracion Clave Medical History System!	Ingrese a la Dirección : \n http://localhost:8080/template/restaura_clave.xhtml/usuarios/restaura_clave.xhtml \n\n Utilice el siguiente código para restaurar su clave:1231349684	2013-06-10 10:14:21.917
9	jerviver21@gmail.com	Activacion Usuario Sistema	Ingrese a la Dirección : \n http://localhost:8080/template/registro/activacion.xhtml \n\n Active el siguiente Nro de Usuario:131400000018\n( Copie el nro de licencia en el campo y presione el boton activar) \n\n\n Paideia Software. (Hacemos el mejor software!) \n\n Correo Automático por favor no responda a este correo.	2013-06-10 16:51:19.705
10	jerviver21@hotmail.com	Activacion Usuario Sistema	Ingrese a la Dirección : \n http://localhost:8080/clasificados/registro/activacion.xhtml \n\n Active el siguiente Nro de Usuario:131400000020\n( Copie el nro de licencia en el campo y presione el boton activar) \n\n\n Paideia Software. (Hacemos el mejor software!) \n\n Correo Automático por favor no responda a este correo.	2013-08-23 10:29:12.767
11	jerviver21@hotmail.com	Activacion Usuario Sistema	Ingrese a la Dirección : \n http://localhost:8080/registro/activacion.xhtml \n\n Active el siguiente Nro de Usuario:131400000021\n( Copie el nro de licencia en el campo y presione el boton activar) \n\n\n Paideia Software. (Hacemos el mejor software!) \n\n Correo Automático por favor no responda a este correo.	2013-10-15 04:18:21.754
\.


--
-- Name: aud_mail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('aud_mail_id_seq', 11, true);


--
-- Data for Name: aud_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aud_pedido (id, usuario, cod_pago, valor_total, id_estado, cod_confirmacion, id_entidad_pago, fecha_hora_pago, dni_cliente, nombre_cliente, fecha_vencimiento, tipo_pedido, fecha_hora, operacion, usuario_aud) FROM stdin;
1	jerviver21@gmail.com	\N	15.00	1	\N	1	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 10:12:45.313193	INSERT	postgres
2	jerviver21@gmail.com	000000000123	15.00	1	\N	1	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 10:12:45.313193	UPDATE	postgres
3	jerviver21@gmail.com	000000000123	15.00	2	\N	1	2014-01-16 00:00:00	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 10:13:23.717148	UPDATE	postgres
4	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 10:31:33.067912	INSERT	postgres
5	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 10:31:33.067912	UPDATE	postgres
6	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 10:42:21.066332	INSERT	postgres
7	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 10:42:21.066332	UPDATE	postgres
8	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 11:02:50.453888	INSERT	postgres
9	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 11:02:50.453888	UPDATE	postgres
10	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 11:17:11.944018	INSERT	postgres
11	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 11:17:11.944018	UPDATE	postgres
12	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 11:18:34.43023	INSERT	postgres
13	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 11:18:34.43023	UPDATE	postgres
14	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 11:21:20.652756	INSERT	postgres
15	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 11:21:20.652756	UPDATE	postgres
16	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 11:23:20.029864	INSERT	postgres
17	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 11:23:20.029864	UPDATE	postgres
19	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 11:30:54.700296	INSERT	postgres
20	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 11:30:54.700296	UPDATE	postgres
21	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 13:31:51.690397	INSERT	postgres
22	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 13:31:51.690397	UPDATE	postgres
23	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 13:43:19.62064	INSERT	postgres
24	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N	2014-01-16 13:43:19.62064	UPDATE	postgres
25	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 13:46:28.868308	INSERT	postgres
26	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 13:46:28.868308	UPDATE	postgres
27	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 13:48:33.63501	INSERT	postgres
28	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 13:48:33.63501	UPDATE	postgres
29	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 13:51:25.366035	INSERT	postgres
30	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS	2014-01-16 13:51:25.366035	UPDATE	postgres
32	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 10:25:01.245312	INSERT	postgres
33	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 10:25:01.245312	UPDATE	postgres
35	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 11:33:05.830929	INSERT	postgres
36	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 11:33:05.830929	UPDATE	postgres
37	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 11:35:58.335577	INSERT	postgres
38	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 11:35:58.335577	UPDATE	postgres
39	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 11:40:30.750155	INSERT	postgres
40	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 11:40:30.750155	UPDATE	postgres
41	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 11:45:47.718725	INSERT	postgres
42	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 11:45:47.718725	UPDATE	postgres
43	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 11:48:31.260469	INSERT	postgres
44	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 11:48:31.260469	UPDATE	postgres
45	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 12:30:19.041835	INSERT	postgres
46	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 12:30:19.041835	UPDATE	postgres
47	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 12:31:18.351169	INSERT	postgres
48	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 12:31:18.351169	UPDATE	postgres
49	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 12:32:14.045119	INSERT	postgres
50	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 12:32:14.045119	UPDATE	postgres
51	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 12:33:05.422146	INSERT	postgres
52	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 12:33:05.422146	UPDATE	postgres
53	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 12:47:12.919388	INSERT	postgres
54	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 12:47:12.919388	UPDATE	postgres
55	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 13:07:36.081672	INSERT	postgres
56	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 13:07:36.081672	UPDATE	postgres
57	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 13:09:57.687784	INSERT	postgres
58	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 13:09:57.687784	UPDATE	postgres
59	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 16:30:35.493723	INSERT	postgres
60	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 16:30:35.493723	UPDATE	postgres
61	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 16:32:10.817766	INSERT	postgres
62	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS	2014-01-17 16:32:10.817766	UPDATE	postgres
63	jerviver21@gmail.com	\N	0.00	1	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 16:36:33.466349	INSERT	postgres
64	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N	2014-01-17 16:36:33.466349	UPDATE	postgres
\.


--
-- Name: aud_pedido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('aud_pedido_id_seq', 64, true);


--
-- Data for Name: aud_sesion; Type: TABLE DATA; Schema: public; Owner: jbossuser
--

COPY aud_sesion (id, usr, operacion, fecha_hora) FROM stdin;
1	admin	INICIO	2013-05-01 11:40:58.516758
2	admin	FIN	2013-05-01 11:41:01.772712
3	admin	INICIO	2013-05-01 11:41:06.964551
4	admin	FIN	2013-05-01 11:55:15.598568
5	admin	INICIO	2013-05-01 11:57:36.398194
6	admin	FIN	2013-05-01 11:59:37.501201
7	guest	INICIO	2013-05-01 11:59:44.156003
8	guest	FIN	2013-05-01 12:11:25.950903
9	admin	INICIO	2013-05-01 12:16:35.825788
10	admin	FIN	2013-05-01 12:16:38.420371
11	admin	INICIO	2013-05-01 12:23:09.929701
12	admin	FIN	2013-05-01 12:46:41.911251
13	admin	INICIO	2013-05-02 13:59:22.917047
14	admin	FIN	2013-05-02 13:59:27.479591
15	admin	INICIO	2013-05-02 14:06:32.10003
16	admin	FIN	2013-05-02 14:06:35.444274
17	admin	INICIO	2013-05-02 14:06:48.391156
18	admin	FIN	2013-05-02 14:06:50.925313
19	admin	INICIO	2013-05-02 14:09:31.899986
20	admin	FIN	2013-05-02 14:09:34.764718
21	admin	INICIO	2013-05-02 14:09:43.804069
22	admin	FIN	2013-05-02 14:09:45.49509
23	admin	INICIO	2013-05-02 14:15:16.764485
24	admin	FIN	2013-05-02 14:15:18.936831
25	admin	INICIO	2013-05-05 11:38:01.196265
26	admin	FIN	2013-05-05 11:40:42.718661
27	admin	INICIO	2013-05-05 11:41:53.313036
28	admin	FIN	2013-05-05 11:44:48.829704
29	admin	INICIO	2013-05-05 11:45:11.494272
30	admin	FIN	2013-05-05 11:52:21.418058
31	admin	INICIO	2013-05-05 11:52:43.924485
32	admin	FIN	2013-05-05 11:57:43.466615
33	admin	INICIO	2013-05-05 11:58:22.87885
34	admin	FIN	2013-05-05 12:04:22.136113
35	admin	INICIO	2013-05-05 12:04:44.9116
36	admin	FIN	2013-05-05 12:45:29.304933
37	admin	INICIO	2013-06-07 19:47:13.227082
38	admin	FIN	2013-06-07 19:47:46.254612
39	admin	INICIO	2013-06-07 19:47:57.447855
40	admin	FIN	2013-06-07 19:48:41.476452
41	jerviver21@hotmail.com	INICIO	2013-06-10 09:55:40.851577
42	jerviver21@hotmail.com	FIN	2013-06-10 09:55:45.214902
43	admin	INICIO	2013-06-10 10:13:51.894898
44	admin	FIN	2013-06-10 10:13:58.225589
45	jerviver21@hotmail.com	INICIO	2013-06-10 10:15:47.677358
46	jerviver21@hotmail.com	FIN	2013-06-10 10:15:50.285204
47	admin	INICIO	2013-06-10 10:27:03.612191
48	admin	FIN	2013-06-10 10:57:37.253994
49	admin	INICIO	2013-06-10 11:21:28.768914
50	admin	FIN	2013-06-10 11:23:40.665855
51	jerviver21@hotmail.com	INICIO	2013-06-10 16:53:16.815388
52	jerviver21@hotmail.com	FIN	2013-06-10 16:53:21.0076
53	admin	INICIO	2013-06-10 16:53:27.699406
54	admin	FIN	2013-06-10 16:53:56.830382
55	jerviver21@gmail.com	INICIO	2013-06-10 16:59:43.51831
56	jerviver21@gmail.com	FIN	2013-06-10 17:29:48.608089
57	jerviver21@gmail.com	INICIO	2013-06-14 09:44:50.404349
58	jerviver21@gmail.com	FIN	2013-06-14 09:44:58.599792
59	admin	INICIO	2013-06-14 10:33:26.906573
60	admin	FIN	2013-06-14 10:35:33.66354
61	admin	INICIO	2013-06-14 10:35:57.360384
62	admin	FIN	2013-06-14 10:48:10.166161
63	jerviver21@gmail.com	INICIO	2013-06-14 10:48:49.222253
64	jerviver21@gmail.com	FIN	2013-06-14 10:48:54.083567
65	admin	INICIO	2013-06-14 10:49:01.427551
66	admin	FIN	2013-06-14 10:49:10.328931
67	jerviver21@gmail.com	INICIO	2013-06-14 17:49:26.230085
68	jerviver21@gmail.com	FIN	2013-06-14 17:52:03.413661
69	jerviver21@gmail.com	INICIO	2013-06-14 17:52:43.376759
70	jerviver21@gmail.com	FIN	2013-06-14 17:54:26.610181
71	jerviver21@gmail.com	INICIO	2013-06-14 17:54:48.659548
72	jerviver21@gmail.com	FIN	2013-06-14 17:56:50.984215
73	jerviver21@gmail.com	INICIO	2013-06-14 17:57:14.231105
74	jerviver21@gmail.com	FIN	2013-06-14 17:58:39.81533
75	jerviver21@gmail.com	INICIO	2013-06-14 17:59:01.808013
76	jerviver21@gmail.com	FIN	2013-06-14 18:03:42.115425
77	jerviver21@gmail.com	INICIO	2013-06-14 18:04:02.949215
78	jerviver21@gmail.com	FIN	2013-06-14 18:04:31.818157
79	jerviver21@gmail.com	INICIO	2013-06-14 18:04:55.003834
80	jerviver21@gmail.com	INICIO	2013-06-18 08:09:19.471601
81	jerviver21@gmail.com	FIN	2013-06-18 08:10:29.080035
82	jerviver21@gmail.com	INICIO	2013-06-18 08:10:57.931117
83	jerviver21@gmail.com	FIN	2013-06-18 08:42:37.785512
84	jerviver21@gmail.com	INICIO	2013-06-18 09:36:00.425358
85	jerviver21@gmail.com	FIN	2013-06-18 10:08:27.873475
86	jerviver21@gmail.com	INICIO	2013-06-18 11:31:25.793847
87	jerviver21@gmail.com	FIN	2013-06-18 11:34:42.750233
88	jerviver21@gmail.com	INICIO	2013-06-18 11:35:05.668546
89	jerviver21@gmail.com	FIN	2013-06-18 11:41:02.749925
90	jerviver21@gmail.com	INICIO	2013-06-18 11:41:30.086892
91	jerviver21@gmail.com	FIN	2013-06-18 11:46:01.503639
92	jerviver21@gmail.com	INICIO	2013-06-18 11:46:22.80808
93	jerviver21@gmail.com	FIN	2013-06-18 11:48:11.199596
94	jerviver21@gmail.com	INICIO	2013-06-18 11:48:32.620695
95	jerviver21@gmail.com	FIN	2013-06-18 11:50:01.902611
96	jerviver21@gmail.com	INICIO	2013-06-18 11:50:25.05578
97	jerviver21@gmail.com	FIN	2013-06-18 12:26:34.751668
98	jerviver21@gmail.com	INICIO	2013-06-18 12:27:00.595284
99	jerviver21@gmail.com	FIN	2013-06-18 12:27:39.17042
100	jerviver21@gmail.com	INICIO	2013-06-18 12:28:01.984996
101	jerviver21@gmail.com	FIN	2013-06-18 12:29:11.474401
102	jerviver21@gmail.com	INICIO	2013-06-18 12:29:32.635903
103	jerviver21@gmail.com	FIN	2013-06-18 12:30:35.290103
104	jerviver21@gmail.com	INICIO	2013-06-18 12:30:56.860501
105	jerviver21@gmail.com	FIN	2013-06-18 12:33:33.334065
106	jerviver21@gmail.com	INICIO	2013-06-18 12:33:54.132186
107	jerviver21@gmail.com	FIN	2013-06-18 13:04:38.057016
108	jerviver21@gmail.com	INICIO	2013-06-18 18:41:05.115881
109	jerviver21@gmail.com	FIN	2013-06-18 18:43:17.427286
110	jerviver21@gmail.com	INICIO	2013-06-18 18:44:49.353495
111	jerviver21@gmail.com	FIN	2013-06-18 19:15:38.391714
112	jerviver21@gmail.com	INICIO	2013-06-19 09:08:54.417363
113	jerviver21@gmail.com	FIN	2013-06-19 09:36:52.252984
114	jerviver21@gmail.com	INICIO	2013-06-19 09:37:15.978052
115	jerviver21@gmail.com	FIN	2013-06-19 09:40:24.808083
116	jerviver21@gmail.com	INICIO	2013-06-19 09:40:48.105149
117	jerviver21@gmail.com	FIN	2013-06-19 09:45:36.363008
118	jerviver21@gmail.com	INICIO	2013-06-19 09:45:58.660363
119	jerviver21@gmail.com	FIN	2013-06-19 09:55:39.046903
120	jerviver21@gmail.com	INICIO	2013-06-19 09:56:02.232146
121	jerviver21@gmail.com	FIN	2013-06-19 10:27:24.044518
122	jerviver21@gmail.com	INICIO	2013-06-19 10:28:05.274863
123	jerviver21@gmail.com	FIN	2013-06-19 10:32:09.803157
124	jerviver21@gmail.com	INICIO	2013-06-19 10:32:33.002998
125	jerviver21@gmail.com	FIN	2013-06-19 10:44:37.793363
126	jerviver21@gmail.com	INICIO	2013-06-19 10:45:01.733595
127	jerviver21@gmail.com	FIN	2013-06-19 10:47:16.623407
128	jerviver21@gmail.com	INICIO	2013-06-19 10:47:37.914337
129	jerviver21@gmail.com	FIN	2013-06-19 10:50:03.814023
130	jerviver21@gmail.com	INICIO	2013-06-19 10:50:24.676406
131	jerviver21@gmail.com	FIN	2013-06-19 10:52:02.893635
132	jerviver21@gmail.com	INICIO	2013-06-19 10:52:36.583083
133	jerviver21@gmail.com	FIN	2013-06-19 10:53:35.651766
134	jerviver21@gmail.com	INICIO	2013-06-19 10:53:58.172078
135	jerviver21@gmail.com	FIN	2013-06-19 10:56:46.543849
136	jerviver21@gmail.com	INICIO	2013-06-19 10:57:07.593215
137	jerviver21@gmail.com	FIN	2013-06-19 11:27:49.835728
138	jerviver21@gmail.com	INICIO	2013-06-19 12:21:37.349686
139	jerviver21@gmail.com	FIN	2013-06-19 12:33:06.922971
140	jerviver21@gmail.com	INICIO	2013-06-19 12:33:21.166785
141	jerviver21@gmail.com	FIN	2013-06-19 12:48:27.058636
142	admin	INICIO	2013-06-26 15:07:39.035339
143	admin	FIN	2013-06-26 15:10:12.386068
144	admin	INICIO	2013-06-26 15:10:31.969939
145	admin	FIN	2013-06-26 15:12:45.586745
146	admin	INICIO	2013-06-26 15:13:09.7742
147	admin	FIN	2013-06-26 15:19:09.871601
148	admin	INICIO	2013-06-26 15:19:31.673235
149	admin	FIN	2013-06-26 15:21:53.085164
150	admin	INICIO	2013-06-26 15:22:13.31896
151	admin	FIN	2013-06-26 15:23:30.089185
152	admin	INICIO	2013-06-26 15:23:56.555939
153	admin	FIN	2013-06-26 15:25:00.804831
154	admin	INICIO	2013-06-26 15:25:18.166729
155	admin	FIN	2013-06-26 15:27:04.994557
156	admin	INICIO	2013-06-26 15:27:25.7579
157	admin	FIN	2013-06-26 15:27:39.141896
158	jerviver21@gmail.com	INICIO	2013-06-26 15:27:47.396071
159	jerviver21@gmail.com	FIN	2013-06-26 15:40:34.709879
160	jerviver21@gmail.com	INICIO	2013-06-26 15:47:02.177634
161	jerviver21@gmail.com	FIN	2013-06-26 15:48:04.843049
162	jerviver21@gmail.com	INICIO	2013-06-26 15:48:25.379567
163	jerviver21@gmail.com	FIN	2013-06-26 16:23:06.393427
164	jerviver21@gmail.com	INICIO	2013-06-26 16:46:15.14355
165	jerviver21@gmail.com	FIN	2013-06-26 17:16:56.465493
166	jerviver21@gmail.com	INICIO	2013-06-26 17:31:30.38908
167	jerviver21@gmail.com	FIN	2013-06-26 17:31:35.302112
168	admin	INICIO	2013-06-26 17:31:41.845668
169	admin	FIN	2013-06-26 17:32:08.04013
170	admin	INICIO	2013-06-26 17:32:42.673705
171	admin	FIN	2013-06-26 17:32:50.500662
172	admin	INICIO	2013-06-26 18:23:35.613523
173	admin	FIN	2013-06-26 18:27:29.059946
174	jerviver21@gmail.com	INICIO	2013-06-26 18:28:06.821685
175	jerviver21@gmail.com	FIN	2013-06-26 18:28:47.526096
176	jerviver21@gmail.com	INICIO	2013-06-26 18:28:53.431043
177	jerviver21@gmail.com	FIN	2013-06-26 19:01:00.110978
178	jerviver21@gmail.com	INICIO	2013-06-26 19:01:24.151404
179	jerviver21@gmail.com	FIN	2013-06-26 19:02:50.210233
180	jerviver21@gmail.com	INICIO	2013-06-26 19:03:10.318551
181	jerviver21@gmail.com	FIN	2013-06-26 19:33:56.594849
182	jerviver21@gmail.com	INICIO	2013-06-26 19:49:08.321289
183	jerviver21@gmail.com	FIN	2013-06-26 19:50:04.459317
184	jerviver21@gmail.com	INICIO	2013-06-26 19:50:37.597939
185	jerviver21@gmail.com	FIN	2013-06-26 20:24:16.667555
186	jerviver21@gmail.com	INICIO	2013-06-26 22:09:35.777466
187	jerviver21@gmail.com	FIN	2013-06-26 22:13:18.409769
188	jerviver21@gmail.com	INICIO	2013-06-26 22:13:46.44339
189	jerviver21@gmail.com	FIN	2013-06-26 22:44:26.803925
190	jerviver21@gmail.com	INICIO	2013-06-26 23:46:59.362934
191	jerviver21@gmail.com	INICIO	2013-06-27 09:47:48.156143
192	jerviver21@gmail.com	FIN	2013-06-27 10:18:51.048292
193	jerviver21@gmail.com	INICIO	2013-06-27 11:13:21.977319
194	jerviver21@gmail.com	FIN	2013-06-27 11:14:56.767435
195	jerviver21@gmail.com	INICIO	2013-06-27 11:15:17.806629
196	jerviver21@gmail.com	FIN	2013-06-27 11:29:44.112766
197	jerviver21@gmail.com	INICIO	2013-06-27 11:30:05.05197
198	jerviver21@gmail.com	FIN	2013-06-27 11:33:37.152373
199	jerviver21@gmail.com	INICIO	2013-06-27 11:34:05.63139
200	jerviver21@gmail.com	FIN	2013-06-27 12:04:16.087253
201	jerviver21@gmail.com	INICIO	2013-06-27 12:04:38.081164
202	jerviver21@gmail.com	FIN	2013-06-27 12:11:38.109668
203	jerviver21@gmail.com	INICIO	2013-06-27 12:11:58.555933
204	jerviver21@gmail.com	FIN	2013-06-27 12:42:41.222893
205	jerviver21@gmail.com	INICIO	2013-06-27 12:52:43.685759
206	jerviver21@gmail.com	FIN	2013-06-27 12:53:55.301692
207	jerviver21@gmail.com	INICIO	2013-06-27 12:54:16.425643
208	jerviver21@gmail.com	FIN	2013-06-27 12:54:58.232841
209	jerviver21@gmail.com	INICIO	2013-06-27 12:55:21.099385
210	jerviver21@gmail.com	FIN	2013-06-27 12:58:49.822814
211	jerviver21@gmail.com	INICIO	2013-06-27 12:59:22.113717
212	jerviver21@gmail.com	FIN	2013-06-27 13:03:25.740321
213	jerviver21@gmail.com	INICIO	2013-06-27 13:04:06.983712
214	jerviver21@gmail.com	FIN	2013-06-27 13:15:02.975029
215	jerviver21@gmail.com	INICIO	2013-06-27 13:15:26.709574
216	jerviver21@gmail.com	FIN	2013-06-27 13:16:18.924127
217	jerviver21@gmail.com	INICIO	2013-06-27 13:16:39.308517
218	jerviver21@gmail.com	FIN	2013-06-27 13:41:27.9012
219	jerviver21@gmail.com	INICIO	2013-06-27 13:41:50.348086
220	jerviver21@gmail.com	FIN	2013-06-27 13:50:46.808982
221	jerviver21@gmail.com	INICIO	2013-06-27 13:51:12.057019
222	jerviver21@gmail.com	FIN	2013-06-27 13:55:03.771542
223	jerviver21@gmail.com	INICIO	2013-06-27 13:55:38.706278
224	jerviver21@gmail.com	FIN	2013-06-27 14:27:11.332568
225	jerviver21@gmail.com	INICIO	2013-06-28 10:08:39.803094
226	jerviver21@gmail.com	FIN	2013-06-28 10:39:12.456339
227	jerviver21@gmail.com	INICIO	2013-06-28 11:28:24.235949
228	jerviver21@gmail.com	FIN	2013-06-28 11:30:42.283783
229	jerviver21@gmail.com	INICIO	2013-06-28 11:31:03.787775
230	jerviver21@gmail.com	FIN	2013-06-28 11:32:17.345442
231	jerviver21@gmail.com	FIN	2013-06-28 11:35:02.804321
232	jerviver21@gmail.com	INICIO	2013-06-28 11:35:22.947862
233	jerviver21@gmail.com	FIN	2013-06-28 11:36:25.92385
234	jerviver21@gmail.com	INICIO	2013-06-28 11:36:43.914682
235	jerviver21@gmail.com	FIN	2013-06-28 11:37:36.296784
236	jerviver21@gmail.com	INICIO	2013-06-28 11:37:56.888981
237	jerviver21@gmail.com	FIN	2013-06-28 11:39:39.287513
238	jerviver21@gmail.com	INICIO	2013-06-28 11:39:57.887314
239	jerviver21@gmail.com	FIN	2013-06-28 11:41:05.626982
240	jerviver21@gmail.com	INICIO	2013-06-28 11:41:23.335649
241	jerviver21@gmail.com	FIN	2013-06-28 11:42:57.105454
242	jerviver21@gmail.com	INICIO	2013-06-28 11:43:15.641966
243	jerviver21@gmail.com	FIN	2013-06-28 11:44:19.694677
244	jerviver21@gmail.com	INICIO	2013-06-28 11:44:37.335448
245	jerviver21@gmail.com	FIN	2013-06-28 11:46:49.890593
246	jerviver21@gmail.com	INICIO	2013-06-28 11:47:08.92509
247	jerviver21@gmail.com	FIN	2013-06-28 11:48:03.474922
248	jerviver21@gmail.com	INICIO	2013-06-28 11:49:10.362287
249	jerviver21@gmail.com	FIN	2013-06-28 11:49:41.800381
250	jerviver21@gmail.com	FIN	2013-06-28 11:53:27.41395
251	jerviver21@gmail.com	INICIO	2013-06-28 11:53:47.633847
252	jerviver21@gmail.com	FIN	2013-06-28 15:48:20.005878
253	jerviver21@gmail.com	INICIO	2013-07-01 19:59:21.958561
254	jerviver21@gmail.com	FIN	2013-07-01 20:30:47.133959
255	jerviver21@gmail.com	INICIO	2013-07-01 21:11:33.701443
256	jerviver21@gmail.com	FIN	2013-07-01 21:45:47.228933
257	jerviver21@gmail.com	INICIO	2013-07-02 08:35:45.040149
258	jerviver21@gmail.com	FIN	2013-07-02 09:07:38.398938
259	jerviver21@gmail.com	INICIO	2013-07-02 12:48:58.398627
260	jerviver21@gmail.com	FIN	2013-07-02 12:49:35.228791
261	jerviver21@gmail.com	INICIO	2013-07-02 12:50:05.517934
262	jerviver21@gmail.com	FIN	2013-07-02 12:51:03.921828
263	jerviver21@gmail.com	INICIO	2013-07-02 12:51:45.338467
264	jerviver21@gmail.com	FIN	2013-07-02 12:52:40.718477
265	jerviver21@gmail.com	INICIO	2013-07-02 12:53:05.338276
266	jerviver21@gmail.com	FIN	2013-07-02 13:23:48.652641
267	jerviver21@gmail.com	INICIO	2013-07-02 16:51:52.247823
268	jerviver21@gmail.com	FIN	2013-07-02 17:02:00.950572
269	jerviver21@gmail.com	INICIO	2013-07-02 17:02:24.390606
270	jerviver21@gmail.com	FIN	2013-07-02 17:05:25.410277
271	jerviver21@gmail.com	INICIO	2013-07-02 17:05:44.876343
272	jerviver21@gmail.com	FIN	2013-07-02 17:07:45.943117
273	jerviver21@gmail.com	INICIO	2013-07-02 17:08:06.4387
274	jerviver21@gmail.com	FIN	2013-07-02 17:09:23.441299
275	jerviver21@gmail.com	INICIO	2013-07-02 17:09:28.310731
276	jerviver21@gmail.com	FIN	2013-07-02 17:19:47.996389
277	jerviver21@gmail.com	INICIO	2013-07-02 17:20:16.054327
278	jerviver21@gmail.com	FIN	2013-07-02 17:59:58.87712
279	jerviver21@gmail.com	INICIO	2013-07-02 18:15:39.229291
280	jerviver21@gmail.com	FIN	2013-07-02 18:16:25.847357
281	jerviver21@gmail.com	INICIO	2013-07-02 18:16:49.724438
282	jerviver21@gmail.com	FIN	2013-07-02 18:23:26.968245
283	jerviver21@gmail.com	INICIO	2013-07-02 18:24:02.483236
284	jerviver21@gmail.com	FIN	2013-07-02 18:25:05.350622
285	jerviver21@gmail.com	INICIO	2013-07-02 18:25:25.583027
286	jerviver21@gmail.com	FIN	2013-07-02 18:26:15.230575
287	jerviver21@gmail.com	INICIO	2013-07-02 18:26:36.905655
288	jerviver21@gmail.com	FIN	2013-07-02 18:57:18.958488
289	jerviver21@gmail.com	INICIO	2013-07-03 09:43:53.250173
290	jerviver21@gmail.com	FIN	2013-07-03 09:44:53.96679
291	jerviver21@gmail.com	INICIO	2013-07-03 09:45:26.149673
292	jerviver21@gmail.com	FIN	2013-07-03 09:47:45.814726
293	jerviver21@gmail.com	INICIO	2013-07-03 09:48:05.200587
294	jerviver21@gmail.com	FIN	2013-07-03 09:51:30.125162
295	jerviver21@gmail.com	INICIO	2013-07-03 09:51:50.717638
296	jerviver21@gmail.com	FIN	2013-07-03 10:58:39.941177
297	jerviver21@gmail.com	INICIO	2013-07-03 11:14:04.823331
298	jerviver21@gmail.com	FIN	2013-07-03 11:20:35.274024
299	jerviver21@gmail.com	INICIO	2013-07-03 11:20:57.0294
300	jerviver21@gmail.com	FIN	2013-07-03 11:24:31.743743
301	jerviver21@gmail.com	INICIO	2013-07-03 11:24:56.280997
302	jerviver21@gmail.com	FIN	2013-07-03 11:27:30.375865
303	jerviver21@gmail.com	INICIO	2013-07-03 11:27:51.477001
304	jerviver21@gmail.com	FIN	2013-07-03 11:29:32.405456
305	jerviver21@gmail.com	INICIO	2013-07-03 11:29:38.856166
306	jerviver21@gmail.com	FIN	2013-07-03 12:00:40.026294
307	jerviver21@gmail.com	INICIO	2013-07-03 13:25:14.250916
308	jerviver21@gmail.com	FIN	2013-07-03 13:26:20.489455
309	jerviver21@gmail.com	INICIO	2013-07-03 13:26:37.622789
310	jerviver21@gmail.com	FIN	2013-07-03 13:27:22.231423
311	jerviver21@gmail.com	INICIO	2013-07-03 13:27:42.645984
312	jerviver21@gmail.com	FIN	2013-07-03 13:28:55.610474
313	jerviver21@gmail.com	INICIO	2013-07-03 13:29:16.176653
314	jerviver21@gmail.com	FIN	2013-07-03 14:50:00.186613
315	jerviver21@gmail.com	INICIO	2013-07-05 09:24:22.561306
316	jerviver21@gmail.com	FIN	2013-07-05 09:55:16.345272
317	jerviver21@gmail.com	INICIO	2013-07-05 11:39:19.20199
318	jerviver21@gmail.com	FIN	2013-07-05 11:40:15.614649
319	jerviver21@gmail.com	INICIO	2013-07-05 11:40:35.536241
320	jerviver21@gmail.com	FIN	2013-07-05 12:11:12.095202
321	jerviver21@gmail.com	INICIO	2013-07-05 12:11:34.413363
322	jerviver21@gmail.com	FIN	2013-07-05 12:13:14.951832
323	jerviver21@gmail.com	INICIO	2013-07-05 12:13:35.011963
324	jerviver21@gmail.com	FIN	2013-07-05 12:14:26.534811
325	jerviver21@gmail.com	INICIO	2013-07-05 12:14:45.179796
326	jerviver21@gmail.com	FIN	2013-07-05 12:16:06.05912
327	jerviver21@gmail.com	INICIO	2013-07-05 12:16:24.568954
328	jerviver21@gmail.com	FIN	2013-07-05 12:21:22.993664
329	jerviver21@gmail.com	INICIO	2013-07-05 12:21:42.171611
330	jerviver21@gmail.com	FIN	2013-07-05 12:23:23.993575
331	jerviver21@gmail.com	INICIO	2013-07-05 12:23:43.208323
332	jerviver21@gmail.com	FIN	2013-07-05 12:30:18.125999
333	jerviver21@gmail.com	INICIO	2013-07-05 12:30:39.104053
334	jerviver21@gmail.com	FIN	2013-07-05 12:31:36.674019
335	jerviver21@gmail.com	INICIO	2013-07-05 12:31:54.499347
336	jerviver21@gmail.com	FIN	2013-07-05 12:34:37.463484
337	jerviver21@gmail.com	INICIO	2013-07-05 12:34:56.728288
338	jerviver21@gmail.com	FIN	2013-07-05 12:37:12.822357
339	jerviver21@gmail.com	INICIO	2013-07-05 12:37:31.704573
340	jerviver21@gmail.com	FIN	2013-07-05 12:49:00.484872
341	jerviver21@gmail.com	INICIO	2013-07-05 12:49:18.394896
342	jerviver21@gmail.com	FIN	2013-07-05 12:53:26.157043
343	jerviver21@gmail.com	INICIO	2013-07-05 12:53:44.231281
344	jerviver21@gmail.com	FIN	2013-07-05 12:57:15.195826
345	jerviver21@gmail.com	INICIO	2013-07-05 12:57:34.071897
346	jerviver21@gmail.com	FIN	2013-07-05 13:00:22.343442
347	jerviver21@gmail.com	INICIO	2013-07-05 13:00:42.296689
348	jerviver21@gmail.com	FIN	2013-07-05 13:15:22.783697
349	jerviver21@gmail.com	INICIO	2013-07-05 13:20:22.284523
350	jerviver21@gmail.com	FIN	2013-07-05 14:09:06.709634
351	jerviver21@gmail.com	INICIO	2013-07-05 15:28:20.031564
352	jerviver21@gmail.com	FIN	2013-07-05 15:32:36.72402
353	jerviver21@gmail.com	INICIO	2013-07-05 15:32:59.290544
354	jerviver21@gmail.com	FIN	2013-07-05 15:34:46.047252
355	jerviver21@gmail.com	INICIO	2013-07-05 15:35:06.641056
356	jerviver21@gmail.com	FIN	2013-07-05 15:36:01.118768
357	jerviver21@gmail.com	INICIO	2013-07-05 15:36:21.329517
358	jerviver21@gmail.com	FIN	2013-07-05 15:48:54.40779
359	jerviver21@gmail.com	INICIO	2013-07-05 15:49:03.384398
360	jerviver21@gmail.com	FIN	2013-07-05 15:53:22.351597
361	jerviver21@hotmail.com	INICIO	2013-07-05 15:54:09.823975
362	jerviver21@hotmail.com	FIN	2013-07-05 15:56:37.348966
363	jerviver21@hotmail.com	INICIO	2013-07-05 15:56:46.783852
364	jerviver21@hotmail.com	FIN	2013-07-05 16:01:50.251331
365	jerviver21@gmail.com	INICIO	2013-07-05 19:30:23.939836
366	jerviver21@gmail.com	FIN	2013-07-05 19:31:27.084354
367	jerviver21@gmail.com	INICIO	2013-07-05 19:31:32.49615
368	jerviver21@gmail.com	FIN	2013-07-05 19:48:16.783215
369	jerviver21@gmail.com	INICIO	2013-07-05 19:49:46.152319
370	jerviver21@gmail.com	FIN	2013-07-05 20:23:27.049807
371	jerviver21@gmail.com	INICIO	2013-07-05 20:25:57.062662
372	jerviver21@gmail.com	FIN	2013-07-05 20:28:34.005958
373	jerviver21@gmail.com	INICIO	2013-07-05 20:28:59.717827
374	jerviver21@gmail.com	FIN	2013-07-05 20:59:37.502603
375	jerviver21@gmail.com	INICIO	2013-07-06 23:13:27.755813
376	jerviver21@gmail.com	FIN	2013-07-06 23:25:04.209043
377	jerviver21@gmail.com	INICIO	2013-07-06 23:25:26.673037
378	jerviver21@gmail.com	FIN	2013-07-06 23:28:06.200254
379	jerviver21@gmail.com	INICIO	2013-07-06 23:28:31.122931
380	jerviver21@gmail.com	FIN	2013-07-06 23:31:04.820348
381	jerviver21@gmail.com	INICIO	2013-07-06 23:31:25.998234
382	jerviver21@gmail.com	FIN	2013-07-06 23:34:20.59914
383	jerviver21@gmail.com	INICIO	2013-07-06 23:34:43.092027
384	jerviver21@gmail.com	FIN	2013-07-06 23:38:18.132506
385	jerviver21@gmail.com	INICIO	2013-07-06 23:38:38.648879
386	jerviver21@gmail.com	FIN	2013-07-06 23:39:43.588941
387	jerviver21@gmail.com	INICIO	2013-07-06 23:40:04.319413
388	jerviver21@gmail.com	INICIO	2013-07-07 18:21:33.525589
389	jerviver21@gmail.com	FIN	2013-07-07 18:52:39.645765
390	jerviver21@gmail.com	INICIO	2013-07-07 18:57:45.464762
391	jerviver21@gmail.com	FIN	2013-07-07 19:30:32.028846
392	jerviver21@gmail.com	INICIO	2013-07-07 19:30:56.460819
393	jerviver21@gmail.com	INICIO	2013-07-15 09:43:08.236887
394	jerviver21@gmail.com	FIN	2013-07-15 10:03:05.106355
395	jerviver21@gmail.com	INICIO	2013-07-15 10:04:14.735657
396	jerviver21@gmail.com	FIN	2013-07-15 10:36:19.285684
397	jerviver21@gmail.com	INICIO	2013-07-15 11:52:57.318402
398	jerviver21@gmail.com	FIN	2013-07-15 11:54:39.490987
399	jerviver21@gmail.com	INICIO	2013-07-15 11:55:04.315425
400	jerviver21@gmail.com	FIN	2013-07-15 11:56:18.523723
401	jerviver21@gmail.com	INICIO	2013-07-15 11:56:38.466896
402	jerviver21@gmail.com	FIN	2013-07-15 11:57:32.682637
403	jerviver21@gmail.com	INICIO	2013-07-15 11:57:55.46049
404	jerviver21@gmail.com	INICIO	2013-07-16 09:52:25.146502
405	jerviver21@gmail.com	FIN	2013-07-16 10:00:09.626386
406	jerviver21@gmail.com	INICIO	2013-07-16 10:01:16.555967
407	jerviver21@gmail.com	FIN	2013-07-16 10:07:49.024062
408	jerviver21@gmail.com	INICIO	2013-07-16 10:08:15.688766
409	jerviver21@gmail.com	FIN	2013-07-16 10:38:59.995786
410	jerviver21@gmail.com	INICIO	2013-07-16 12:49:36.905544
411	jerviver21@gmail.com	FIN	2013-07-16 12:51:10.762321
412	jerviver21@gmail.com	INICIO	2013-07-16 12:51:38.492433
413	jerviver21@gmail.com	FIN	2013-07-16 12:53:09.152473
414	jerviver21@gmail.com	INICIO	2013-07-16 12:53:37.020508
415	jerviver21@gmail.com	FIN	2013-07-16 12:55:54.911218
416	jerviver21@gmail.com	INICIO	2013-07-16 12:56:20.630812
417	jerviver21@gmail.com	FIN	2013-07-16 13:00:47.454434
418	admin	INICIO	2013-07-16 13:00:58.029023
419	admin	FIN	2013-07-16 13:31:59.332817
420	jerviver21@gmail.com	INICIO	2013-07-19 11:27:44.7757
421	jerviver21@gmail.com	FIN	2013-07-19 11:36:50.669359
422	jerviver21@gmail.com	INICIO	2013-07-19 11:37:10.687733
423	jerviver21@gmail.com	FIN	2013-07-19 11:39:40.204898
424	jerviver21@gmail.com	INICIO	2013-07-19 11:40:00.366863
425	jerviver21@gmail.com	FIN	2013-07-19 11:43:57.407856
426	jerviver21@gmail.com	INICIO	2013-07-19 11:44:16.580034
427	jerviver21@gmail.com	FIN	2013-07-19 11:45:59.528991
428	admin	INICIO	2013-07-19 11:46:04.593729
429	admin	FIN	2013-07-19 11:46:48.949087
430	admin	INICIO	2013-07-19 11:47:19.504267
431	admin	FIN	2013-07-19 11:50:44.101759
432	jerviver21@gmail.com	INICIO	2013-07-19 11:51:07.99476
433	jerviver21@gmail.com	FIN	2013-07-19 12:00:25.022291
434	jerviver21@gmail.com	INICIO	2013-07-19 12:00:30.237475
435	jerviver21@gmail.com	FIN	2013-07-19 12:04:15.568147
436	jerviver21@gmail.com	INICIO	2013-07-19 12:04:42.566884
437	jerviver21@gmail.com	FIN	2013-07-19 12:04:54.207503
438	admin	INICIO	2013-08-09 12:14:50.350736
439	admin	FIN	2013-08-09 12:45:28.41746
440	jerviver21@gmail.com	INICIO	2013-08-10 07:42:06.21249
441	jerviver21@gmail.com	FIN	2013-08-10 08:00:03.167521
442	jerviver21@gmail.com	INICIO	2013-08-10 08:00:28.698997
443	jerviver21@gmail.com	FIN	2013-08-10 08:04:50.206578
444	jerviver21@gmail.com	INICIO	2013-08-10 08:05:14.097036
445	jerviver21@gmail.com	FIN	2013-08-10 08:44:10.219641
446	jerviver21@gmail.com	INICIO	2013-08-10 08:44:33.687645
447	jerviver21@gmail.com	FIN	2013-08-10 08:56:45.203328
448	jerviver21@gmail.com	INICIO	2013-08-10 08:57:09.089123
449	jerviver21@gmail.com	FIN	2013-08-10 09:00:28.515846
450	jerviver21@gmail.com	INICIO	2013-08-10 09:00:49.111824
451	jerviver21@gmail.com	FIN	2013-08-10 09:02:03.084813
452	jerviver21@gmail.com	INICIO	2013-08-10 09:02:24.216661
453	jerviver21@gmail.com	FIN	2013-08-10 09:07:04.711397
454	jerviver21@gmail.com	INICIO	2013-08-10 09:07:25.974875
455	jerviver21@gmail.com	FIN	2013-08-10 09:10:49.033392
456	jerviver21@gmail.com	INICIO	2013-08-10 09:11:09.566861
457	jerviver21@gmail.com	FIN	2013-08-10 09:13:53.261988
458	jerviver21@gmail.com	INICIO	2013-08-10 09:14:14.787947
459	jerviver21@gmail.com	FIN	2013-08-10 09:16:28.733484
460	jerviver21@gmail.com	INICIO	2013-08-10 09:16:49.289643
461	jerviver21@gmail.com	FIN	2013-08-10 09:50:31.896906
462	jerviver21@gmail.com	INICIO	2013-08-10 09:52:55.068638
463	jerviver21@gmail.com	FIN	2013-08-10 10:10:47.522779
464	jerviver21@gmail.com	INICIO	2013-08-10 10:11:10.861559
465	jerviver21@gmail.com	FIN	2013-08-10 10:14:02.57009
466	jerviver21@gmail.com	INICIO	2013-08-10 10:14:24.207312
467	jerviver21@gmail.com	FIN	2013-08-10 10:17:52.884068
468	jerviver21@gmail.com	INICIO	2013-08-10 10:18:13.297189
469	jerviver21@gmail.com	FIN	2013-08-10 11:30:02.019008
470	jerviver21@gmail.com	INICIO	2013-08-10 13:19:01.633503
471	jerviver21@gmail.com	FIN	2013-08-10 13:20:53.198416
472	jerviver21@gmail.com	INICIO	2013-08-10 13:21:25.049276
473	jerviver21@gmail.com	FIN	2013-08-10 13:22:23.876089
474	jerviver21@gmail.com	INICIO	2013-08-10 13:22:43.886899
475	jerviver21@gmail.com	FIN	2013-08-10 13:23:14.831059
476	jerviver21@gmail.com	INICIO	2013-08-10 13:23:19.395118
477	jerviver21@gmail.com	FIN	2013-08-10 13:29:14.69278
478	jerviver21@gmail.com	INICIO	2013-08-10 13:30:32.393632
479	jerviver21@gmail.com	FIN	2013-08-10 13:34:07.101662
480	jerviver21@gmail.com	INICIO	2013-08-11 22:30:18.994212
481	jerviver21@gmail.com	FIN	2013-08-11 23:10:57.537867
482	jerviver21@gmail.com	INICIO	2013-08-12 12:58:03.754777
483	jerviver21@gmail.com	FIN	2013-08-12 13:51:24.02992
484	jerviver21@gmail.com	INICIO	2013-08-12 14:12:15.33792
485	jerviver21@gmail.com	FIN	2013-08-12 14:45:24.118908
486	jerviver21@gmail.com	INICIO	2013-08-12 16:24:46.71327
487	jerviver21@gmail.com	FIN	2013-08-12 17:25:24.29769
488	jerviver21@gmail.com	INICIO	2013-08-13 19:54:26.789514
489	jerviver21@gmail.com	FIN	2013-08-13 20:25:17.579
490	jerviver21@gmail.com	INICIO	2013-08-18 11:57:30.18856
491	jerviver21@gmail.com	FIN	2013-08-18 12:34:51.130939
492	jerviver21@gmail.com	INICIO	2013-08-19 11:12:31.070416
493	jerviver21@gmail.com	FIN	2013-08-19 11:23:11.37633
494	jerviver21@gmail.com	FIN	2013-08-19 11:25:16.588065
495	jerviver21@gmail.com	FIN	2013-08-19 11:25:55.555704
496	admin	INICIO	2013-08-19 11:26:22.415734
497	admin	FIN	2013-08-19 11:36:19.429585
498	admin	INICIO	2013-08-19 11:36:44.90904
499	admin	FIN	2013-08-19 11:39:10.554324
500	jerviver21@gmail.com	INICIO	2013-08-19 13:15:36.426879
501	jerviver21@gmail.com	FIN	2013-08-19 13:16:45.037241
502	asesor1	INICIO	2013-08-19 13:17:57.773565
503	asesor1	FIN	2013-08-19 13:47:23.229815
504	asesor1	INICIO	2013-08-19 13:47:44.841651
505	asesor1	FIN	2013-08-19 13:50:29.850104
506	asesor1	INICIO	2013-08-19 13:50:56.988741
507	asesor1	FIN	2013-08-19 13:51:55.149769
508	asesor1	INICIO	2013-08-19 13:52:14.814353
509	asesor1	FIN	2013-08-19 13:56:10.618221
510	asesor1	INICIO	2013-08-19 13:56:31.607512
511	asesor1	FIN	2013-08-19 13:58:09.801456
512	asesor1	INICIO	2013-08-19 13:58:29.870808
513	asesor1	FIN	2013-08-19 14:29:16.548246
514	jerviver21@gmail.com	INICIO	2013-08-19 22:53:12.817632
515	jerviver21@gmail.com	FIN	2013-08-19 22:55:41.238995
516	asesor1	INICIO	2013-08-19 22:57:30.2885
517	asesor1	FIN	2013-08-19 23:05:04.356852
518	asesor1	INICIO	2013-08-19 23:11:36.933793
519	asesor1	FIN	2013-08-19 23:12:59.238697
520	asesor1	INICIO	2013-08-19 23:13:25.686984
521	asesor1	FIN	2013-08-19 23:44:07.029857
522	jerviver21@gmail.com	INICIO	2013-08-20 11:09:35.014475
523	jerviver21@gmail.com	FIN	2013-08-20 11:40:47.228202
524	jerviver21@gmail.com	INICIO	2013-08-20 11:59:41.659043
525	jerviver21@gmail.com	FIN	2013-08-20 12:08:47.270738
526	jerviver21@gmail.com	INICIO	2013-08-20 12:09:08.976917
527	jerviver21@gmail.com	FIN	2013-08-20 12:16:04.747541
528	jerviver21@gmail.com	INICIO	2013-08-20 12:16:27.310001
529	jerviver21@gmail.com	FIN	2013-08-20 12:53:26.30917
530	jerviver21@gmail.com	INICIO	2013-08-20 13:15:29.808444
531	jerviver21@gmail.com	FIN	2013-08-20 13:28:48.84912
532	jerviver21@gmail.com	INICIO	2013-08-20 13:29:10.906514
533	jerviver21@gmail.com	FIN	2013-08-20 13:52:37.277404
534	jerviver21@gmail.com	INICIO	2013-08-20 13:53:00.520404
535	jerviver21@gmail.com	FIN	2013-08-20 14:06:47.122205
536	jerviver21@gmail.com	INICIO	2013-08-20 14:07:10.259721
537	jerviver21@gmail.com	FIN	2013-08-20 14:07:45.604065
538	jerviver21@gmail.com	INICIO	2013-08-20 14:08:09.739232
539	jerviver21@gmail.com	FIN	2013-08-20 14:22:31.692003
540	jerviver21@gmail.com	INICIO	2013-08-20 14:22:51.039238
541	jerviver21@gmail.com	FIN	2013-08-20 14:42:02.838614
542	jerviver21@gmail.com	INICIO	2013-08-20 14:42:22.162098
543	jerviver21@gmail.com	FIN	2013-08-20 15:11:17.88826
544	jerviver21@gmail.com	INICIO	2013-08-20 15:11:40.829611
545	jerviver21@gmail.com	FIN	2013-08-20 15:23:01.01907
546	jerviver21@gmail.com	INICIO	2013-08-20 15:23:23.581016
547	jerviver21@gmail.com	FIN	2013-08-20 15:56:07.480632
548	jerviver21@gmail.com	INICIO	2013-08-20 18:18:47.87244
549	jerviver21@gmail.com	FIN	2013-08-20 18:28:44.131061
550	jerviver21@gmail.com	INICIO	2013-08-20 18:29:07.461734
551	jerviver21@gmail.com	FIN	2013-08-20 18:34:57.901386
552	jerviver21@gmail.com	INICIO	2013-08-20 18:35:20.098393
553	jerviver21@gmail.com	FIN	2013-08-20 19:25:43.094514
554	jerviver21@gmail.com	INICIO	2013-08-20 19:26:05.42931
555	jerviver21@gmail.com	FIN	2013-08-20 19:29:12.621063
556	jerviver21@gmail.com	INICIO	2013-08-20 19:29:34.913914
557	jerviver21@gmail.com	FIN	2013-08-20 19:30:30.082292
558	jerviver21@gmail.com	INICIO	2013-08-20 19:30:51.759883
559	jerviver21@gmail.com	FIN	2013-08-20 19:31:24.348264
560	jerviver21@gmail.com	INICIO	2013-08-20 19:31:44.530713
561	jerviver21@gmail.com	FIN	2013-08-20 19:32:55.508666
562	jerviver21@gmail.com	INICIO	2013-08-20 19:33:15.503834
563	jerviver21@gmail.com	FIN	2013-08-20 19:34:27.721692
564	jerviver21@gmail.com	INICIO	2013-08-20 19:34:51.652722
565	jerviver21@gmail.com	FIN	2013-08-20 19:35:54.467054
566	jerviver21@gmail.com	INICIO	2013-08-20 19:36:16.970514
567	jerviver21@gmail.com	FIN	2013-08-20 19:37:14.400309
568	jerviver21@gmail.com	INICIO	2013-08-20 19:37:37.226945
569	jerviver21@gmail.com	FIN	2013-08-20 19:45:41.887669
570	jerviver21@gmail.com	INICIO	2013-08-20 19:46:02.595061
571	jerviver21@gmail.com	FIN	2013-08-20 19:46:28.80091
572	jerviver21@gmail.com	INICIO	2013-08-20 19:46:56.309139
573	jerviver21@gmail.com	FIN	2013-08-20 20:17:38.113061
574	jerviver21@gmail.com	INICIO	2013-08-20 22:07:56.340119
575	jerviver21@gmail.com	FIN	2013-08-20 22:12:08.698399
576	jerviver21@gmail.com	INICIO	2013-08-20 22:13:02.982654
577	jerviver21@gmail.com	FIN	2013-08-20 22:16:41.578714
578	jerviver21@gmail.com	INICIO	2013-08-20 22:19:56.39738
579	jerviver21@gmail.com	FIN	2013-08-20 22:29:44.709616
580	jerviver21@gmail.com	INICIO	2013-08-20 22:30:10.04483
581	jerviver21@gmail.com	FIN	2013-08-20 22:33:11.762677
582	jerviver21@gmail.com	INICIO	2013-08-20 22:33:36.303498
583	jerviver21@gmail.com	FIN	2013-08-20 23:04:19.4128
584	jerviver21@gmail.com	INICIO	2013-08-20 23:58:27.159703
585	jerviver21@gmail.com	FIN	2013-08-21 00:29:19.504352
586	admin	INICIO	2013-08-21 10:44:46.101527
587	admin	FIN	2013-08-21 11:17:24.193198
588	jerviver21@gmail.com	INICIO	2013-08-21 12:05:55.072455
589	jerviver21@gmail.com	FIN	2013-08-21 12:06:36.72575
590	jerviver21@gmail.com	INICIO	2013-08-21 12:10:17.828145
591	jerviver21@gmail.com	FIN	2013-08-21 12:11:20.767597
592	jerviver21@gmail.com	INICIO	2013-08-21 12:11:45.059244
593	jerviver21@gmail.com	FIN	2013-08-21 12:13:13.804884
594	jerviver21@gmail.com	INICIO	2013-08-21 12:13:37.718072
595	jerviver21@gmail.com	FIN	2013-08-21 12:46:24.869061
596	jerviver21@gmail.com	INICIO	2013-08-21 12:52:08.88628
597	jerviver21@gmail.com	FIN	2013-08-21 12:53:26.365887
598	jerviver21@gmail.com	INICIO	2013-08-21 12:53:49.405248
599	jerviver21@gmail.com	FIN	2013-08-21 12:54:31.514613
600	jerviver21@gmail.com	INICIO	2013-08-21 12:54:55.187591
601	jerviver21@gmail.com	FIN	2013-08-21 12:55:30.749346
602	jerviver21@gmail.com	INICIO	2013-08-21 12:55:52.490024
603	jerviver21@gmail.com	FIN	2013-08-21 13:26:34.918453
604	jerviver21@gmail.com	INICIO	2013-08-22 00:03:25.768791
605	jerviver21@gmail.com	FIN	2013-08-22 08:40:52.669126
606	jerviver21@gmail.com	INICIO	2013-08-22 09:13:34.225065
607	jerviver21@gmail.com	FIN	2013-08-22 09:14:45.512575
608	jerviver21@gmail.com	INICIO	2013-08-22 09:27:15.912818
609	jerviver21@gmail.com	FIN	2013-08-22 09:58:52.800793
610	jerviver21@gmail.com	INICIO	2013-08-22 12:09:12.213816
611	jerviver21@gmail.com	FIN	2013-08-22 12:14:40.11435
612	jerviver21@gmail.com	INICIO	2013-08-23 09:24:38.240417
613	jerviver21@gmail.com	FIN	2013-08-23 09:56:17.989393
614	jerviver21@gmail.com	INICIO	2013-08-23 10:03:15.290396
615	jerviver21@gmail.com	FIN	2013-08-23 10:04:39.744639
616	jerviver21@hotmail.com	INICIO	2013-08-23 10:32:11.082644
617	jerviver21@hotmail.com	FIN	2013-08-23 10:32:34.175368
618	jerviver21@hotmail.com	INICIO	2013-08-23 10:33:17.493274
619	jerviver21@hotmail.com	FIN	2013-08-23 11:04:18.060641
620	admin	INICIO	2013-08-23 23:43:03.131321
621	admin	FIN	2013-08-23 23:51:32.165221
622	jerviver21@gmail.com	INICIO	2013-08-24 16:03:56.519494
623	jerviver21@gmail.com	FIN	2013-08-24 16:35:23.13598
624	jerviver21@gmail.com	INICIO	2013-08-24 20:01:29.985646
625	jerviver21@gmail.com	FIN	2013-08-24 20:01:47.803403
626	jerviver21@gmail.com	INICIO	2013-08-26 11:54:34.797802
627	jerviver21@gmail.com	FIN	2013-08-26 12:20:11.622889
628	jerviver21@gmail.com	INICIO	2013-08-26 13:08:01.712811
629	jerviver21@gmail.com	FIN	2013-08-26 13:15:43.116041
630	jerviver21@gmail.com	INICIO	2013-08-26 13:35:04.140291
631	jerviver21@gmail.com	FIN	2013-08-26 13:38:22.086291
632	jerviver21@gmail.com	INICIO	2013-08-26 13:38:44.308017
633	jerviver21@gmail.com	FIN	2013-08-26 13:42:03.226266
634	jerviver21@gmail.com	INICIO	2013-08-26 13:42:37.131503
635	jerviver21@gmail.com	FIN	2013-08-26 13:55:03.190978
636	jerviver21@gmail.com	INICIO	2013-08-26 14:58:51.38049
637	jerviver21@gmail.com	FIN	2013-08-26 15:01:09.935939
638	jerviver21@gmail.com	INICIO	2013-08-26 15:01:33.93692
639	jerviver21@gmail.com	FIN	2013-08-26 15:04:44.618274
640	jerviver21@gmail.com	INICIO	2013-08-26 15:05:25.051656
641	jerviver21@gmail.com	FIN	2013-08-26 15:06:27.017024
642	jerviver21@gmail.com	INICIO	2013-08-26 15:06:48.321295
643	jerviver21@gmail.com	FIN	2013-08-26 15:12:35.609993
644	jerviver21@gmail.com	INICIO	2013-08-26 15:12:57.785461
645	jerviver21@gmail.com	FIN	2013-08-26 15:13:34.915123
646	jerviver21@gmail.com	INICIO	2013-08-26 15:15:19.946133
647	jerviver21@gmail.com	FIN	2013-08-26 15:24:16.770757
648	jerviver21@gmail.com	INICIO	2013-08-26 15:24:50.743426
649	jerviver21@gmail.com	FIN	2013-08-26 15:56:19.089589
650	admin	INICIO	2013-09-06 15:57:07.477873
651	admin	FIN	2013-09-06 15:57:43.572371
652	jerviver21@gmail.com	INICIO	2013-09-06 16:11:16.755721
653	jerviver21@gmail.com	FIN	2013-09-06 16:13:23.581643
654	jerviver21@gmail.com	INICIO	2013-09-06 16:26:32.180537
655	jerviver21@gmail.com	FIN	2013-09-06 16:32:06.653179
656	jerviver21@gmail.com	INICIO	2013-09-06 16:39:14.087336
657	jerviver21@gmail.com	FIN	2013-09-06 16:42:07.697786
658	jerviver21@gmail.com	INICIO	2013-09-06 16:42:32.413716
659	jerviver21@gmail.com	FIN	2013-09-06 16:43:52.797377
660	jerviver21@gmail.com	INICIO	2013-09-06 16:44:16.226542
661	jerviver21@gmail.com	FIN	2013-09-06 16:59:15.665041
662	jerviver21@gmail.com	INICIO	2013-09-06 16:59:40.300834
663	jerviver21@gmail.com	FIN	2013-09-06 17:00:39.476412
664	jerviver21@gmail.com	INICIO	2013-09-06 17:03:56.614413
665	jerviver21@gmail.com	FIN	2013-09-06 17:35:43.482291
666	jerviver21@gmail.com	INICIO	2013-09-25 10:50:27.909143
667	jerviver21@gmail.com	FIN	2013-09-25 10:50:42.239503
668	jerviver21@gmail.com	INICIO	2013-09-25 11:00:03.970804
669	jerviver21@gmail.com	FIN	2013-09-25 11:00:07.491035
670	jerviver21@gmail.com	INICIO	2013-09-25 11:02:55.598714
671	jerviver21@gmail.com	FIN	2013-09-25 11:03:26.716471
672	jerviver21@gmail.com	FIN	2013-09-25 11:03:34.940718
673	jerviver21@gmail.com	INICIO	2013-09-25 11:07:04.928387
674	jerviver21@gmail.com	FIN	2013-09-25 11:07:16.055621
675	jerviver21@gmail.com	INICIO	2013-09-25 11:09:51.091209
676	jerviver21@gmail.com	FIN	2013-09-25 11:10:01.439993
677	jerviver21@gmail.com	INICIO	2013-09-25 11:10:10.54174
678	jerviver21@gmail.com	FIN	2013-09-25 11:10:13.929993
679	jerviver21@gmail.com	INICIO	2013-09-25 11:10:36.182653
680	jerviver21@gmail.com	FIN	2013-09-25 12:18:09.682155
681	jerviver21@gmail.com	INICIO	2013-10-09 13:30:23.305989
682	jerviver21@gmail.com	FIN	2013-10-09 13:32:37.215934
683	jerviver21@gmail.com	INICIO	2013-10-09 13:33:18.098044
684	jerviver21@gmail.com	FIN	2013-10-09 13:34:35.238132
685	jerviver21@gmail.com	INICIO	2013-10-09 13:37:15.611112
686	jerviver21@gmail.com	FIN	2013-10-09 14:08:47.380769
687	jerviver21@gmail.com	INICIO	2013-10-09 18:48:40.763279
688	jerviver21@gmail.com	FIN	2013-10-09 19:18:47.638599
689	jerviver21@gmail.com	INICIO	2013-10-10 16:15:44.832528
690	jerviver21@gmail.com	FIN	2013-10-10 16:15:55.671448
691	jerviver21@gmail.com	INICIO	2013-10-10 16:16:03.669804
692	jerviver21@gmail.com	FIN	2013-10-10 16:20:00.862828
693	jerviver21@gmail.com	INICIO	2013-10-10 16:20:24.024573
694	jerviver21@gmail.com	FIN	2013-10-10 16:22:44.325993
695	jerviver21@gmail.com	INICIO	2013-10-10 16:23:08.115877
696	jerviver21@gmail.com	FIN	2013-10-10 16:42:45.910554
697	jerviver21@gmail.com	INICIO	2013-10-10 18:59:05.303865
698	jerviver21@gmail.com	FIN	2013-10-10 19:33:48.736463
699	jerviver21@gmail.com	INICIO	2013-10-11 10:56:05.261888
700	jerviver21@gmail.com	FIN	2013-10-11 11:05:17.267683
701	admin	INICIO	2013-10-11 11:05:24.244677
702	admin	FIN	2013-10-11 11:07:14.406669
703	admin	INICIO	2013-10-11 11:07:36.90337
704	admin	FIN	2013-10-11 11:13:43.144896
705	asesor1	INICIO	2013-10-11 11:15:09.364831
706	asesor1	FIN	2013-10-11 11:18:56.664135
707	asesor1	FIN	2013-10-11 11:19:04.028246
708	admin	INICIO	2013-10-11 11:19:10.071256
709	admin	FIN	2013-10-11 11:19:38.362355
710	asesor1	INICIO	2013-10-11 11:19:46.18127
711	asesor1	FIN	2013-10-11 11:19:53.717386
712	asesor1	INICIO	2013-10-11 11:20:08.283333
713	asesor1	FIN	2013-10-11 11:23:57.650137
714	admin	INICIO	2013-10-11 11:24:18.371651
715	admin	FIN	2013-10-11 11:27:52.203516
716	jerviver21@gmail.com	INICIO	2013-10-11 11:28:18.546451
717	jerviver21@gmail.com	FIN	2013-10-11 11:29:46.955988
718	jerviver21@gmail.com	INICIO	2013-10-11 11:30:08.77872
719	jerviver21@gmail.com	FIN	2013-10-11 11:30:11.555217
720	jerviver21@gmail.com	INICIO	2013-10-11 11:47:07.640544
721	jerviver21@gmail.com	FIN	2013-10-11 11:52:34.214692
722	jerviver21@gmail.com	INICIO	2013-10-11 11:52:59.072655
723	jerviver21@gmail.com	FIN	2013-10-11 11:55:19.777216
724	asesor1	INICIO	2013-10-11 11:55:30.992564
725	asesor1	FIN	2013-10-11 11:58:31.88936
726	admin	INICIO	2013-10-11 11:58:38.152328
727	admin	FIN	2013-10-11 12:01:01.405837
728	asesor1	INICIO	2013-10-11 12:01:23.945151
729	asesor1	FIN	2013-10-11 12:01:38.038596
730	admin	INICIO	2013-10-11 12:01:46.772535
731	admin	FIN	2013-10-11 12:02:03.671447
732	admin	INICIO	2013-10-11 12:02:15.034466
733	admin	FIN	2013-10-11 12:04:19.572734
734	asesor1	INICIO	2013-10-11 12:04:48.006007
735	asesor1	FIN	2013-10-11 12:04:53.692295
736	jerviver21@gmail.com	INICIO	2013-10-11 12:05:00.113025
737	jerviver21@gmail.com	FIN	2013-10-11 12:05:02.832214
738	jerviver21@gmail.com	INICIO	2013-10-11 13:37:49.602991
739	jerviver21@gmail.com	FIN	2013-10-11 13:41:20.546891
740	asesor1	INICIO	2013-10-11 13:41:28.561493
741	asesor1	FIN	2013-10-11 13:59:10.336707
742	jerviver21@gmail.com	INICIO	2013-10-11 13:59:18.510755
743	jerviver21@gmail.com	FIN	2013-10-11 15:17:01.23587
744	jerviver21@gmail.com	INICIO	2013-10-15 00:58:42.431399
745	jerviver21@gmail.com	FIN	2013-10-15 01:05:47.044897
746	jerviver21@gmail.com	INICIO	2013-10-15 01:06:53.455791
747	jerviver21@gmail.com	FIN	2013-10-15 01:07:41.699244
748	jerviver21@gmail.com	INICIO	2013-10-15 01:09:25.273992
749	jerviver21@gmail.com	FIN	2013-10-15 01:11:01.688896
750	jerviver21@gmail.com	INICIO	2013-10-15 01:11:22.828281
751	jerviver21@gmail.com	FIN	2013-10-15 01:14:17.469908
752	jerviver21@gmail.com	INICIO	2013-10-15 01:14:48.504522
753	jerviver21@gmail.com	FIN	2013-10-15 01:16:30.002053
754	jerviver21@gmail.com	INICIO	2013-10-15 01:16:54.668055
755	jerviver21@gmail.com	FIN	2013-10-15 01:22:59.618729
756	jerviver21@gmail.com	INICIO	2013-10-15 01:23:23.388816
757	jerviver21@gmail.com	INICIO	2013-10-15 01:24:10.355149
758	jerviver21@gmail.com	FIN	2013-10-15 01:33:28.405179
759	jerviver21@gmail.com	FIN	2013-10-15 01:33:28.464057
760	jerviver21@gmail.com	INICIO	2013-10-15 01:33:51.695099
761	jerviver21@gmail.com	FIN	2013-10-15 01:34:57.285466
762	jerviver21@gmail.com	INICIO	2013-10-15 01:35:20.032402
763	jerviver21@gmail.com	FIN	2013-10-15 01:37:16.568539
764	jerviver21@gmail.com	INICIO	2013-10-15 01:37:36.378106
765	jerviver21@gmail.com	FIN	2013-10-15 01:38:27.655815
766	jerviver21@gmail.com	INICIO	2013-10-15 01:38:48.477264
767	jerviver21@gmail.com	FIN	2013-10-15 01:46:25.904036
768	jerviver21@gmail.com	INICIO	2013-10-15 01:46:57.305211
769	jerviver21@gmail.com	FIN	2013-10-15 01:52:10.135463
770	jerviver21@gmail.com	INICIO	2013-10-15 01:52:42.216465
771	jerviver21@gmail.com	FIN	2013-10-15 01:59:57.489364
772	jerviver21@gmail.com	INICIO	2013-10-15 02:00:40.207903
773	jerviver21@gmail.com	FIN	2013-10-15 02:03:43.373107
774	jerviver21@gmail.com	INICIO	2013-10-15 02:14:22.446429
775	jerviver21@gmail.com	FIN	2013-10-15 02:19:53.183279
776	jerviver21@gmail.com	INICIO	2013-10-15 02:20:24.012267
777	jerviver21@gmail.com	FIN	2013-10-15 02:26:15.130983
778	jerviver21@gmail.com	INICIO	2013-10-15 02:26:45.95436
779	jerviver21@gmail.com	FIN	2013-10-15 02:35:17.599235
780	jerviver21@gmail.com	INICIO	2013-10-15 02:35:53.874381
781	jerviver21@gmail.com	FIN	2013-10-15 02:38:01.252664
782	jerviver21@gmail.com	INICIO	2013-10-15 02:39:39.836841
783	jerviver21@gmail.com	FIN	2013-10-15 02:46:27.617723
784	jerviver21@gmail.com	INICIO	2013-10-15 02:48:11.779645
785	jerviver21@gmail.com	FIN	2013-10-15 02:48:54.826408
786	admin	INICIO	2013-10-15 02:49:03.286953
787	admin	FIN	2013-10-15 02:49:17.661139
788	jerviver21@gmail.com	INICIO	2013-10-15 02:49:26.395831
789	jerviver21@gmail.com	FIN	2013-10-15 02:52:04.981453
790	jerviver21@gmail.com	INICIO	2013-10-15 02:57:59.276374
791	jerviver21@gmail.com	FIN	2013-10-15 03:01:20.948093
792	jerviver21@gmail.com	INICIO	2013-10-15 03:01:29.070195
793	jerviver21@gmail.com	FIN	2013-10-15 03:03:02.739034
794	asesor1	INICIO	2013-10-15 03:03:08.698013
795	asesor1	FIN	2013-10-15 03:41:00.422193
796	jerviver21@gmail.com	INICIO	2013-10-15 03:51:37.181879
797	jerviver21@gmail.com	FIN	2013-10-15 04:00:30.887632
798	jerviver21@gmail.com	INICIO	2013-10-15 04:00:53.513514
799	jerviver21@gmail.com	FIN	2013-10-15 04:03:03.008643
800	jerviver21@hotmail.com	INICIO	2013-10-15 04:20:00.981713
801	jerviver21@hotmail.com	FIN	2013-10-15 04:21:30.001773
802	jerviver21@hotmail.com	INICIO	2013-10-15 04:21:54.974641
803	jerviver21@hotmail.com	FIN	2013-10-15 04:23:42.283549
804	jerviver21@hotmail.com	INICIO	2013-10-15 04:24:09.72483
805	jerviver21@hotmail.com	FIN	2013-10-15 04:24:47.993855
806	jerviver21@hotmail.com	INICIO	2013-10-15 04:25:10.586606
807	jerviver21@hotmail.com	FIN	2013-10-15 04:26:48.566293
808	asesor1	INICIO	2013-10-15 04:26:56.287921
809	asesor1	FIN	2013-10-15 04:27:41.159384
810	jerviver21@hotmail.com	INICIO	2013-10-15 04:27:48.176179
811	jerviver21@hotmail.com	FIN	2013-10-15 04:28:21.709688
812	asesor1	INICIO	2013-10-15 04:28:31.376954
813	asesor1	FIN	2013-10-15 04:28:50.208291
814	jerviver21@gmail.com	INICIO	2013-10-15 04:29:37.476263
815	jerviver21@gmail.com	FIN	2013-10-15 04:35:22.862121
816	jerviver21@gmail.com	INICIO	2013-10-15 04:37:43.204878
817	jerviver21@gmail.com	FIN	2013-10-15 04:37:56.980567
818	jerviver21@gmail.com	INICIO	2013-10-15 04:46:43.695845
819	jerviver21@gmail.com	FIN	2013-10-15 04:46:52.81677
820	jerviver21@gmail.com	INICIO	2013-10-15 11:07:53.549901
821	jerviver21@gmail.com	FIN	2013-10-15 11:12:58.611107
822	asesor1	INICIO	2013-10-15 11:13:11.992975
823	asesor1	FIN	2013-10-15 11:16:30.829121
824	jerviver21@gmail.com	INICIO	2013-10-15 11:16:38.695224
825	jerviver21@gmail.com	FIN	2013-10-15 11:17:33.428779
826	jerviver21@gmail.com	INICIO	2013-10-15 12:25:03.55584
827	jerviver21@gmail.com	FIN	2013-10-15 12:51:42.780134
828	asesor1	INICIO	2013-10-15 12:51:51.499959
829	asesor1	FIN	2013-10-15 12:53:27.560133
830	jerviver21@gmail.com	INICIO	2013-10-17 06:30:26.258141
831	jerviver21@gmail.com	FIN	2013-10-17 12:24:45.115422
832	jerviver21@gmail.com	INICIO	2013-10-17 14:09:47.692899
833	jerviver21@gmail.com	FIN	2013-10-17 14:40:25.290893
834	jerviver21@gmail.com	INICIO	2013-10-17 16:27:20.6289
835	jerviver21@gmail.com	FIN	2013-10-17 16:28:49.503789
836	jerviver21@gmail.com	INICIO	2013-10-17 16:29:36.69127
837	jerviver21@gmail.com	FIN	2013-10-17 17:00:23.137143
838	asesor1	INICIO	2013-10-17 17:54:45.904062
839	asesor1	FIN	2013-10-17 17:55:58.63241
840	jerviver21@gmail.com	INICIO	2013-10-17 19:03:30.150586
841	jerviver21@gmail.com	FIN	2013-10-17 19:05:14.361777
842	jerviver21@gmail.com	INICIO	2013-10-17 19:55:27.753645
843	jerviver21@gmail.com	FIN	2013-10-17 19:59:05.924324
844	jerviver21@gmail.com	INICIO	2013-10-17 19:59:36.908709
845	jerviver21@gmail.com	FIN	2013-10-17 20:01:25.031346
846	jerviver21@gmail.com	INICIO	2013-10-17 20:01:47.444186
847	jerviver21@gmail.com	FIN	2013-10-17 20:03:12.731863
848	jerviver21@gmail.com	INICIO	2013-10-17 20:03:34.235044
849	jerviver21@gmail.com	FIN	2013-10-17 20:06:15.516038
850	jerviver21@gmail.com	INICIO	2013-10-17 20:06:34.42194
851	jerviver21@gmail.com	FIN	2013-10-17 20:15:59.082019
852	jerviver21@gmail.com	INICIO	2013-10-17 20:16:21.323171
853	jerviver21@gmail.com	FIN	2013-10-17 20:17:46.710171
854	jerviver21@gmail.com	INICIO	2013-10-17 20:18:05.500821
855	jerviver21@gmail.com	FIN	2013-10-17 20:21:46.324865
856	jerviver21@gmail.com	INICIO	2013-10-17 20:22:07.566499
857	jerviver21@gmail.com	FIN	2013-10-17 20:23:10.754095
858	jerviver21@gmail.com	INICIO	2013-10-18 00:25:06.871665
859	jerviver21@gmail.com	FIN	2013-10-18 00:25:45.470155
860	asesor1	INICIO	2013-10-18 00:25:53.645749
861	asesor1	FIN	2013-10-18 00:26:16.481824
862	jerviver21@gmail.com	INICIO	2013-11-06 20:01:59.774429
863	jerviver21@gmail.com	FIN	2013-11-06 20:32:24.909265
864	jerviver21@gmail.com	INICIO	2013-11-06 22:04:54.159566
865	jerviver21@gmail.com	FIN	2013-11-06 22:06:02.803917
866	jerviver21@gmail.com	INICIO	2013-11-06 22:06:29.842253
867	jerviver21@gmail.com	FIN	2013-11-06 22:10:36.060338
868	jerviver21@gmail.com	INICIO	2013-11-06 22:11:02.302294
869	jerviver21@gmail.com	FIN	2013-11-06 22:12:37.357063
870	asesor1	INICIO	2013-11-06 22:12:48.624948
871	asesor1	FIN	2013-11-06 22:14:51.488981
872	jerviver21@gmail.com	INICIO	2013-11-06 22:14:58.056093
873	jerviver21@gmail.com	FIN	2013-11-06 22:45:45.06281
874	jerviver21@gmail.com	INICIO	2013-11-06 23:00:44.363726
875	jerviver21@gmail.com	FIN	2013-11-07 00:21:57.817164
876	jerviver21@gmail.com	INICIO	2013-11-07 01:43:55.469914
877	jerviver21@gmail.com	FIN	2013-11-07 02:32:17.937977
878	jerviver21@gmail.com	INICIO	2013-11-07 04:43:40.181286
879	jerviver21@gmail.com	FIN	2013-11-07 04:46:04.274727
880	jerviver21@gmail.com	INICIO	2013-11-07 04:46:29.122032
881	jerviver21@gmail.com	FIN	2013-11-07 04:47:53.583386
882	jerviver21@gmail.com	INICIO	2013-11-07 04:48:19.590842
883	jerviver21@gmail.com	FIN	2013-11-07 04:53:08.101274
884	jerviver21@gmail.com	INICIO	2013-11-07 04:53:30.979294
885	jerviver21@gmail.com	FIN	2013-11-07 04:55:39.460897
886	jerviver21@gmail.com	INICIO	2013-11-07 04:56:04.183149
887	jerviver21@gmail.com	FIN	2013-11-07 05:30:21.115671
888	jerviver21@gmail.com	INICIO	2013-11-07 05:35:39.353284
889	jerviver21@gmail.com	FIN	2013-11-07 05:46:53.204485
890	jerviver21@gmail.com	INICIO	2013-11-07 05:47:39.527265
891	jerviver21@gmail.com	FIN	2013-11-07 05:52:33.393973
892	jerviver21@gmail.com	INICIO	2013-11-07 05:53:05.278984
893	jerviver21@gmail.com	FIN	2013-11-07 06:08:30.366192
894	jerviver21@gmail.com	INICIO	2013-11-07 06:09:01.363085
895	jerviver21@gmail.com	FIN	2013-11-07 06:11:26.656055
896	jerviver21@gmail.com	INICIO	2013-11-07 06:11:59.309026
897	jerviver21@gmail.com	FIN	2013-11-07 06:33:10.755747
898	jerviver21@gmail.com	INICIO	2013-11-07 06:33:39.546187
899	jerviver21@gmail.com	FIN	2013-11-07 06:34:30.028468
900	jerviver21@gmail.com	INICIO	2013-11-07 06:34:36.946835
901	jerviver21@gmail.com	FIN	2013-11-07 06:44:01.053055
902	jerviver21@gmail.com	INICIO	2013-11-07 06:44:28.210718
903	jerviver21@gmail.com	FIN	2013-11-07 16:11:57.781716
904	jerviver21@gmail.com	INICIO	2013-11-08 00:36:54.816517
905	jerviver21@gmail.com	FIN	2013-11-08 00:41:30.160831
906	jerviver21@gmail.com	INICIO	2013-11-08 00:41:51.967087
907	jerviver21@gmail.com	FIN	2013-11-08 00:43:01.847894
908	jerviver21@gmail.com	INICIO	2013-11-08 00:43:23.48385
909	jerviver21@gmail.com	FIN	2013-11-08 01:14:05.322123
910	jerviver21@gmail.com	INICIO	2013-11-08 03:21:29.983807
911	jerviver21@gmail.com	FIN	2013-11-08 03:25:24.765919
912	jerviver21@gmail.com	INICIO	2013-11-08 03:25:57.828299
913	jerviver21@gmail.com	FIN	2013-11-08 03:29:01.718985
914	jerviver21@gmail.com	INICIO	2013-11-08 03:29:35.041737
915	jerviver21@gmail.com	FIN	2013-11-08 03:33:26.539033
916	jerviver21@gmail.com	INICIO	2013-11-08 03:36:52.932713
917	jerviver21@gmail.com	FIN	2013-11-08 03:40:28.853658
918	jerviver21@gmail.com	INICIO	2013-11-08 03:40:34.800645
919	jerviver21@gmail.com	FIN	2013-11-08 04:12:35.465393
920	jerviver21@gmail.com	INICIO	2013-11-11 17:02:40.320312
921	jerviver21@gmail.com	FIN	2013-11-11 17:05:39.764846
922	asesor1	INICIO	2013-11-11 17:05:47.38427
923	asesor1	FIN	2013-11-11 17:08:14.337791
924	asesor1	INICIO	2013-11-11 17:08:45.42313
925	asesor1	FIN	2013-11-11 17:11:35.689715
926	asesor1	INICIO	2013-11-11 17:11:44.591064
927	asesor1	FIN	2013-11-11 17:12:12.88941
928	jerviver21@gmail.com	INICIO	2013-11-11 17:14:32.625206
929	jerviver21@gmail.com	FIN	2013-11-11 17:14:35.491125
930	asesor1	INICIO	2013-11-11 17:14:41.289488
931	asesor1	FIN	2013-11-11 17:15:00.560481
932	jerviver21@gmail.com	INICIO	2013-11-11 18:07:45.714478
933	jerviver21@gmail.com	FIN	2013-11-11 18:09:38.367394
934	asesor1	INICIO	2013-11-11 18:09:44.361239
935	asesor1	FIN	2013-11-11 18:10:27.862501
936	jerviver21@gmail.com	INICIO	2013-11-11 19:22:52.572999
937	jerviver21@gmail.com	FIN	2013-11-11 19:22:54.122395
938	jerviver21@gmail.com	INICIO	2013-11-13 05:06:31.942919
939	jerviver21@gmail.com	FIN	2013-11-13 05:06:39.36403
940	jerviver21@gmail.com	INICIO	2013-11-13 05:07:09.639967
941	jerviver21@gmail.com	FIN	2013-11-13 05:16:16.749337
942	jerviver21@gmail.com	INICIO	2013-11-13 05:16:37.466646
943	jerviver21@gmail.com	FIN	2013-11-13 05:34:09.021866
944	jerviver21@gmail.com	INICIO	2013-11-13 05:34:29.182094
945	jerviver21@gmail.com	FIN	2013-11-13 05:57:13.185679
946	jerviver21@gmail.com	INICIO	2013-11-14 12:04:23.30409
947	jerviver21@gmail.com	FIN	2013-11-14 12:05:57.087513
948	jerviver21@gmail.com	INICIO	2013-11-14 12:06:29.123326
949	jerviver21@gmail.com	FIN	2013-11-14 12:38:12.627461
950	jerviver21@gmail.com	INICIO	2013-11-15 01:47:27.089529
951	jerviver21@gmail.com	FIN	2013-11-15 01:48:50.672956
952	jerviver21@gmail.com	INICIO	2013-11-15 01:52:23.034399
953	jerviver21@gmail.com	FIN	2013-11-15 01:56:32.858119
954	jerviver21@gmail.com	INICIO	2013-11-15 01:57:08.77862
955	jerviver21@gmail.com	FIN	2013-11-15 02:01:48.623199
956	asesor1	INICIO	2013-11-15 02:04:20.467037
957	asesor1	FIN	2013-11-15 02:04:46.062963
958	jerviver21@gmail.com	INICIO	2013-12-18 21:13:59.958691
959	jerviver21@gmail.com	FIN	2013-12-18 21:45:37.23704
960	jerviver21@gmail.com	INICIO	2013-12-19 02:13:06.745847
961	jerviver21@gmail.com	FIN	2013-12-19 12:36:56.328965
962	jerviver21@gmail.com	INICIO	2013-12-19 12:37:03.739492
963	jerviver21@gmail.com	FIN	2013-12-19 12:39:06.801304
964	jerviver21@gmail.com	INICIO	2013-12-19 12:39:32.549004
965	jerviver21@gmail.com	FIN	2013-12-19 12:41:21.133232
966	jerviver21@gmail.com	INICIO	2013-12-19 12:41:52.038313
967	jerviver21@gmail.com	FIN	2013-12-19 12:47:13.415833
968	jerviver21@gmail.com	INICIO	2013-12-19 12:47:42.015502
969	jerviver21@gmail.com	FIN	2013-12-19 12:51:48.773192
970	jerviver21@gmail.com	INICIO	2013-12-19 12:52:22.080208
971	jerviver21@gmail.com	FIN	2013-12-19 13:24:06.224288
972	jerviver21@gmail.com	INICIO	2013-12-19 14:02:50.74403
973	jerviver21@gmail.com	FIN	2013-12-19 14:46:36.348711
974	jerviver21@gmail.com	INICIO	2013-12-19 14:57:16.889061
975	jerviver21@gmail.com	FIN	2013-12-19 15:57:07.082711
976	jerviver21@gmail.com	INICIO	2013-12-19 16:05:03.336209
977	jerviver21@gmail.com	FIN	2013-12-19 16:06:57.262912
978	jerviver21@gmail.com	INICIO	2013-12-19 16:08:29.393324
979	jerviver21@gmail.com	FIN	2013-12-19 16:08:50.463332
980	jerviver21@gmail.com	INICIO	2013-12-19 17:00:40.197628
981	jerviver21@gmail.com	FIN	2013-12-19 17:01:51.155182
982	asesor1	INICIO	2013-12-19 17:02:00.022841
983	asesor1	FIN	2013-12-19 17:02:59.312673
984	jerviver21@gmail.com	INICIO	2013-12-19 17:12:21.23418
985	jerviver21@gmail.com	FIN	2013-12-19 17:13:51.623506
986	asesor1	INICIO	2013-12-19 17:13:59.742789
987	asesor1	FIN	2013-12-19 17:14:11.715606
988	jerviver21@gmail.com	INICIO	2013-12-23 18:04:36.039604
989	jerviver21@gmail.com	FIN	2013-12-23 18:09:26.308249
990	jerviver21@gmail.com	INICIO	2013-12-26 18:20:28.561861
991	jerviver21@gmail.com	FIN	2013-12-26 18:20:33.369685
992	jerviver21@gmail.com	INICIO	2013-12-30 16:43:03.291675
993	jerviver21@gmail.com	FIN	2013-12-30 16:43:22.224587
994	jerviver21@gmail.com	INICIO	2013-12-30 16:51:03.209278
995	jerviver21@gmail.com	FIN	2013-12-30 16:55:54.914131
996	admin	INICIO	2014-01-08 05:25:36.446988
997	admin	FIN	2014-01-08 05:56:46.037086
998	admin	INICIO	2014-01-08 06:09:49.201743
999	admin	FIN	2014-01-08 06:25:38.624768
1000	admin	INICIO	2014-01-08 06:26:03.913868
1001	admin	FIN	2014-01-08 06:55:08.132911
1002	admin	INICIO	2014-01-08 06:55:32.029959
1003	admin	FIN	2014-01-08 06:58:40.952729
1004	admin	INICIO	2014-01-08 06:59:03.32932
1005	admin	FIN	2014-01-08 07:01:16.132218
1006	admin	INICIO	2014-01-08 07:01:48.002374
1007	admin	FIN	2014-01-08 07:32:26.178038
1008	admin	INICIO	2014-01-08 07:50:24.814575
1009	admin	FIN	2014-01-08 07:54:25.046148
1010	admin	INICIO	2014-01-08 07:54:52.960094
1011	admin	FIN	2014-01-08 07:55:43.573883
1012	admin	INICIO	2014-01-08 07:56:07.038965
1013	admin	FIN	2014-01-08 08:26:46.265483
1014	admin	INICIO	2014-01-09 08:48:40.908755
1015	admin	FIN	2014-01-09 08:52:37.393423
1016	admin	INICIO	2014-01-09 08:53:40.14803
1017	admin	FIN	2014-01-09 08:57:19.14364
1018	admin	INICIO	2014-01-09 09:02:00.953651
1019	admin	FIN	2014-01-09 09:14:32.923187
1020	admin	INICIO	2014-01-09 09:15:51.500486
1021	admin	FIN	2014-01-09 09:17:03.77777
1022	admin	INICIO	2014-01-09 09:17:37.129109
1023	admin	FIN	2014-01-09 09:20:15.082487
1024	admin	INICIO	2014-01-09 09:20:45.065831
1025	admin	FIN	2014-01-09 09:26:07.021736
1026	admin	INICIO	2014-01-09 09:26:30.635264
1027	admin	FIN	2014-01-09 09:29:54.843771
1028	admin	INICIO	2014-01-09 09:30:24.378379
1029	admin	FIN	2014-01-09 09:31:28.555794
1030	admin	INICIO	2014-01-09 09:31:52.590618
1031	admin	FIN	2014-01-09 10:02:29.855902
1032	admin	INICIO	2014-01-09 12:58:58.26704
1033	admin	FIN	2014-01-09 13:12:12.845528
1034	admin	INICIO	2014-01-09 18:15:30.84334
1035	admin	FIN	2014-01-09 18:20:02.883999
1036	admin	INICIO	2014-01-09 18:21:20.124425
1037	admin	FIN	2014-01-09 19:01:01.920772
1038	jerviver21@gmail.com	INICIO	2014-01-13 16:14:30.619475
1039	jerviver21@gmail.com	FIN	2014-01-13 16:51:14.298269
1040	jerviver21@gmail.com	INICIO	2014-01-13 17:50:54.659127
1041	jerviver21@gmail.com	FIN	2014-01-13 18:27:56.871553
1042	admin	INICIO	2014-01-14 16:48:29.432069
1043	admin	FIN	2014-01-14 16:49:03.550969
1044	jerviver21@gmail.com	INICIO	2014-01-14 16:49:31.069455
1045	jerviver21@gmail.com	FIN	2014-01-14 16:49:39.502504
1046	admin	INICIO	2014-01-14 16:49:48.82397
1047	admin	FIN	2014-01-14 16:50:41.800053
1048	admin	INICIO	2014-01-14 16:53:03.957572
1049	admin	FIN	2014-01-14 16:53:22.619181
1050	jerviver21@gmail.com	INICIO	2014-01-14 17:17:14.145091
1051	jerviver21@gmail.com	FIN	2014-01-14 17:40:59.18984
1052	jerviver21@gmail.com	INICIO	2014-01-14 17:41:22.83939
1053	jerviver21@gmail.com	FIN	2014-01-14 18:12:06.176955
1054	jerviver21@gmail.com	INICIO	2014-01-15 12:48:57.285901
1055	jerviver21@gmail.com	FIN	2014-01-15 13:04:17.19322
1056	jerviver21@gmail.com	INICIO	2014-01-15 13:04:51.814218
1057	jerviver21@gmail.com	FIN	2014-01-15 13:23:13.499049
1058	jerviver21@gmail.com	INICIO	2014-01-15 13:23:42.846822
1059	jerviver21@gmail.com	FIN	2014-01-15 13:24:56.496714
1060	jerviver21@gmail.com	INICIO	2014-01-15 13:25:27.042823
1061	jerviver21@gmail.com	FIN	2014-01-15 13:38:39.17743
1062	jerviver21@gmail.com	INICIO	2014-01-15 13:40:08.847553
1063	jerviver21@gmail.com	FIN	2014-01-15 13:42:49.78582
1064	jerviver21@gmail.com	INICIO	2014-01-15 13:43:13.437843
1065	jerviver21@gmail.com	FIN	2014-01-15 13:58:38.255345
1068	jerviver21@gmail.com	INICIO	2014-01-15 14:03:20.237456
1069	jerviver21@gmail.com	FIN	2014-01-15 14:03:40.808103
1066	jerviver21@gmail.com	INICIO	2014-01-15 13:59:01.737533
1067	jerviver21@gmail.com	FIN	2014-01-15 14:02:46.173602
1070	jerviver21@gmail.com	INICIO	2014-01-15 14:05:31.922168
1071	jerviver21@gmail.com	FIN	2014-01-15 14:37:44.841491
1072	jerviver21@gmail.com	INICIO	2014-01-15 15:38:48.839097
1073	jerviver21@gmail.com	FIN	2014-01-15 15:50:16.570725
1074	jerviver21@gmail.com	INICIO	2014-01-15 15:57:05.814304
1075	jerviver21@gmail.com	FIN	2014-01-15 16:05:38.835565
1076	jerviver21@gmail.com	INICIO	2014-01-15 16:06:09.34415
1077	jerviver21@gmail.com	FIN	2014-01-15 16:08:45.172922
1078	jerviver21@gmail.com	INICIO	2014-01-15 16:09:08.645213
1079	jerviver21@gmail.com	FIN	2014-01-15 16:13:27.433028
1080	jerviver21@gmail.com	FIN	2014-01-15 16:15:02.509388
1081	jerviver21@gmail.com	INICIO	2014-01-15 16:15:29.252571
1082	jerviver21@gmail.com	FIN	2014-01-15 16:17:49.975602
1083	jerviver21@gmail.com	INICIO	2014-01-15 16:18:15.846877
1084	jerviver21@gmail.com	FIN	2014-01-15 16:20:54.968073
1085	jerviver21@gmail.com	INICIO	2014-01-15 16:21:22.74017
1086	jerviver21@gmail.com	FIN	2014-01-15 16:22:11.859712
1087	jerviver21@gmail.com	INICIO	2014-01-15 16:22:34.955767
1088	jerviver21@gmail.com	FIN	2014-01-15 16:24:04.34321
1089	jerviver21@gmail.com	INICIO	2014-01-15 16:24:32.669735
1090	jerviver21@gmail.com	FIN	2014-01-15 16:24:58.820523
1091	jerviver21@gmail.com	INICIO	2014-01-15 16:25:17.23688
1092	jerviver21@gmail.com	FIN	2014-01-15 16:31:56.248316
1093	jerviver21@gmail.com	INICIO	2014-01-15 17:03:16.35408
1094	jerviver21@gmail.com	FIN	2014-01-15 17:03:22.370094
1095	jerviver21@gmail.com	INICIO	2014-01-15 17:07:03.043774
1096	jerviver21@gmail.com	FIN	2014-01-15 17:10:36.799303
1097	admin	INICIO	2014-01-15 17:11:16.651107
1098	admin	FIN	2014-01-15 17:11:41.499689
1099	jerviver21@gmail.com	INICIO	2014-01-15 17:11:51.683665
1100	jerviver21@gmail.com	FIN	2014-01-15 17:15:02.498444
1101	admin	INICIO	2014-01-15 17:15:33.27302
1102	admin	FIN	2014-01-15 17:15:45.902909
1103	jerviver21@gmail.com	INICIO	2014-01-15 17:16:02.696215
1104	jerviver21@gmail.com	FIN	2014-01-15 17:16:23.002979
1105	admin	INICIO	2014-01-15 17:16:33.124897
1106	admin	FIN	2014-01-15 17:20:21.791327
1107	jerviver21@gmail.com	INICIO	2014-01-15 17:20:48.003504
1108	jerviver21@gmail.com	FIN	2014-01-15 17:31:57.185042
1109	jerviver21@gmail.com	INICIO	2014-01-15 17:32:27.219844
1110	jerviver21@gmail.com	FIN	2014-01-15 17:58:17.696263
1111	jerviver21@gmail.com	INICIO	2014-01-15 18:20:46.975468
1112	jerviver21@gmail.com	FIN	2014-01-15 18:24:33.207808
1113	jerviver21@gmail.com	INICIO	2014-01-15 18:25:02.76858
1114	jerviver21@gmail.com	FIN	2014-01-15 18:25:25.510003
1115	jerviver21@gmail.com	INICIO	2014-01-15 18:29:52.173199
1116	jerviver21@gmail.com	FIN	2014-01-15 19:46:54.038197
1117	jerviver21@gmail.com	INICIO	2014-01-15 21:56:38.244961
1118	jerviver21@gmail.com	FIN	2014-01-15 21:57:43.570282
1119	jerviver21@gmail.com	INICIO	2014-01-15 22:03:08.683154
1120	jerviver21@gmail.com	FIN	2014-01-15 22:04:11.234234
1121	jerviver21@gmail.com	INICIO	2014-01-15 22:04:20.807649
1122	jerviver21@gmail.com	FIN	2014-01-15 22:05:00.016747
1123	admin	INICIO	2014-01-15 22:07:04.912635
1124	admin	FIN	2014-01-15 22:11:14.993413
1125	jerviver21@gmail.com	INICIO	2014-01-15 22:11:53.855285
1126	jerviver21@gmail.com	FIN	2014-01-15 22:42:54.230482
1127	jerviver21@gmail.com	INICIO	2014-01-16 08:37:43.399124
1128	jerviver21@gmail.com	FIN	2014-01-16 08:40:12.379482
1129	jerviver21@gmail.com	INICIO	2014-01-16 08:41:34.998768
1130	jerviver21@gmail.com	FIN	2014-01-16 09:15:19.327238
1131	jerviver21@gmail.com	INICIO	2014-01-16 09:23:31.461368
1132	jerviver21@gmail.com	FIN	2014-01-16 09:24:02.531659
1133	jerviver21@gmail.com	INICIO	2014-01-16 09:31:10.967957
1134	jerviver21@gmail.com	FIN	2014-01-16 09:32:17.880075
1135	jerviver21@gmail.com	INICIO	2014-01-16 09:32:40.141485
1136	jerviver21@gmail.com	FIN	2014-01-16 09:39:34.722582
1137	jerviver21@gmail.com	INICIO	2014-01-16 09:39:59.057414
1138	jerviver21@gmail.com	FIN	2014-01-16 09:48:54.666853
1139	jerviver21@gmail.com	INICIO	2014-01-16 09:49:17.016026
1140	jerviver21@gmail.com	FIN	2014-01-16 09:54:49.030974
1141	jerviver21@gmail.com	INICIO	2014-01-16 10:01:30.750374
1142	jerviver21@gmail.com	FIN	2014-01-16 10:11:16.592173
1143	jerviver21@gmail.com	INICIO	2014-01-16 10:11:23.10291
1144	jerviver21@gmail.com	FIN	2014-01-16 10:13:08.489694
1145	asesor1	INICIO	2014-01-16 10:13:15.674494
1146	asesor1	FIN	2014-01-16 10:13:27.007983
1147	jerviver21@gmail.com	INICIO	2014-01-16 10:29:28.18802
1148	jerviver21@gmail.com	FIN	2014-01-16 10:39:38.644727
1149	jerviver21@gmail.com	INICIO	2014-01-16 10:40:53.633154
1150	jerviver21@gmail.com	FIN	2014-01-16 11:00:02.158475
1151	jerviver21@gmail.com	INICIO	2014-01-16 11:00:48.916854
1152	jerviver21@gmail.com	FIN	2014-01-16 11:29:40.412264
1153	jerviver21@gmail.com	INICIO	2014-01-16 11:29:55.088276
1154	jerviver21@gmail.com	FIN	2014-01-16 11:32:13.378298
1155	jerviver21@gmail.com	INICIO	2014-01-16 13:17:51.505438
1156	jerviver21@gmail.com	FIN	2014-01-16 13:20:39.75321
1157	jerviver21@gmail.com	INICIO	2014-01-16 13:20:47.326834
1158	jerviver21@gmail.com	FIN	2014-01-16 13:23:44.197451
1159	jerviver21@gmail.com	INICIO	2014-01-16 13:24:17.827486
1160	jerviver21@gmail.com	FIN	2014-01-16 13:27:18.437824
1161	jerviver21@gmail.com	INICIO	2014-01-16 13:27:39.373573
1162	jerviver21@gmail.com	FIN	2014-01-16 13:30:07.72018
1163	jerviver21@gmail.com	INICIO	2014-01-16 13:30:30.720933
1164	jerviver21@gmail.com	FIN	2014-01-16 13:31:58.371628
1165	jerviver21@gmail.com	INICIO	2014-01-16 13:36:24.605495
1166	jerviver21@gmail.com	FIN	2014-01-16 13:41:18.814936
1167	jerviver21@gmail.com	INICIO	2014-01-16 13:41:45.539205
1168	jerviver21@gmail.com	FIN	2014-01-16 13:54:07.436331
1169	jerviver21@gmail.com	INICIO	2014-01-17 10:21:58.909156
1170	jerviver21@gmail.com	FIN	2014-01-17 10:55:15.614241
1171	jerviver21@gmail.com	INICIO	2014-01-17 11:20:35.876443
1172	jerviver21@gmail.com	FIN	2014-01-17 11:32:00.607904
1173	jerviver21@gmail.com	INICIO	2014-01-17 11:32:07.480681
1174	jerviver21@gmail.com	FIN	2014-01-17 11:49:15.669112
1175	jerviver21@gmail.com	INICIO	2014-01-17 12:23:37.81693
1176	jerviver21@gmail.com	FIN	2014-01-17 12:26:52.512831
1177	jerviver21@gmail.com	INICIO	2014-01-17 12:27:42.786427
1178	jerviver21@gmail.com	FIN	2014-01-17 12:35:55.39622
1179	jerviver21@gmail.com	INICIO	2014-01-17 12:46:15.132408
1180	jerviver21@gmail.com	FIN	2014-01-17 12:47:18.461383
1181	jerviver21@gmail.com	INICIO	2014-01-17 13:00:36.449612
1182	jerviver21@gmail.com	FIN	2014-01-17 13:03:58.871972
1183	jerviver21@gmail.com	INICIO	2014-01-17 13:04:05.524806
1184	jerviver21@gmail.com	FIN	2014-01-17 13:04:35.700046
1185	jerviver21@gmail.com	INICIO	2014-01-17 13:05:06.956155
1186	jerviver21@gmail.com	FIN	2014-01-17 13:06:17.265078
1187	jerviver21@gmail.com	INICIO	2014-01-17 13:06:41.870907
1188	jerviver21@gmail.com	FIN	2014-01-17 13:10:24.822717
1189	jerviver21@gmail.com	INICIO	2014-01-17 16:26:27.068285
1190	jerviver21@gmail.com	FIN	2014-01-17 16:32:22.924956
1191	jerviver21@gmail.com	INICIO	2014-01-17 16:35:44.10306
1192	jerviver21@gmail.com	FIN	2014-01-17 16:36:39.904765
1193	jerviver21@gmail.com	INICIO	2014-01-17 17:00:44.492598
1194	jerviver21@gmail.com	FIN	2014-01-17 17:00:54.092939
1195	jerviver21@gmail.com	INICIO	2014-01-17 17:03:13.53858
1196	jerviver21@gmail.com	FIN	2014-01-17 17:03:19.685234
\.


--
-- Name: aud_sesion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jbossuser
--

SELECT pg_catalog.setval('aud_sesion_id_seq', 1196, true);


--
-- Data for Name: aud_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aud_users (id, usr, pwd, nombre, mail, estado, fecha_hora, operacion, usuario) FROM stdin;
1	p1	p1	p1	p1	1	2013-04-30 10:18:19.115502	INSERT	\N
2	p2	p2	p2	p2	1	2013-04-30 10:40:21.823848	INSERT	\N
3	p3	p3	p3	p3	1	2013-04-30 10:42:26.325983	INSERT	\N
4	p4	p4	p4	p4	1	2013-04-30 10:50:23.554057	INSERT	\N
5	p5	p5	p5	p5	1	2013-04-30 10:50:40.36373	INSERT	\N
6	p5	clave123	p5	p5	1	2013-04-30 10:51:37.35498	UPDATE	\N
7	p4	p4	p4	p4	1	2013-04-30 10:52:02.964148	DELETE	\N
8	p4	p4	p4	p4	1	2013-04-30 10:55:54.040571	INSERT	\N
9	p6	p6	p6	p6	1	2013-04-30 10:56:02.67359	INSERT	\N
10	p6	clave123	p6	p6	1	2013-04-30 10:56:09.755669	UPDATE	\N
11	p5	clave123	p5	p5	1	2013-04-30 10:56:13.881979	UPDATE	\N
13	p7	p7	p7	p7	1	2013-04-30 11:00:36.004924	UPDATE	\N
14	p2	p2	p2	p2	1	2013-04-30 11:00:44.120632	DELETE	\N
15	p5	clave12345	p5	p5	1	2013-04-30 11:00:55.775244	UPDATE	\N
16	p8	p8	p8	p8	1	2013-04-30 11:02:58.696457	INSERT	\N
17	p1	clave12345	p1	p1	1	2013-04-30 11:03:07.849649	UPDATE	\N
18	p1	clave12345	p1	p1	1	2013-04-30 11:03:13.987445	DELETE	\N
19	p9	p9	p9	p9	1	2013-05-01 10:01:05.575366	INSERT	\N
20	admin	d033e22ae348aeb5660fc2140aec35850c4da997	JERSON VIVEROS AGUIRRE	jerviver21@gmail.com	1	2013-05-01 10:01:28.364041	UPDATE	\N
21	p3	p3	p3	p3	1	2013-05-01 10:01:28.364041	UPDATE	\N
22	p4	p4	p4	p4	1	2013-05-01 10:01:28.364041	UPDATE	\N
23	p6	clave123	p6	p6	1	2013-05-01 10:01:28.364041	UPDATE	\N
24	p7	p7	p7	p7	1	2013-05-01 10:01:28.364041	UPDATE	\N
25	p5	clave12345	p5	p5	1	2013-05-01 10:01:28.364041	UPDATE	\N
26	p8	p8	p8	p8	1	2013-05-01 10:01:28.364041	UPDATE	\N
27	p9	p9	p9	p9	1	2013-05-01 10:01:28.364041	UPDATE	\N
28	p5	clave12345	p5	p5	1	2013-05-01 10:01:47.066486	DELETE	\N
29	p10	p10	p10	p10	1	2013-05-01 11:50:16.507051	INSERT	postgres
30	p11	p10	p10	p10	1	2013-05-01 11:50:46.437829	INSERT	jbossuser
31	p3	p3	p3	p3	1	2013-05-01 11:57:46.482392	DELETE	jbossuser
32	p4	p4	p4	p4	1	2013-05-01 11:57:47.918483	DELETE	jbossuser
33	p6	clave123	p6	p6	1	2013-05-01 11:57:49.023314	DELETE	jbossuser
34	p7	p7	p7	p7	1	2013-05-01 11:57:50.034102	DELETE	jbossuser
35	p8	p8	p8	p8	1	2013-05-01 11:57:50.958435	DELETE	jbossuser
36	p9	p9	p9	p9	1	2013-05-01 11:57:51.744722	DELETE	jbossuser
37	p10	p10	p10	p10	1	2013-05-01 11:57:52.819304	DELETE	jbossuser
38	p11	p10	p10	p10	1	2013-05-01 11:57:53.818676	DELETE	jbossuser
39	guest	35675e68f4b5af7b995d9205ad0fc43842f16450			1	2013-05-01 11:58:05.747474	INSERT	jbossuser
40	jerviver21@hotmail.com	f589d8343e1136ab73d2e502a4222c05a1ccbd2d	JERSON VIVEROS	jerviver21@hotmail.com	1	2013-06-10 09:55:29.220884	INSERT	postgres
43	jerviver21@hotmail.com	f589d8343e1136ab73d2e502a4222c05a1ccbd2d	JERSON VIVEROS	jerviver21@hotmail.com	1	2013-06-10 10:14:17.485736	UPDATE	postgres
44	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	1	2013-06-10 10:15:21.225127	UPDATE	postgres
45	jerviver21@gmail.com	8927bd748f26a7258a01e318a7e1e7585458a228	JERSON VIVEROS	jerviver21@gmail.com	0	2013-06-10 16:51:13.910404	INSERT	postgres
46	jerviver21@gmail.com	8927bd748f26a7258a01e318a7e1e7585458a228	JERSON VIVEROS	jerviver21@gmail.com	0	2013-06-10 16:51:13.910404	UPDATE	postgres
47	jerviver21@gmail.com	8927bd748f26a7258a01e318a7e1e7585458a228	JERSON VIVEROS	jerviver21@gmail.com	1	2013-06-10 16:59:31.004123	UPDATE	postgres
48	asesor1	ac0e9adf4fcdcb2359a220c20c4dd64b15a11781			1	2013-08-19 11:38:21.154247	INSERT	postgres
49	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	1	2013-08-23 10:27:56.969547	DELETE	postgres
50	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	0	2013-08-23 10:29:06.647458	INSERT	postgres
51	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	0	2013-08-23 10:29:06.647458	UPDATE	postgres
52	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	1	2013-08-23 10:31:45.264295	UPDATE	postgres
53	jerviver21@gmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@gmail.com	1	2013-09-25 11:03:11.132138	UPDATE	postgres
54	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	1	2013-10-15 04:17:17.306839	DELETE	postgres
55	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	0	2013-10-15 04:18:17.759431	INSERT	postgres
56	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	0	2013-10-15 04:18:17.759431	UPDATE	postgres
57	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	1	2013-10-15 04:19:14.7436	UPDATE	postgres
\.


--
-- Name: aud_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('aud_users_id_seq', 57, true);


--
-- Data for Name: campos_formulario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY campos_formulario (id, id_formulario) FROM stdin;
\.


--
-- Name: campos_formulario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('campos_formulario_id_seq', 1, false);


--
-- Data for Name: campos_tipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY campos_tipo (id, id_tipoclasificado, subtipo1, subtipo2, subtipo3, subtipo4, subtipo5, valor, nombre_ofertante, titulo_oferta) FROM stdin;
4	4	t	f	f	f	f	t	f	f
1	1	t	t	t	t	f	t	f	f
3	3	t	t	f	f	f	t	f	f
2	2	t	t	f	f	f	t	t	t
\.


--
-- Name: campos_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('campos_tipo_id_seq', 4, true);


--
-- Data for Name: campos_validacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY campos_validacion (id, id_campo, id_validacion) FROM stdin;
\.


--
-- Name: campos_validacion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('campos_validacion_id_seq', 1, false);


--
-- Data for Name: clasificado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY clasificado (id, id_tipo, id_subtipo1, id_subtipo2, id_subtipo4, id_subtipo5, clasificado, fecha_ini, fecha_fin, precio, id_subtipo3, id_subtipo_publicacion, num_dias, num_palabras, id_pedido, id_estado, valor_oferta, id_subtipo6, id_currency_oferta, url_img0, nombre_ofertante, titulo_oferta) FROM stdin;
332	1	5	8	124	120	Vendo bonito y amplio departamento 1er piso, en Urb. privada residencial con vigilacia las 24 horas, cuenta con 3 dormitorios,sala, comedor, cocina con reposteros altos y bajos, cochera , patio.\r\n\r\nAT: 145m2\r\n\r\nPRECIO:US$155,000\r\n\r\nINFORMES:250584 - 792967 - 959509654 958958629	2014-01-16	2014-02-13	0.00	38	4	0	0	125	2	155000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/332/IMG0.jpg	\N	\N
333	1	5	7	125	121	Departamento amplio y bien iluminado,amplios dormitorios, sala de star, estudio,dormitorio principal con walking closet y baño privado, baño familiar, baño social, cocina con lavandería de diario, área de servicio exclusiva en azotea, cochera techada y deposito:\r\n\r\nPrecio: US$ 170 000 Número de habitaciones: 3 Tamaño: 170 m² Municipalidad: Yanahuara Dirección: Umacollo Tipo: Departamentos, Se vende	2014-01-16	2014-02-13	0.00	38	4	0	0	126	2	170000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/333/IMG0.jpg	\N	\N
335	1	5	8	123	118	Departamentos en la mejor zona Ecológica de Arequipa, excelente clima, a 10 minutos del centro, con estacionamientos, Edificios con ascensor, financiados hasta 20 años con 10% de inicial\r\n\r\nWilfredo Ramos Navarro:959000025\r\nPrecio: 42.000\r\nCercado: Arequipa	2014-01-16	2014-02-13	0.00	13	4	0	0	128	2	42000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/335/IMG0.jpg	\N	\N
336	1	5	8	123	118	AREA : 70 M2 APROX\r\n\r\nDISTRITO : CAYMA\r\n\r\nREFERENCIA : A 5 CUADRAS DE SAGA\r\n\r\nPRECIO : $50 000\r\n\r\nDESCRIPCION: UBICADO EN UNA QUINTA PRIVADA EN YANAHUARA IDEAL PARA EJECUTIVO O PAREJAS SOLAS DE 70 M2 CONSTA DE UNA SALA STAR, UN DORMITORIO, UN BAÑO, COCINA, CON COCHERA\r\n\r\nPrimer Piso.\r\n\r\nTELEFONOS: 996132877 RPM #986482 #0230116 RPC 953502867 977297939	2014-01-16	2014-02-13	0.00	14	4	0	0	129	2	50000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/336/IMG0.jpg	\N	\N
334	1	5	8	123	118	VENDO LINDO MINIDEPARTAMENTO EN CERRO COLORADO\r\n\r\nAREA: 55M2 APROX.\r\n\r\nHABITACIONES: 2\r\n\r\nBAÑOS: 1\r\n\r\nPRECIO: $50000\r\n\r\nDESRIPCION: DOS HABITACIONES, 1 SALA DE ESTUDIO, 1 BAÑO, COCINA, PEQUEÑA SALA.\r\n\r\nTELÉFONOS: 996132877 / RPM #986482 / RPM #0230116 / RPC 953502867.	2014-01-16	2014-02-13	0.00	15	4	0	0	127	2	50000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/334/IMG0.jpg	\N	\N
337	1	5	8	123	118	VENDO MINI DEPARTAMENTO $50 000\r\n\r\nAREA : 70 M2 APROX\r\n\r\nDISTRITO : CAYMA\r\n\r\nREFERENCIA : A 5 CUADRAS DE SAGA\r\n\r\nPRECIO : $50 000 conversable\r\n\r\nDESCRIPCION: UBICADO EN UNA QUINTA PRIVADA EN YANAHUARA, ZONA TRANQUILA Y EXCLUSIVA, EN UN PRIMER PISO, IDEAL PARA EJECUTIVO O PAREJAS SOLAS DE 70 M2 CONSTA DE UNA SALA STAR, UN DORMITORIO, UN BAÑO, COCINA, CON COCHERA, ACABADOS DE PRIMERA\r\n\r\nUNICASAAQP\r\n\r\nunicasaaqpinmobiliaria@gmail.com\r\n\r\ncalle cortaderas 107-Yanahuara\r\n\r\nteléfonos 054 - 274927 / RPM #986482 / RPC 953502867	2014-01-16	2014-02-13	0.00	14	4	0	0	130	2	50000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/337/IMG0.jpg	\N	\N
339	1	5	8	123	118	Se vende bonito departamento en segundo piso, con cochera, tres dormitorios, piso de parquet, closets, reposteros altos y bajos, a 5 minutos del centro,del Parque Lambramani y Aventura Plaza.\r\n\r\nRony Zegarra:969991617\r\nPrecio: US$ 47 000\r\nArequipa Cercado	2014-01-16	2014-02-13	0.00	13	4	0	0	132	2	47000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/339/IMG0.jpg	\N	\N
330	1	5	8	124	119	EDIFICIO RESIDENCIAL SANTA ELISA - POR LOS ANGELES DE CAYMA\r\n\r\nEDIFICIO RESIDENCIAL SANTA ELISA, 18 DEPARTAMENTOS CON LOS MEJORES ACABADOS EN ZONA EXCLUSIVA, EN PRE VENTA.\r\n\r\n\r\n75 M2 - 91,000 US$\r\n\r\n\r\n95 M2 - 115,000 US$\r\n\r\n\r\n119 M2 - 144, 00 US$\r\n\r\n\r\n169 M2 - 191,000 US$\r\n\r\n\r\nDatos de contacto:\r\nLortie Bienes Raices\r\n(054) 799091\r\n	2014-01-16	2014-01-30	15.00	14	5	0	0	123	2	100000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/330/IMG0.jpg	\N	\N
331	1	5	8	124	120	Precio 125 mil dolares, muy bien ubicado en Yanahuara. frente al Club internacional, en quinta residencial privada de 110 metros,\r\n\r\nconsta de 3 dormitorios con closet, cocina, comedor con reposteros, sala, comedor, hall y lavanderia, INFORMES: 508701	2014-01-16	2014-02-13	0.00	38	4	0	0	124	2	125000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/331/IMG0.jpg	\N	\N
340	1	6	8	125	138	EXCLUSIVO DEPARTAMENTO EN ALQUILER CERCA ASILO LIRA\r\n\r\nCodigo: D-00460\r\n\r\nExclusivo departamento amoblado en alquiler cerca Asilo Lira, cuenta con vigilancia privada las 24 horas, vista a jardin, balcón, acceso area de parrilladas en último piso.\r\n\r\nDescripción:\r\n\r\nAC 180m2\r\n\r\nSala, comedor, cocina, habitacion principal con walking closet y baño incorporado con sauna, dos habitaciones que comparten un baño, área de lavandería.\r\n\r\nTotalmente equipada.\r\n\r\nRenta Mensual S/.2800\r\n\r\nUNICASAAQP INMOBILIARIA Teléfonos : 996132877 / RPC 953502867 / 977297939 / RPM #0230116\r\n\r\nEmail : info@unicasaaqp.com	2014-01-16	2014-02-13	0.00	38	4	0	0	133	2	2800.00	\N	2	http://s3.amazonaws.com/clasificadosp1/340/IMG0.jpg	\N	\N
341	1	6	8	124	136	1ERA OPCION inmobiliaria alquilo como departamento en el Cercado, ambientes acogedores y bien iluminados\r\n\r\nDescripcion:\r\n\r\nsala comedor\r\n\r\ncocina con reposteros\r\n\r\n02 dormitorios\r\n\r\n01 baño\r\n\r\nPara mayor informacion (054) 340951 - 9580154001 rpm	2014-01-16	2014-02-13	0.00	13	4	0	0	134	2	900.00	\N	2	http://s3.amazonaws.com/clasificadosp1/341/IMG0.jpg	\N	\N
342	1	6	8	125	138	ALQUILO DEPARTAMENTO AMPLIO EN URB. SEÑORIAL CAYMA\r\n\r\nCodigo: D-00277\r\n\r\nAlquilo amplio Departamento familiar amoblado ubicado a pocas cuadras de la Av. Cayma en zona exclusiva. Estratégicamente ubicado, cercano a bancos, restaurantes, centros comerciales.\r\n\r\nDescripcion:\r\n\r\nArea 170m2.\r\n\r\nUbicado en tercer piso.\r\n\r\nConsta de Amplia cochera, Sala comedor, Cocina con comedor de diario, baño social, sala de estudio, habitacion principal con walking closet y baño incluido, dos habitaciones con closets en melamine y un baño commpleto.\r\n\r\nArea de servicio y lavanderia.\r\n\r\nRenta Mensual S/. 3000.00\r\n\r\nTeléfonos : 996132877 / RPC 953502867 / 977297939 / RPM #0230116\r\n\r\nEmail : info@unicasaaqp.com	2014-01-16	2014-02-13	0.00	14	4	0	0	135	2	3000.00	\N	2	http://s3.amazonaws.com/clasificadosp1/342/IMG0.jpg	\N	\N
343	1	5	7	123	117	Alquilo departamento amoblado en Vallecito de un dormitorio, salita, kichenett, servicios higienicos completos\r\n\r\nS/. 1000\r\n\r\nInteresados contactarse al RPC 940163354 ó al RPM #959372141	2014-01-16	2014-02-13	0.00	12	4	0	0	136	2	1000.00	\N	2	http://s3.amazonaws.com/clasificadosp1/343/IMG0.jpg	\N	\N
344	1	6	8	124	137	Alquilo hermoso departamento en Piedra Santa, Residencial privada 1er piso, tres dormitorios con closet empotrados el dormitorio principal con baño privado, sala comedor, cocina con reposteros altos y bajos, 3 baños, cuarto y baño de servicio, lavanderia, cochera, patio, tendales. Tiene amplios y comodos ambientes el departamento es el semi estreno, ambientes bien iluminados.\r\n\r\nINFORMES:RPC 958958629 - 958958628 - #648266 #648267 - 250584\r\n	2014-01-16	2014-02-13	0.00	38	4	0	0	137	2	1700.00	\N	2	http://s3.amazonaws.com/clasificadosp1/344/IMG0.jpg	\N	\N
346	1	6	8	124	138	1ERA. OPCIÓN INMOBILIARIA - ALQUILA DEPARTAMENTO AMOBLADO - YANAHUARA\r\n\r\nDistribución:\r\n\r\n3er. Piso:\r\n\r\n03 Dormitorios con closets de madera\r\n\r\nSala-comedor\r\n\r\nKichenette\r\n\r\n3 Dormitorios\r\n\r\n2 Baños\r\n\r\nMenaje Completo\r\n\r\nIndependiente y Seguro\r\n\r\nCochera\r\n\r\nMayor información al 340951 o visítenos en Av. Ejercito 101 Edificio Nasya Of.312\r\n\r\n2000s	2014-01-17	2014-02-14	0.00	38	4	0	0	139	2	2000.00	\N	2	http://s3.amazonaws.com/clasificadosp1/346/IMG0.jpg	\N	\N
348	3	66	73	\N	\N	Fabricado en 2011\r\nUsado\r\nKilómetros: 48705 km.\r\nPuertas: 4 puertas\r\nCombustible: Gasolina\r\nPublicado el 25/11/2013	2014-01-17	2014-02-14	0.00	128	4	0	0	141	2	3000.00	\N	2	http://s3.amazonaws.com/clasificadosp1/348/IMG0.jpg	\N	\N
349	3	66	73	\N	\N	El nuevo Chevrolet Sail Hatchback llega al país para ofrecerte la mejor combinación entre equipamiento, diseño moderno, espacio y precio. Este compacto funcional valora quién eres y adónde quieres llegar en la vida. Deja superar tus expectativas con un auto ágil, seguro y totalmente accesible que incorpora asiento posterior rebatible para una mayor practicidad.\r\n\r\nMarca\tChevrolet\r\nModelo\tSail\r\nVersion\tHatchback\r\nKilometrajes\t0 Km\r\nPrecio\tUS$ 12,490 (S/. 37,470)	2014-01-17	2014-02-14	0.00	130	4	0	0	142	2	12490.00	\N	1	http://s3.amazonaws.com/clasificadosp1/349/IMG0.jpg	\N	\N
350	3	66	73	\N	\N	Fabricado en 2010\r\nUsado\r\nEs de color rojo vino\r\nUbicado en san martin de porras, Lima, Lima\r\nKilómetros: 46000 km.\r\nPuertas: 4 puertas\r\nCombustible: Convertido a Gas\r\nDirección: Mecánica\r\nTimón: Original\r\nTapizado: cuero negro\r\nPublicado el 30/12/2013	2014-01-17	2014-02-14	0.00	130	4	0	0	143	2	12500.00	\N	1	http://s3.amazonaws.com/clasificadosp1/350/IMG0.png	\N	\N
351	3	67	73	\N	\N	Fabricado en 2004\r\nUsado\r\nKilómetros: 88227 km.\r\nPuertas: 4 puertas\r\nCombustible: Gasolina\r\nPublicado el 7/12/2013	2014-01-17	2014-02-14	0.00	128	4	0	0	144	2	4000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/351/IMG0.jpg	\N	\N
359	4	102	\N	\N	\N	Precio\r\nS./670.00\r\n\r\nA PEDIDO, Totalmente nuevo 100% Garantía...\r\nSeparalo Ya..Desde el 10%\r\n\r\nllamar a 6710510	2014-01-17	2014-02-14	0.00	\N	4	0	0	152	2	670.00	\N	2	http://s3.amazonaws.com/clasificadosp1/359/IMG0.jpg	\N	\N
361	2	48	50	\N	\N	Con experiencia académica \r\n\r\nRequisitos:\r\n-Título Profesional nivel superior en Secretariado Ejecutivo.\r\n-Experiencia laboral ejerciendo funciones en el cargo.\r\n-Experiencia docente en el área secretarial. \r\n-Experiencia en elaboración de planes auriculares y sílabos por competencias. \r\n-Habilidad para liderar y motivar grupos humanos. \r\n-Disponibilidad a tiempo completo.\r\n\r\nPresentarse el martes 14 de enero de 3 a 7pm. en Av. San Borja Norte 294 . San Borja	2014-01-17	2014-02-14	0.00	113	4	0	0	154	2	3600.00	\N	2	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	Institución de Educación, San Borja, Lima	CORDINADORA DE SECRETARIADO
352	3	66	73	\N	\N	Sedan Malibú Modelo LTZ (El mas equipado, 100% Made in USA), Fantástica aceleración, sonido y conducción, Asientos de cuero dos tonos, SUNROOF electrico, Cuero original en dos tonos en asientos y timòn , super seguro-08 airbags de fabrica, frenos ABS, antipatinaje, Caja automatica Tiptronic c/ Paddle Shifters, El Motor es el mismo del CAMARO 2013= 3.6 Litros V6-doble eje de levas, 252 HP , doble tubo de escape cromado, CD changer, crucero y ONSTAR, Keyless y encendido a distancia, asientos electricos y A/C, pedal graduable,Dimensiones similares al Honda Accord , Nissan Altima, BMW535, BMW525i ,Lexus GS350 y Volvo S80 , posee Aros Cromados de 18" , llantas radiales perfil 50 , citas para verlo en Miraflores, al 991366060. Sin choques, excelente estado, Elegancia,Seguridad, Potencia y Confort maximos.(cambios manuales en timón y caja automatica) amplia maletera, Modelo LTZ Maximo modelo americano, se entrega con SOAT y placas UNICO DUEÑO. Video Youtube copie link: http://www.youtube.com/watch?v=PydHeowYGQg y Mas informacion solicitarla al mail: danieldavila2005@yahoo.es\r\n\r\nPrecio: US$ 19,500\r\n(S/. 50,700)	2014-01-17	2014-02-14	0.00	131	4	0	0	145	2	19500.00	\N	1	http://s3.amazonaws.com/clasificadosp1/352/IMG0.jpg	\N	\N
358	4	102	\N	\N	\N	Vendo Sony DSCF707 ,con estuche ,sin cargador algun descripciones : Precio drogo S/. 300 soles	2014-01-17	2014-02-14	0.00	\N	4	0	0	151	2	300.00	\N	2	http://s3.amazonaws.com/clasificadosp1/358/IMG0.jpg	\N	\N
354	2	48	50	\N	\N	Parrilladas Peruanas Sociedad Anonima:\r\n\r\n-\tRegistro y revisión de ventas mensuales.\r\n-\tRevisión y validación de documentación contable compras, ventas, etc.\r\n-\tProgramación de pagos semanales, mensuales, trimestrales y anuales.\r\n-\tEmisión de cheques, transferencias interbancarias, pagos en línea.\r\n-\tControl de vencimientos (facturas, letras, seguros, pagarés, impuestos, AFPs, remuneraciones, etc.).\r\n-\tProvisión, archivo y ordenamiento de las facturas por pagar, servicios, contratos, etc.\r\n-\tElaboración de reportes de entregas a rendir.\r\n-\tElaboración de reportes bancarios\r\n-\tAdministración del mantenimiento de las instalaciones de la empresa, compras de bienes, suministros, servicios y coordinación con proveedores.\r\n-\tRealizar declaración de impuestos.\r\n-\tManejo de cobros y pagos en cuentas corrientes y caja chica.\r\n-\tResponsabilidad\r\n-\tProactividad\r\n-\tSentido de urgencia\r\n-\tComunicación efectiva\r\n-\tTrabajo en equipo\r\n-\tCapacidad de análisis\r\n-\tOrganización y planificación\r\n\r\n\r\n	2014-01-17	2014-02-14	0.00	111	4	0	0	147	2	2000.00	\N	2	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	Parrilladas Peruanas Sociedad Anonima	ADMINISTRATIVOR
355	2	48	50	\N	\N	Pae Peru Ingenieria:\r\n\r\nNuestro cliente, importante empresa del rubro de servicios alimenticios, se encuentra en la búsqueda de un profesional para cubrir la vacante de:\r\n\r\n\r\nADMINISTRADOR DE CONTRATO (ADM-GC)\r\n\r\nRequisitos:\r\n•Con más de 2 años de experiencia en rubro de alimentos.\r\n•Experiencia mínima de 2 años en Jefaturas o coordinación.\r\n•Estudios Técnicos o Superiores en Administración, Administración Hotelera o afines.\r\n•Experiencia en realizar trabajo de campo, supervisando las operaciones en diferentes sedes.\r\n•Disponibilidad para trabajar según la operación lo amerite fines de semana.\r\nFunciones:\r\n•Supervisión directa de 11 sedes.\r\n•Responsable de la supervisión del personal.\r\n•Coordinación con la asistencia del personal.\r\n•Responsable de optimizar procesos.\r\n•Responsable en conjunto con el área Contable de analizar y optimizar costos.\r\n•Experiencia en elaboración de inventarios.\r\n\r\nBeneficios:\r\n\r\n•Ingreso a planilla y todos los beneficios de ley.\r\n•Oportunidad de línea de carrera.\r\n\r\n\r\nLos interesados enviar su CV con código (ADM-GC) a iamonteza(arrob.a)pae.cc indicando pretensiones salariales.	2014-01-17	2014-02-14	0.00	112	4	0	0	148	2	3000.00	\N	2	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	Pae Peru Ingenieria	ADMINISTRATIVOR
356	2	48	50	\N	\N	PROSEGUR: Gestor de Cobranza \r\nNuestro cliente, importante empresa del rubro de servicios alimenticios, se encuentra en la búsqueda de un profesional para cubrir la vacante de:\r\n\r\n\r\nADMINISTRADOR DE CONTRATO (ADM-GC)\r\n\r\nRequisitos:\r\n•Con más de 2 años de experiencia en rubro de alimentos.\r\n•Experiencia mínima de 2 años en Jefaturas o coordinación.\r\n•Estudios Técnicos o Superiores en Administración, Administración Hotelera o afines.\r\n•Experiencia en realizar trabajo de campo, supervisando las operaciones en diferentes sedes.\r\n•Disponibilidad para trabajar según la operación lo amerite fines de semana.\r\nFunciones:\r\n•Supervisión directa de 11 sedes.\r\n•Responsable de la supervisión del personal.\r\n•Coordinación con la asistencia del personal.\r\n•Responsable de optimizar procesos.\r\n•Responsable en conjunto con el área Contable de analizar y optimizar costos.\r\n•Experiencia en elaboración de inventarios.\r\n\r\nBeneficios:\r\n\r\n•Ingreso a planilla y todos los beneficios de ley.\r\n•Oportunidad de línea de carrera.\r\n\r\n\r\nLos interesados enviar su CV con código (ADM-GC) a iamonteza(arrob.a)pae.cc indicando pretensiones salariales.	2014-01-17	2014-02-14	0.00	111	4	0	0	149	2	2000.00	\N	2	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	PROSEGUR	GESTOR DE COBRANZA
357	2	48	50	\N	\N	Adeco: Supervisor autoservicio.\r\n\r\nFunciones:\r\nSupervisar y verificar el trabajo de los mercaderistas en lo referente a funciones encomendadas.\r\nSeguimiento constante del cumplimiento de los objetivos del personal a cargo y cliente.\r\nResponsable de la gestión administrativa del personal a cargo.\r\nMantener comunicación constante con jefes de área, canalizar adecuadamente al cliente sobre las acciones y estrategias de la competencia\r\nRequisitos:\r\n• Experiencia de 1 año como supervisor de autoservicios y/o canal mayorista, deseable experiencia en rubro de consumo masivo.\r\n• Conocimientos de office a nivel intermedio\r\n• Disponibilidad completa de horarios en especial de: 09:00 a.m. - 07:00 p.m. de Lunes a Domingo con un día de descanso.\r\n• Competencias: Liderazgo, sociable, responsable, empático y orientado al cliente.\r\n\r\nOfrecemos:\r\n• Remuneración: S/. 2,550\r\n• Asignación por movilidad.\r\n• Ingreso a planilla con todos los beneficios de acuerdo a ley.\r\n• Pertenecer a una compañía líder.\r\n\r\n	2014-01-17	2014-02-14	0.00	114	4	0	0	150	2	5000.00	\N	2	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	ADECO	Supervisor autoservicio
353	2	48	50	\N	\N	AUXILIAR ADMINISTRATIVO\r\nEmpresa: PROSEGUR\r\n\r\n•\tElaborar cuadros de productividad por áreas.\r\n•\tAtender consultas de clientes con respecto a recepción y entrega de tarjetas.\r\n•\tElaborar documentos propios de las actividades del área.\r\n•\tElaborar reporte de producción y entregas para ser enviado al área de facturación en los plazos establecidos.\r\n•\tElaborar y archivar documentación interna y externa.\r\n•\tCoordinar con almacén y el cliente el abastecimiento oportuno de stock de formatería.\r\n•\tRealizar otras funciones que su jefe inmediato le asigne.\r\nREQUISITOS:\r\n\r\n•\tSecundaria completa.\r\n•\tExperiencia mínima de 1 año en el puesto realizando funciones similares.\r\n•\tManejo de Office a nivel intermedio o avanzado, de preferencia Excel.\r\n\r\nHorario de trabajo de Lunes a Viernes de 8:30am a 6:00pm y sábado 9am a 12:00 pm \r\n\r\nPresentarse el Viernes 17 de Enero a las 10:00 AM con DNI y CV impreso en Av. Morro Solar 1086 - Surco. Referencia: Prosegur de Panamericana Sur (Km. 8). Ingresar por Centro Bancario. Preguntar por Srta. Ratto	2014-01-17	2014-02-14	0.00	112	4	0	0	146	2	2500.00	\N	2	http://s3.amazonaws.com/clasificadosp1/F1/logo1.png	PROSEGUR	AUXILIAR ADMINISTRATIVO
360	2	48	50	\N	\N	¡Buscamos personas ambiciosas, interesado en ganar dinero!\r\nTe invitamos a formar parte de nuestro equipo!\r\nRequisitos:\r\n- Egresados del programa de certficación de caja.\r\n- Experiencia mínima de 1 año realizando labores en caja.\r\n- Buena actitud para atención y servicio al cliente.\r\n- Manejo de herramientas de cómputo a nivel usuario.\r\n- Disponibilidad a tiempo completo.\r\nOfrecemos:\r\n- Ingreso directo a planilla, bonos individuales y por trabajo en equipo.\r\n- Seguro de vida, utilidades, capacitaciones constantes.\r\n- Línea de carrera.\r\n- Descuentos especiales en compra de nuestros productos.\r\n- Reconocimientos nacionales e internacionales a nuestros mejores trabajadores y sus familias.\r\n\r\nAnímate, arriesgate, esfuérzate y triunfa tú puedes ser parte de este grupo de gente exitosa!!\r\n\r\nPara Barranco, Chorrillos, San Juan de Miraflores, Canevaro, Aviación, Surco, Surquillo, La Molina y Manchay.	2014-01-17	2014-02-14	0.00	112	4	0	0	153	2	2200.00	\N	2	http://s3.amazonaws.com/clasificadosp1/360/IMG0.jpg	BANCO AZTECA. La Molina, Lima	CAJEROS LA MOLINA
362	3	67	73	\N	\N	Fabricado en 2004\r\nUsado\r\nKilómetros: 88227 km.\r\nPuertas: 4 puertas\r\nCombustible: Gasolina\r\nPublicado el 7/12/2013	2014-01-17	2014-02-14	0.00	128	4	0	0	155	2	4000.00	\N	1	http://s3.amazonaws.com/clasificadosp1/362/IMG0.jpg	\N	\N
\.


--
-- Name: clasificado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('clasificado_id_seq', 362, true);


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY currencies (id, nombre, cambio, simbolo) FROM stdin;
1	DOLARES	2.80	US$
2	SOLES	0.36	S/.
\.


--
-- Data for Name: data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY data (nombre, descripcion, id) FROM stdin;
TIPOS_ID	Representa los tipos de identificación que puede tener una persona	1
TIPO_PUBLICACION	tipos de publicación	500
\.


--
-- Data for Name: dias_precios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dias_precios (id, id_subtipo_publicacion, iddia, nombre_dia, id_precio) FROM stdin;
1	1	1	DOMINGO	2
2	1	2	LUNES	1
3	1	3	MARTES	1
4	1	4	MIERCOLES	1
5	1	5	JUEVES	1
6	1	6	VIERNES	1
7	1	7	SABADO	1
8	2	1	DOMINGO	5
9	2	2	LUNES	4
10	2	3	MARTES	4
11	2	4	MIERCOLES	4
12	2	5	JUEVES	4
13	2	6	VIERNES	4
14	2	7	SABADO	4
15	3	1	DOMINGO	8
16	3	2	LUNES	7
17	3	3	MARTES	7
18	3	4	MIERCOLES	7
19	3	5	JUEVES	7
20	3	6	VIERNES	7
21	3	7	SABADO	7
29	1	100	FESTIVO	3
30	2	100	FESTIVO	6
31	3	100	FESTIVO	9
\.


--
-- Data for Name: entidades_pago; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY entidades_pago (id, nombre, num_cuenta_recaudo, clave, direccion_ip, nombre_usuario, mensaje_pago) FROM stdin;
1	PAGAR EN SEDE DEL PERIODICO	\N	\N	\N	\N	Acerquece a una sede del periodico y utilice el código de pago COD_PAGO para realizar su pago
2	BANCO DE CRÉDITO	\N	\N	\N	\N	Acerquese a un agente BCP o utilice viabcp.com y utilice el código de pago COD_PAGO para realizar su pago
\.


--
-- Data for Name: estados_clasificado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estados_clasificado (id, nombre) FROM stdin;
1	PEDIDO POR PAGAR
2	PUBLICADO
3	CANCELADO
4	PEDIDO VENCIDO
5	VENDIDO
6	EXPIRADO
\.


--
-- Data for Name: estados_pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estados_pedido (id, nombre) FROM stdin;
1	ACTIVO PARA PAGO
2	PAGO
3	VENCIDO
4	CANCELADO
\.


--
-- Data for Name: festivos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY festivos (fecha) FROM stdin;
\.


--
-- Data for Name: formulario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY formulario (id, nombre, descripcion) FROM stdin;
\.


--
-- Name: formulario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('formulario_id_seq', 1, false);


--
-- Data for Name: group_rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY group_rol (id, id_rol, id_group) FROM stdin;
3	1	1
4	2	1
6	2	3
7	3	3
8	2	2
9	4	2
\.


--
-- Name: group_rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('group_rol_id_seq', 9, true);


--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY groups (id, codigo, descripcion) FROM stdin;
1	MASTER	
2	USUARIOS	
3	ASESORES	
\.


--
-- Name: groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('groups_id_seq', 3, true);


--
-- Data for Name: idiomas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY idiomas (id, nombre) FROM stdin;
es	ESPAÑOL
en	INGLES
\.


--
-- Data for Name: imagenes_publicidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY imagenes_publicidad (id, url_fuente, nombre_cliente, nid, telefono, url_aterrizaje, id_tipo_fuente) FROM stdin;
3	http://ak2.img.e-planning.net/esb/4/0/1c4e/21b9068a2a477d25.swf	alfaguara			http://www.constructoraalfaguara.com/	2
4	http://us.img.e-planning.net/esb/4/0/1c4e/2613c4664160fc50.swf	mba1			http://www.icesi.edu.co/maestrias/administracion/	2
6	http://ak2.img.e-planning.net/esb/4/0/1c4e/84343f5509c0f82d.swf	montealto			http://historico.elpais.com.co/popups/icprefabricados/aterrizaje.html	2
7	http://ak2.img.e-planning.net/esb/4/0/1c4e/17209f2b8051bc0f.gif	yanaconas			http://www.yanaconasmotor.co/index.php?option=com_vehiclemanager&task=showCategory&catid=49&Itemid=56	1
8	http://ced.sascdn.com/diff/484/2707172/160x60-2.swf	bolivar			http://minisitios.eltiempo.com/libertador/	2
2	http://us.img.e-planning.net/esb/4/0/1c4e/a2836ed870dca921.swf	melendez1			http://www.constructoramelendez.com/proyectos-melendez/proyectos-oferta/senderos-del-rio.html	2
5	/home/server/appfiles/img_publicidad/toscana1.gif	melendez2			http://www.constructoramelendez.com/proyectos-melendez/proyectos-oferta/toscana.html	1
\.


--
-- Name: imagenes_publicidad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('imagenes_publicidad_id_seq', 8, true);


--
-- Data for Name: img_clasificado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY img_clasificado (id, url, extension, id_clasificado) FROM stdin;
13	http://s3.amazonaws.com/clasificadosp1/330/IMG0.jpg	jpg	330
14	http://s3.amazonaws.com/clasificadosp1/330/IMG1.jpg	jpg	330
15	http://s3.amazonaws.com/clasificadosp1/331/IMG0.jpg	jpg	331
16	http://s3.amazonaws.com/clasificadosp1/331/IMG1.jpg	jpg	331
17	http://s3.amazonaws.com/clasificadosp1/331/IMG2.jpg	jpg	331
18	http://s3.amazonaws.com/clasificadosp1/331/IMG3.jpg	jpg	331
19	http://s3.amazonaws.com/clasificadosp1/332/IMG0.jpg	jpg	332
20	http://s3.amazonaws.com/clasificadosp1/332/IMG1.jpg	jpg	332
21	http://s3.amazonaws.com/clasificadosp1/332/IMG2.jpg	jpg	332
22	http://s3.amazonaws.com/clasificadosp1/332/IMG3.jpg	jpg	332
23	http://s3.amazonaws.com/clasificadosp1/333/IMG0.jpg	jpg	333
24	http://s3.amazonaws.com/clasificadosp1/333/IMG1.jpg	jpg	333
25	http://s3.amazonaws.com/clasificadosp1/333/IMG2.jpg	jpg	333
26	http://s3.amazonaws.com/clasificadosp1/333/IMG3.jpg	jpg	333
27	http://s3.amazonaws.com/clasificadosp1/333/IMG4.jpg	jpg	333
28	http://s3.amazonaws.com/clasificadosp1/334/IMG0.jpg	jpg	334
29	http://s3.amazonaws.com/clasificadosp1/335/IMG0.jpg	jpg	335
30	http://s3.amazonaws.com/clasificadosp1/335/IMG1.jpg	jpg	335
31	http://s3.amazonaws.com/clasificadosp1/336/IMG0.jpg	jpg	336
32	http://s3.amazonaws.com/clasificadosp1/336/IMG1.jpg	jpg	336
33	http://s3.amazonaws.com/clasificadosp1/337/IMG0.jpg	jpg	337
34	http://s3.amazonaws.com/clasificadosp1/337/IMG1.jpg	jpg	337
35	http://s3.amazonaws.com/clasificadosp1/337/IMG2.jpg	jpg	337
36	http://s3.amazonaws.com/clasificadosp1/337/IMG3.jpg	jpg	337
37	http://s3.amazonaws.com/clasificadosp1/337/IMG4.jpg	jpg	337
38	http://s3.amazonaws.com/clasificadosp1/337/IMG5.jpg	jpg	337
39	http://s3.amazonaws.com/clasificadosp1/339/IMG0.jpg	jpg	339
40	http://s3.amazonaws.com/clasificadosp1/339/IMG1.jpg	jpg	339
41	http://s3.amazonaws.com/clasificadosp1/339/IMG2.jpg	jpg	339
42	http://s3.amazonaws.com/clasificadosp1/340/IMG0.jpg	jpg	340
43	http://s3.amazonaws.com/clasificadosp1/341/IMG0.jpg	jpg	341
44	http://s3.amazonaws.com/clasificadosp1/341/IMG1.jpg	jpg	341
45	http://s3.amazonaws.com/clasificadosp1/341/IMG2.jpg	jpg	341
46	http://s3.amazonaws.com/clasificadosp1/341/IMG3.jpg	jpg	341
47	http://s3.amazonaws.com/clasificadosp1/341/IMG4.jpg	jpg	341
48	http://s3.amazonaws.com/clasificadosp1/341/IMG5.jpg	jpg	341
49	http://s3.amazonaws.com/clasificadosp1/342/IMG0.jpg	jpg	342
50	http://s3.amazonaws.com/clasificadosp1/342/IMG1.jpg	jpg	342
51	http://s3.amazonaws.com/clasificadosp1/342/IMG2.jpg	jpg	342
52	http://s3.amazonaws.com/clasificadosp1/342/IMG3.jpg	jpg	342
53	http://s3.amazonaws.com/clasificadosp1/342/IMG4.jpg	jpg	342
54	http://s3.amazonaws.com/clasificadosp1/342/IMG5.jpg	jpg	342
55	http://s3.amazonaws.com/clasificadosp1/343/IMG0.jpg	jpg	343
56	http://s3.amazonaws.com/clasificadosp1/343/IMG1.jpg	jpg	343
57	http://s3.amazonaws.com/clasificadosp1/343/IMG2.jpg	jpg	343
58	http://s3.amazonaws.com/clasificadosp1/343/IMG3.jpg	jpg	343
59	http://s3.amazonaws.com/clasificadosp1/343/IMG4.jpg	jpg	343
60	http://s3.amazonaws.com/clasificadosp1/343/IMG5.jpg	jpg	343
61	http://s3.amazonaws.com/clasificadosp1/344/IMG0.jpg	jpg	344
62	http://s3.amazonaws.com/clasificadosp1/344/IMG1.jpg	jpg	344
63	http://s3.amazonaws.com/clasificadosp1/344/IMG2.jpg	jpg	344
64	http://s3.amazonaws.com/clasificadosp1/344/IMG3.jpg	jpg	344
65	http://s3.amazonaws.com/clasificadosp1/344/IMG4.jpg	jpg	344
66	http://s3.amazonaws.com/clasificadosp1/344/IMG5.jpg	jpg	344
67	http://s3.amazonaws.com/clasificadosp1/346/IMG0.jpg	jpg	346
68	http://s3.amazonaws.com/clasificadosp1/346/IMG1.jpg	jpg	346
69	http://s3.amazonaws.com/clasificadosp1/346/IMG2.jpg	jpg	346
70	http://s3.amazonaws.com/clasificadosp1/346/IMG3.jpg	jpg	346
71	http://s3.amazonaws.com/clasificadosp1/346/IMG4.jpg	jpg	346
72	http://s3.amazonaws.com/clasificadosp1/346/IMG5.jpg	jpg	346
73	http://s3.amazonaws.com/clasificadosp1/348/IMG0.jpg	jpg	348
74	http://s3.amazonaws.com/clasificadosp1/349/IMG0.jpg	jpg	349
75	http://s3.amazonaws.com/clasificadosp1/350/IMG0.png	png	350
76	http://s3.amazonaws.com/clasificadosp1/351/IMG0.jpg	jpg	351
77	http://s3.amazonaws.com/clasificadosp1/352/IMG0.jpg	jpg	352
78	http://s3.amazonaws.com/clasificadosp1/358/IMG0.jpg	jpg	358
79	http://s3.amazonaws.com/clasificadosp1/358/IMG1.jpg	jpg	358
80	http://s3.amazonaws.com/clasificadosp1/358/IMG2.jpg	jpg	358
81	http://s3.amazonaws.com/clasificadosp1/358/IMG3.jpg	jpg	358
82	http://s3.amazonaws.com/clasificadosp1/359/IMG0.jpg	jpg	359
83	http://s3.amazonaws.com/clasificadosp1/359/IMG1.jpg	jpg	359
84	http://s3.amazonaws.com/clasificadosp1/360/IMG0.jpg	jpg	360
85	http://s3.amazonaws.com/clasificadosp1/362/IMG0.jpg	jpg	362
\.


--
-- Name: img_clasificado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('img_clasificado_id_seq', 85, true);


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY menu (id, nombre, id_menu, idioma, descripcion) FROM stdin;
1	RAIZ	\N	es	\N
10782	Generals	1	en	\N
10783	Reports	1	en	\N
10784	Adm. Users	1	en	\N
10785	Publication	1	en	\N
10786	My Account	1	en	\N
10787	Payments	1	en	\N
10788	General	1	es	\N
10789	Reportes	1	es	\N
10790	Admin Usuarios	1	es	\N
10791	Publicaciones	1	es	\N
10792	Mi cuenta	1	es	\N
10793	Consultas	1	es	\N
10794	Pagos	1	es	\N
\.


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('menu_id_seq', 10794, true);


--
-- Data for Name: parametro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY parametro (id, nombre, valor, tipo) FROM stdin;
1	rolMaster	MASTER	AU
6	smtp_host	smtp.gmail.com	MAIL
7	smtp_port	587	MAIL
8	smtp_user	jerviver21@gmail.com	MAIL
9	smtp_clave	T8SbPS8aD9j8JJLC4DnLZg==	MAIL
16	num_reporte	2	CLAS
18	depurar	true	CONF
14	url	http://localhost:8080	APP
19	consultas_x_cache	true	CONF
22	nombre_bucket	clasificadosp1	APP
21	url_imagenes	http://s3.amazonaws.com	APP
2	rutaLog	VDEAWS_TMP_DIR/log	LOG1
3	rutaDescarga	VDEAWS_TMP_DIR/descargas	FILE
4	rutaReporte	VDEAWS_DATA_DIR/reportes	FILE
17	rutaPago	VDEAWS_DATA_DIR/pagos	PAGO
23	b	b	
\.


--
-- Name: parametro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('parametro_id_seq', 23, true);


--
-- Data for Name: parametros_reporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY parametros_reporte (nombre, etiqueta, id_tipo, id, id_data, id_reporte) FROM stdin;
fechaIni	P1	3	1	\N	1
fechaFin	P2	3	2	\N	1
fecha	FECHA:	3	3	\N	2
tipo	TIPO:	5	4	500	2
\.


--
-- Data for Name: pedido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pedido (id, usuario, cod_pago, valor_total, id_estado, cod_confirmacion, id_entidad_pago, fecha_hora_pago, dni_cliente, nombre_cliente, fecha_vencimiento, tipo_pedido) FROM stdin;
146	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N
116	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2013-12-19	\N
147	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS
117	jerviver21@gmail.com	000000000117	25.00	2	\N	1	2013-12-19 00:00:00	\N	JERSON VIVEROS	2013-12-19	CLASIFICADOS IMPRESOS
118	jerviver21@gmail.com	\N	0.00	2	\N	1	\N	\N	JERSON VIVEROS	2013-12-30	\N
120	jerviver21@gmail.com	\N	0.00	2	\N	1	\N	\N	JERSON VIVEROS	2013-12-30	CLASIFICADOS IMPRESOS
121	jerviver21@gmail.com	\N	0.00	2	\N	1	\N	\N	JERSON VIVEROS	2013-12-30	CLASIFICADOS IMPRESOS
119	jerviver21@gmail.com	000000000119	9.90	3	\N	1	\N	\N	JERSON VIVEROS	2014-01-01	\N
148	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS
123	jerviver21@gmail.com	000000000123	15.00	2	\N	1	2014-01-16 00:00:00	\N	JERSON VIVEROS	2014-01-16	\N
124	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N
125	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N
126	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N
127	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS
128	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS
129	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS
130	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS
132	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N
133	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N
134	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	\N
135	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS
136	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS
137	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-16	CLASIFICADOS IMPRESOS
139	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N
141	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N
142	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS
143	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS
144	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS
145	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS
149	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS
150	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N
151	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N
152	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS
153	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N
154	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	CLASIFICADOS IMPRESOS
155	jerviver21@gmail.com	\N	0.00	2	\N	2	\N	\N	JERSON VIVEROS	2014-01-17	\N
\.


--
-- Name: pedido_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pedido_id_seq', 155, true);


--
-- Data for Name: precios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY precios (id, descripcion, precio, procesar_x_palabra) FROM stdin;
1	NORMAL SEMANAL	0.10	t
4	ECONOMICO SEMANAL	0.05	t
7	SUPER ECONOMICO SEMANAL	0.04	t
10	WEB	1.00	f
2	NORMAL DOMINICAL	0.15	t
3	NORMAL FESTIVO	0.20	t
5	ECONOMICO DOMINICAL	0.10	t
6	ECONOMICO FESTIVO	0.15	t
8	SUPER ECONOMICO DOMINICAL	0.11	t
9	SUPER ECONOMICO FESTIVO	0.16	t
\.


--
-- Name: precios_clasificados_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('precios_clasificados_id_seq', 31, true);


--
-- Data for Name: publicidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY publicidad (id, fecha_ini, id_imagen, seccion_page, num_clicks, fecha_fin, num_impresiones, heigh, width) FROM stdin;
39	2013-10-01	2	BS	0	2013-10-31	0	75	550
40	2013-10-01	6	BLII	0	2013-10-31	0	380	190
41	2013-10-01	6	BLIO	0	2013-10-31	0	380	190
42	2013-10-01	8	BLD1O	0	2013-10-31	0	140	180
43	2013-10-01	4	BLD2O	0	2013-10-31	0	180	180
44	2013-10-01	5	BLD1I	0	2013-10-31	0	200	180
45	2013-10-01	3	BLD2I	0	2013-10-31	0	200	180
46	2013-10-01	7	BLD1V	0	2013-10-31	0	600	180
47	2013-10-01	4	BLD1E	0	2013-10-31	0	180	180
\.


--
-- Name: publicidad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('publicidad_id_seq', 47, true);


--
-- Data for Name: reporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reporte (nombre, roles, id_proceso, id) FROM stdin;
R1	ROLE_ADMIN, ROLE_USER	1	1
clasificadosxdia	ROLE_ADMIN, ROLE_USER	1	2
\.


--
-- Data for Name: resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY resource (id, nombre, descripcion, id_menu, url, idioma) FROM stdin;
40005	Params	\N	10782	/general/parametros.xhtml	en
40006	Log	\N	10782	/general/log.xhtml	en
40007	DB	\N	10782	/general/adminBD.xhtml	en
40008	Reports	\N	10782	/reportes/reportes.xhtml	en
40009	Users	\N	10784	/usuarios/usuarios.xhtml	en
40010	Menus	\N	10784	/usuarios/menus.xhtml	en
40011	Groups	\N	10784	/usuarios/grupos.xhtml	en
40012	Roles	\N	10784	/usuarios/roles.xhtml	en
40013	Resources	\N	10784	/usuarios/recursos.xhtml	en
40014	Look and Feel	\N	10782	/general/lookandfeel.xhtml	en
40015	Enviar Mail	\N	10782	/general/mail.xhtml	en
40016	My Orders	\N	10786	/admon/mis_pedidos.xhtml	en
40017	My adds	\N	10786	/admon/mis_clasificados.xhtml	en
40018	Actual Order	\N	10786	/publicacion/pedido.xhtml	en
40019	Inmobiliarium	\N	10785	/consulta/inmobiliario.xhtml	en
40020	Cars	\N	10785	/consulta/vehiculos.xhtml	en
40021	Employment	\N	10785	/consulta/empleo.xhtml	en
40022	Various	\N	10785	/consulta/varios.xhtml	en
40023	Ads to public	\N	10783	/reportes/clasificados.xhtml	en
40024	Payments Simulator	\N	10787	/pagos/simulador_pagos.xhtml	en
40025	Pay Request	\N	10787	/pagos/pagar_pedido.xhtml	en
40026	Change password	\N	10786	/general/change_password.xhtml	en
40027	Public your add	\N	1	/publicacion/tipocla.xhtml	en
40028	Recursos	\N	10790	/usuarios/recursos.xhtml	es
40029	Presentación	\N	10788	/general/lookandfeel.xhtml	es
40030	Enviar Mail	\N	10788	/general/mail.xhtml	es
40031	Mis Pedidos	\N	10792	/admon/mis_pedidos.xhtml	es
40032	Mis Clasificados	\N	10792	/admon/mis_clasificados.xhtml	es
40033	Pedido Actual Avisos Impresos	\N	10792	/publicacion/pedidoimpreso.xhtml	es
40034	Pedido Actual Avisos Web	\N	10792	/publicacion/pedidoweb.xhtml	es
40035	Inmobiliaria	\N	10791	/consultas/inmob_filtro.xhtml	es
40036	Vehículos	\N	10791	/consultas/veh_filtro.xhtml	es
40037	Parametros	\N	10788	/general/parametros.xhtml	es
40038	Empleo	\N	10791	/consultas/empleo_filtro.xhtml	es
40039	Varios	\N	10791	/consultas/varios_filtro.xhtml	es
40040	Clasificados para Imprimir	\N	10793	/reportes/clasificados.xhtml	es
40041	Simulador de Pagos	\N	10794	/pagos/simulador_pagos.xhtml	es
40042	Pago Pedidos	\N	10794	/pagos/pagar_pedido.xhtml	es
40043	Precios	\N	10792	/publicacion/precios.xhtml	es
40044	Log	\N	10788	/general/log.xhtml	es
40045	BD	\N	10788	/general/adminBD.xhtml	es
40046	Reportes	\N	10788	/reportes/reportes.xhtml	es
40047	Usuarios	\N	10790	/usuarios/usuarios.xhtml	es
40048	Menus	\N	10790	/usuarios/menus.xhtml	es
40049	Grupos	\N	10790	/usuarios/grupos.xhtml	es
40050	Roles	\N	10790	/usuarios/roles.xhtml	es
40051	Cambiar Clave	\N	10792	/general/cambiar_clave.xhtml	es
40052	Publique su clasificado	\N	1	/publicacion/tipocla.xhtml	es
\.


--
-- Name: resource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('resource_id_seq', 40052, true);


--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rol (id, codigo, descripcion) FROM stdin;
1	MASTER	
2	ROLE_USER	
3	ASESOR PAGOS	Realiza publicaciones desde la sede del periodiico a los clientes, y recibe pagos de pedidos generados por los clientes.
4	USUARIO	
\.


--
-- Name: rol_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rol_id_seq', 4, true);


--
-- Data for Name: rol_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rol_resource (id, id_resource, id_rol) FROM stdin;
68698	40005	1
68699	40006	1
68700	40007	1
68701	40008	1
68702	40009	1
68703	40010	1
68704	40011	1
68705	40012	1
68706	40013	1
68707	40014	1
68708	40015	1
68709	40016	1
68710	40016	4
68711	40017	1
68712	40017	4
68713	40018	1
68714	40018	4
68715	40019	1
68716	40019	2
68717	40019	3
68718	40019	4
68719	40020	1
68720	40020	2
68721	40020	3
68722	40020	4
68723	40021	1
68724	40021	2
68725	40021	3
68726	40021	4
68727	40022	1
68728	40022	2
68729	40022	3
68730	40022	4
68731	40023	3
68732	40024	1
68733	40025	3
68734	40026	1
68735	40026	2
68736	40026	3
68737	40026	4
68738	40027	1
68739	40027	4
68740	40028	1
68741	40029	1
68742	40030	1
68743	40031	1
68744	40031	4
68745	40032	1
68746	40032	4
68747	40033	1
68748	40033	4
68749	40034	1
68750	40034	4
68751	40035	1
68752	40035	2
68753	40035	3
68754	40035	4
68755	40036	1
68756	40036	2
68757	40036	3
68758	40036	4
68759	40037	1
68760	40038	1
68761	40038	2
68762	40038	3
68763	40038	4
68764	40039	1
68765	40039	2
68766	40039	3
68767	40039	4
68768	40040	3
68769	40041	1
68770	40042	3
68771	40043	1
68772	40043	4
68773	40044	1
68774	40045	1
68775	40046	1
68776	40047	1
68777	40048	1
68778	40049	1
68779	40050	1
68780	40051	1
68781	40051	2
68782	40051	3
68783	40051	4
68784	40052	1
68785	40052	4
\.


--
-- Name: rol_resource_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rol_resource_id_seq', 68785, true);


--
-- Data for Name: subtipo_publicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY subtipo_publicacion (id, nombre, precio, duracion, prioridad, id_tipo_publicacion) FROM stdin;
1	NORMAL	0	8	100	1
2	ECONOMICOS	0	8	100	1
3	SUPERECONOMICOS	0	8	100	1
4	INTERNET GRATIS	0	28	100	2
5	INTERNET 15S	15	14	2	2
6	INTERNET 25S	25	28	1	2
\.


--
-- Data for Name: tipo_archivo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_archivo (id, tipo) FROM stdin;
1	XLS
2	PDF
3	TXT
\.


--
-- Data for Name: tipo_clasificado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_clasificado (id, id_padre, dato, subtipo, nombre) FROM stdin;
109	2	SIN INFORMACIÓN	3	RANGO SALARIAL
116	1	SIN INFORMACIÓN	5	RANGO PRECIOS
123	1	HASTA 80M2	4	AREA
124	1	ENTRE 80M2 Y 150M2	4	AREA
125	1	ENTRE 150M2 Y 300M2	4	AREA
126	1	ENTRE 300M2 Y 600M2	4	AREA
127	1	MAS DE 600M2	4	AREA
128	3	HASTA US$ 5000	3	RANGO PRECIOS
129	3	ENTRE US$ 5000 Y US$ 9000	3	RANGO PRECIOS
130	3	ENTRE US$ 9000 Y US$ 14000	3	RANGO PRECIOS
131	3	ENTRE US$ 14000 Y US$ 20000	3	RANGO PRECIOS
132	3	MAS DE US$ 20000	3	RANGO PRECIOS
139	3	SIN INFORMACIÓN	3	RANGO PRECIOS
102	4	TECNOLOGÍA (CAMARAS, IPODS...)	1	TIPO
117	1	HASTA $US 40.000	5	RANGO PRECIOS
118	1	ENTRE $40.000 Y $80.000	5	RANGO PRECIOS
119	1	ENTRE $80.000 Y $120.000	5	RANGO PRECIOS
120	1	ENTRE $120.000 Y $160.000	5	RANGO PRECIOS
121	1	ENTRE $160.000 Y $200.000	5	RANGO PRECIOS
8	1	DEPARTAMENTO	2	TIPO DE INMUEBLE
122	1	MAS DE $200.000	5	RANGO PRECIOS
19	1	JOSE LUIS BUSTAMANTE	3	DISTRITO
110	2	Hasta S/. 1000	3	RANGO SALARIAL
111	2	Entre S/. 1000 y S/. 2000	3	RANGO SALARIAL
112	2	Entre S/. 2000 y S/. 3000	3	RANGO SALARIAL
113	2	Entre S/. 3000 y S/. 4000	3	RANGO SALARIAL
114	2	Entre S/. 4000 y S/. 5000	3	RANGO SALARIAL
115	2	Mas de S/. 5000	3	RANGO SALARIAL
1	\N	INMOBILIARIO	\N	\N
133	1	SIN INFORMACIÓN	5	RANGO PRECIOS ALQUILER
134	1	HASTA 500 ./s	5	RANGO PRECIOS ALQUILER
135	1	ENTRE 500 ./s y 800 ./s	5	RANGO PRECIOS ALQUILER
136	1	ENTRE 800 ./s y 1200 ./s	5	RANGO PRECIOS ALQUILER
137	1	ENTRE 1200 ./s y 1800 ./s	5	RANGO PRECIOS ALQUILER
138	1	MÁS DE 1800 ./s	5	RANGO PRECIOS ALQUILER
101	4	COMPUTADORES	1	TIPO
105	4	CURSOS Y ENSEÑANZAS	1	TIPO
2	\N	EMPLEOS	\N	\N
3	\N	VEHICULOS	\N	\N
4	\N	VARIOS	\N	\N
5	1	VENTA	1	TIPO DE OFERTA
6	1	ALQUILER	1	TIPO DE OFERTA
7	1	TERRENO	2	TIPO DE INMUEBLE
9	1	CASA	2	TIPO DE INMUEBLE
10	1	OFICINA	2	TIPO DE INMUEBLE
11	1	OTRO	2	TIPO DE INMUEBLE
12	1	ALTO SELVA ALEGRE	3	DISTRITO
13	1	AREQUIPA	3	DISTRITO
14	1	CAYMA	3	DISTRITO
15	1	CERRO COLORADO	3	DISTRITO
16	1	CHARACATO	3	DISTRITO
17	1	CHIGUATA	3	DISTRITO
18	1	JACOBO HUNTER	3	DISTRITO
20	1	LA JOYA	3	DISTRITO
21	1	MARIANO MELGAR	3	DISTRITO
22	1	MIRAFLORES	3	DISTRITO
23	1	MOLLEBAYA	3	DISTRITO
24	1	PAUCARPATA	3	DISTRITO
25	1	POCSI	3	DISTRITO
26	1	POLOBAYA	3	DISTRITO
27	1	QUEQUEÑA	3	DISTRITO
28	1	SABANDIA	3	DISTRITO
29	1	SACHACA	3	DISTRITO
30	1	SAN JUAN DE TARUCANI	3	DISTRITO
31	1	SANTA ISABEL DE SIGUAS	3	DISTRITO
32	1	SANTA RITA DE SIGUAS	3	DISTRITO
33	1	SAN JUAN DE SIGUAS	3	DISTRITO
34	1	SOCABAYA	3	DISTRITO
35	1	TIABAYA	3	DISTRITO
36	1	UCHUMAYO	3	DISTRITO
37	1	VITOR	3	DISTRITO
38	1	YANAHURA	3	DISTRITO
39	1	YARABAMBA	3	DISTRITO
40	1	YURA	3	DISTRITO
41	1	CAMANÁ	3	DISTRITO
42	1	CARAVELÍ	3	DISTRITO
43	1	CASTILLA	3	DISTRITO
44	1	CAYLLOMA	3	DISTRITO
45	1	CONDESUYOS	3	DISTRITO
46	1	ISLAY	3	DISTRITO
47	1	LA UNIÓN	3	DISTRITO
108	2	ASEO	2	AREA
50	2	ADMINISTRATIVA Y FINANCIERA	2	AREA
51	2	COMERCIAL Y VENTAS	2	AREA
52	2	CONSTRUCCIÓN	2	AREA
53	2	DOCENCIA	2	AREA
54	2	ENFERMERÍA	2	AREA
55	2	JURIDICA	2	AREA
56	2	LOGÍSTICA	2	AREA
57	2	MANTENIMIENTO	2	AREA
58	2	RECEPCIONISTA	2	AREA
59	2	SALUD OCUPACIONAL	2	AREA
60	2	SALUD	2	AREA
61	2	SERVICIO AL CLIENTE	2	AREA
62	2	SECRETARIADO	2	AREA
63	2	SISTEMAS Y TECNOLOGÍA	2	AREA
64	2	VIGILANCIA	2	AREA
65	2	OTRAS AREAS	2	AREA
66	3	AUTOMOVIL	1	TIPO DE VEHÍCULO
67	3	CAMIONETA	1	TIPO DE VEHÍCULO
68	3	BUSES	1	TIPO DE VEHÍCULO
69	3	CARGA	1	TIPO DE VEHÍCULO
70	3	MOTO	1	TIPO DE VEHÍCULO
71	3	AUDI	2	MARCA
72	3	BMW	2	MARCA
73	3	CHEVROLET	2	MARCA
74	3	CHERY	2	MARCA
75	3	DAEWOO	2	MARCA
76	3	FIAT	2	MARCA
77	3	FORD	2	MARCA
78	3	JEEP	2	MARCA
79	3	HAFEI	2	MARCA
80	3	HONDA	2	MARCA
81	3	HYUNDAY	2	MARCA
82	3	KIA	2	MARCA
83	3	KENWORTH	2	MARCA
84	3	MAZDA	2	MARCA
85	3	MINI	2	MARCA
86	3	MERCEDES	2	MARCA
87	3	MITSUBISHI	2	MARCA
88	3	NISSAN	2	MARCA
89	3	PEAGEOT	2	MARCA
90	3	RENAULT	2	MARCA
91	3	SSANGYONG	2	MARCA
92	3	SUBARU	2	MARCA
93	3	SUZUKY	2	MARCA
94	3	SKODA	2	MARCA
95	3	TOYOTA	2	MARCA
96	3	VOLSWAGEN	2	MARCA
97	3	RENAULT	2	MARCA
98	3	OTRAS MARCAS	2	MARCA
103	4	PRESTAMOS E HIPOTECAS	1	TIPO
104	4	SERVICIOS	1	TIPO
107	4	OTROS	1	TIPO
48	2	OFERTA	1	TIPO DE OFERTA
49	2	SOLICITUD	1	TIPO DE OFERTA
100	4	VENTA Y ALQUILER NEGOCIOS	1	TIPO
99	4	 VENTA Y ALQUILER MAQUINARIA	1	TIPO
\.


--
-- Name: tipo_clasificado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_clasificado_id_seq', 133, true);


--
-- Data for Name: tipo_fuente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_fuente (id, nombre) FROM stdin;
1	IMG
2	FLASH
\.


--
-- Data for Name: tipo_id; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_id (id, codigo) FROM stdin;
1	CC
2	NIT
3	CE
\.


--
-- Name: tipo_impresion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_impresion_id_seq', 1, false);


--
-- Data for Name: tipo_parametro_reporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_parametro_reporte (tipo, id, descripcion) FROM stdin;
NUMERIC	1	Representa valores numéricos: int, long, double, float
TEXT	2	Representa cadenas de texto
DATE	3	Representa Fechas
TIME	4	Representa Horas
DATA	5	Representa tablas multivaluadas, como municipios, tipos de id, etc; DEBE EXISTIR UNA TABLA que las represente
\.


--
-- Name: tipo_precio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tipo_precio_id_seq', 1, false);


--
-- Data for Name: tipo_proceso_reporte; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_proceso_reporte (id, nombre) FROM stdin;
1	REPORTES
2	ARCHIVOS
\.


--
-- Data for Name: tipo_publicacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_publicacion (id, nombre) FROM stdin;
1	IMPRESOS
2	PUBLICACIÓN
\.


--
-- Data for Name: user_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY user_group (id, id_user, id_group) FROM stdin;
1	1	1
2	16	2
4	18	2
5	19	3
7	21	2
\.


--
-- Name: user_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('user_group_id_seq', 7, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, usr, pwd, nombre, mail, estado, cod_restauracion, clave, nro_usuario, num_id) FROM stdin;
1	admin	d033e22ae348aeb5660fc2140aec35850c4da997	JERSON VIVEROS AGUIRRE	jerviver21@gmail.com	1	\N	\N	\N	\N
16	guest	35675e68f4b5af7b995d9205ad0fc43842f16450			1	\N	\N	\N	\N
19	asesor1	ac0e9adf4fcdcb2359a220c20c4dd64b15a11781			1	\N		\N	\N
18	jerviver21@gmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@gmail.com	1	\N	qJALVpSVjqgn/Vw1I9l2fw==	131400000018	\N
21	jerviver21@hotmail.com	8095ee69d09e2787c443560959455804afc24d72	JERSON VIVEROS	jerviver21@hotmail.com	1	\N	gHveiA64t/rnzyZkhK7/vQ==	131400000021	000950621
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 21, true);


--
-- Data for Name: validaciones_formulario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY validaciones_formulario (id, id_campo_formulario) FROM stdin;
\.


--
-- Name: validaciones_formulario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('validaciones_formulario_id_seq', 1, false);


--
-- Name: archivo_fk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY archivo
    ADD CONSTRAINT archivo_fk PRIMARY KEY (nombre);


--
-- Name: aud_clasificado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY aud_clasificado
    ADD CONSTRAINT aud_clasificado_pk PRIMARY KEY (id);


--
-- Name: aud_mail_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY aud_mail
    ADD CONSTRAINT aud_mail_pk PRIMARY KEY (id);


--
-- Name: aud_pedido_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY aud_pedido
    ADD CONSTRAINT aud_pedido_pk PRIMARY KEY (id);


--
-- Name: aud_sesion_pk; Type: CONSTRAINT; Schema: public; Owner: jbossuser; Tablespace: 
--

ALTER TABLE ONLY aud_sesion
    ADD CONSTRAINT aud_sesion_pk PRIMARY KEY (id);


--
-- Name: aud_users_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY aud_users
    ADD CONSTRAINT aud_users_pk PRIMARY KEY (id);


--
-- Name: campos_formulario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY campos_formulario
    ADD CONSTRAINT campos_formulario_pk PRIMARY KEY (id);


--
-- Name: campos_tipo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY campos_tipo
    ADD CONSTRAINT campos_tipo_pk PRIMARY KEY (id);


--
-- Name: campos_tipo_pk_clone; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY aud_campos_tipo
    ADD CONSTRAINT campos_tipo_pk_clone PRIMARY KEY (id);


--
-- Name: campos_validaciones_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY campos_validacion
    ADD CONSTRAINT campos_validaciones_pk PRIMARY KEY (id);


--
-- Name: clasificado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT clasificado_pk PRIMARY KEY (id);


--
-- Name: currencies_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY currencies
    ADD CONSTRAINT currencies_pk PRIMARY KEY (id);


--
-- Name: data_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY data
    ADD CONSTRAINT data_pk PRIMARY KEY (id);


--
-- Name: entidades_pago_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY entidades_pago
    ADD CONSTRAINT entidades_pago_pk PRIMARY KEY (id);


--
-- Name: estados_clasificado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estados_clasificado
    ADD CONSTRAINT estados_clasificado_pk PRIMARY KEY (id);


--
-- Name: estados_pedido_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY estados_pedido
    ADD CONSTRAINT estados_pedido_pk PRIMARY KEY (id);


--
-- Name: festivos_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY festivos
    ADD CONSTRAINT festivos_pk PRIMARY KEY (fecha);


--
-- Name: formularios_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY formulario
    ADD CONSTRAINT formularios_pk PRIMARY KEY (id);


--
-- Name: group_rol_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY group_rol
    ADD CONSTRAINT group_rol_pk PRIMARY KEY (id);


--
-- Name: idiomas_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY idiomas
    ADD CONSTRAINT idiomas_pk PRIMARY KEY (id);


--
-- Name: imagenes_publicidad_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY imagenes_publicidad
    ADD CONSTRAINT imagenes_publicidad_pk PRIMARY KEY (id);


--
-- Name: img_clasificado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY img_clasificado
    ADD CONSTRAINT img_clasificado_pk PRIMARY KEY (id);


--
-- Name: menu_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_pk PRIMARY KEY (id);


--
-- Name: parametro_reporte_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parametros_reporte
    ADD CONSTRAINT parametro_reporte_pk PRIMARY KEY (id);


--
-- Name: parametros_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY parametro
    ADD CONSTRAINT parametros_pk PRIMARY KEY (id);


--
-- Name: pedido_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT pedido_pk PRIMARY KEY (id);


--
-- Name: perfil_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT perfil_pk PRIMARY KEY (id);


--
-- Name: perfil_recurso_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY rol_resource
    ADD CONSTRAINT perfil_recurso_pk PRIMARY KEY (id);


--
-- Name: precios_clasificados_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dias_precios
    ADD CONSTRAINT precios_clasificados_pk PRIMARY KEY (id);


--
-- Name: procesos_reportes_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_proceso_reporte
    ADD CONSTRAINT procesos_reportes_pk PRIMARY KEY (id);


--
-- Name: publicidad_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY publicidad
    ADD CONSTRAINT publicidad_pk PRIMARY KEY (id);


--
-- Name: recurso_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT recurso_pk PRIMARY KEY (id);


--
-- Name: reporte_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reporte
    ADD CONSTRAINT reporte_pk PRIMARY KEY (id);


--
-- Name: rol_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT rol_pk PRIMARY KEY (id);


--
-- Name: tipo_archivo_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_archivo
    ADD CONSTRAINT tipo_archivo_pk PRIMARY KEY (id);


--
-- Name: tipo_clasificado_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_clasificado
    ADD CONSTRAINT tipo_clasificado_pk PRIMARY KEY (id);


--
-- Name: tipo_fuente_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_fuente
    ADD CONSTRAINT tipo_fuente_pk PRIMARY KEY (id);


--
-- Name: tipo_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_id
    ADD CONSTRAINT tipo_id_pk PRIMARY KEY (id);


--
-- Name: tipo_impresion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY subtipo_publicacion
    ADD CONSTRAINT tipo_impresion_pk PRIMARY KEY (id);


--
-- Name: tipo_parametro_reporte_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_parametro_reporte
    ADD CONSTRAINT tipo_parametro_reporte_pk PRIMARY KEY (id);


--
-- Name: tipo_precio_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY precios
    ADD CONSTRAINT tipo_precio_pk PRIMARY KEY (id);


--
-- Name: tipo_publicacion_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_publicacion
    ADD CONSTRAINT tipo_publicacion_pk PRIMARY KEY (id);


--
-- Name: user_group_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_pk PRIMARY KEY (id);


--
-- Name: usuario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT usuario_pk PRIMARY KEY (id);


--
-- Name: validaciones_formulario_pk; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY validaciones_formulario
    ADD CONSTRAINT validaciones_formulario_pk PRIMARY KEY (id);


--
-- Name: campos_validaciones_ui1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX campos_validaciones_ui1 ON campos_validacion USING btree (id_campo, id_validacion);


--
-- Name: menu_ui1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX menu_ui1 ON menu USING btree (nombre);


--
-- Name: parametros_ui1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX parametros_ui1 ON parametro USING btree (nombre, tipo);


--
-- Name: perfil_ui1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX perfil_ui1 ON rol USING btree (codigo);


--
-- Name: publicidad_ui1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX publicidad_ui1 ON publicidad USING btree (fecha_ini, seccion_page);


--
-- Name: recurso_ui1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX recurso_ui1 ON resource USING btree (nombre, id_menu);


--
-- Name: rol_ui1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX rol_ui1 ON groups USING btree (codigo);


--
-- Name: usuario_ui1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX usuario_ui1 ON users USING btree (usr);


--
-- Name: trg_aud_clasificado; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_clasificado AFTER INSERT OR DELETE OR UPDATE ON clasificado FOR EACH ROW EXECUTE PROCEDURE aud_clasificado_func();


--
-- Name: trg_aud_pedido; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_pedido AFTER INSERT OR DELETE OR UPDATE ON pedido FOR EACH ROW EXECUTE PROCEDURE aud_pedido_func();


--
-- Name: trg_aud_users; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trg_aud_users AFTER INSERT OR DELETE OR UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE aud_users_func();


--
-- Name: arch_tipo_arch_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY archivo
    ADD CONSTRAINT arch_tipo_arch_fk FOREIGN KEY (id_tipo_archivo) REFERENCES tipo_archivo(id);


--
-- Name: archivo_reporte_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY archivo
    ADD CONSTRAINT archivo_reporte_fk FOREIGN KEY (id_reporte) REFERENCES reporte(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: campos_subtipo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY campos_tipo
    ADD CONSTRAINT campos_subtipo_fk FOREIGN KEY (id_tipoclasificado) REFERENCES tipo_clasificado(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: clasificado_tipoimp_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT clasificado_tipoimp_fk FOREIGN KEY (id_subtipo_publicacion) REFERENCES subtipo_publicacion(id);


--
-- Name: currency_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT currency_fk FOREIGN KEY (id_currency_oferta) REFERENCES currencies(id);


--
-- Name: data_param_rep_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parametros_reporte
    ADD CONSTRAINT data_param_rep_fk FOREIGN KEY (id_data) REFERENCES data(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: entidad_pago_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT entidad_pago_fk FOREIGN KEY (id_entidad_pago) REFERENCES entidades_pago(id);


--
-- Name: estado_clasificado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT estado_clasificado_fk FOREIGN KEY (id_estado) REFERENCES estados_clasificado(id);


--
-- Name: group_group_rol_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_rol
    ADD CONSTRAINT group_group_rol_fk FOREIGN KEY (id_group) REFERENCES groups(id);


--
-- Name: group_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT group_user_fk FOREIGN KEY (id_group) REFERENCES groups(id);


--
-- Name: imagen_publicidad_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY publicidad
    ADD CONSTRAINT imagen_publicidad_fk FOREIGN KEY (id_imagen) REFERENCES imagenes_publicidad(id);


--
-- Name: img_clasificado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY img_clasificado
    ADD CONSTRAINT img_clasificado_fk FOREIGN KEY (id_clasificado) REFERENCES clasificado(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: menu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT menu_fk FOREIGN KEY (id_menu) REFERENCES menu(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: param_rep_reporte_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parametros_reporte
    ADD CONSTRAINT param_rep_reporte_fk FOREIGN KEY (id_reporte) REFERENCES reporte(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: param_tipo_param_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY parametros_reporte
    ADD CONSTRAINT param_tipo_param_fk FOREIGN KEY (id_tipo) REFERENCES tipo_parametro_reporte(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pedido_clasificado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT pedido_clasificado_fk FOREIGN KEY (id_pedido) REFERENCES pedido(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pedido_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pedido
    ADD CONSTRAINT pedido_estado_fk FOREIGN KEY (id_estado) REFERENCES estados_pedido(id);


--
-- Name: precio_tipo_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dias_precios
    ADD CONSTRAINT precio_tipo_fk FOREIGN KEY (id_precio) REFERENCES precios(id);


--
-- Name: precios_tipos_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dias_precios
    ADD CONSTRAINT precios_tipos_fk FOREIGN KEY (id_subtipo_publicacion) REFERENCES subtipo_publicacion(id);


--
-- Name: recurso_menu_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY resource
    ADD CONSTRAINT recurso_menu_fk FOREIGN KEY (id_menu) REFERENCES menu(id);


--
-- Name: reporte_proceso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reporte
    ADD CONSTRAINT reporte_proceso_fk FOREIGN KEY (id_proceso) REFERENCES tipo_proceso_reporte(id);


--
-- Name: resource_rol_res_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rol_resource
    ADD CONSTRAINT resource_rol_res_fk FOREIGN KEY (id_resource) REFERENCES resource(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: rol_group_rol_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY group_rol
    ADD CONSTRAINT rol_group_rol_fk FOREIGN KEY (id_rol) REFERENCES rol(id);


--
-- Name: rol_rol_res_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rol_resource
    ADD CONSTRAINT rol_rol_res_fk FOREIGN KEY (id_rol) REFERENCES rol(id);


--
-- Name: subtipo1_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT subtipo1_fk FOREIGN KEY (id_subtipo1) REFERENCES tipo_clasificado(id);


--
-- Name: subtipo2_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT subtipo2_fk FOREIGN KEY (id_subtipo2) REFERENCES tipo_clasificado(id);


--
-- Name: subtipo3_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT subtipo3_fk FOREIGN KEY (id_subtipo3) REFERENCES tipo_clasificado(id);


--
-- Name: subtipo4_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT subtipo4_fk FOREIGN KEY (id_subtipo4) REFERENCES tipo_clasificado(id);


--
-- Name: subtipo5_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT subtipo5_fk FOREIGN KEY (id_subtipo5) REFERENCES tipo_clasificado(id);


--
-- Name: subtipo6_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT subtipo6_fk FOREIGN KEY (id_subtipo6) REFERENCES tipo_clasificado(id);


--
-- Name: tipo_fuente_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY imagenes_publicidad
    ADD CONSTRAINT tipo_fuente_fk FOREIGN KEY (id_tipo_fuente) REFERENCES tipo_fuente(id);


--
-- Name: tipo_padre_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tipo_clasificado
    ADD CONSTRAINT tipo_padre_fk FOREIGN KEY (id_padre) REFERENCES tipo_clasificado(id);


--
-- Name: tipo_principal_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clasificado
    ADD CONSTRAINT tipo_principal_fk FOREIGN KEY (id_tipo) REFERENCES tipo_clasificado(id);


--
-- Name: tipo_sub_fk1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY subtipo_publicacion
    ADD CONSTRAINT tipo_sub_fk1 FOREIGN KEY (id_tipo_publicacion) REFERENCES tipo_publicacion(id);


--
-- Name: user_group_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_group
    ADD CONSTRAINT user_group_fk FOREIGN KEY (id_user) REFERENCES users(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: aud_clasificado_func(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION aud_clasificado_func() FROM PUBLIC;
REVOKE ALL ON FUNCTION aud_clasificado_func() FROM postgres;
GRANT ALL ON FUNCTION aud_clasificado_func() TO postgres;
GRANT ALL ON FUNCTION aud_clasificado_func() TO PUBLIC;
GRANT ALL ON FUNCTION aud_clasificado_func() TO jboss;


--
-- Name: aud_pedido_func(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION aud_pedido_func() FROM PUBLIC;
REVOKE ALL ON FUNCTION aud_pedido_func() FROM postgres;
GRANT ALL ON FUNCTION aud_pedido_func() TO postgres;
GRANT ALL ON FUNCTION aud_pedido_func() TO PUBLIC;
GRANT ALL ON FUNCTION aud_pedido_func() TO jboss;


--
-- Name: aud_users_func(); Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON FUNCTION aud_users_func() FROM PUBLIC;
REVOKE ALL ON FUNCTION aud_users_func() FROM postgres;
GRANT ALL ON FUNCTION aud_users_func() TO postgres;
GRANT ALL ON FUNCTION aud_users_func() TO PUBLIC;
GRANT ALL ON FUNCTION aud_users_func() TO jbossuser;
GRANT ALL ON FUNCTION aud_users_func() TO jboss;


--
-- Name: archivo; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE archivo FROM PUBLIC;
REVOKE ALL ON TABLE archivo FROM postgres;
GRANT ALL ON TABLE archivo TO postgres;
GRANT ALL ON TABLE archivo TO jbossuser;
GRANT ALL ON TABLE archivo TO jboss;


--
-- Name: aud_campos_tipo; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE aud_campos_tipo FROM PUBLIC;
REVOKE ALL ON TABLE aud_campos_tipo FROM postgres;
GRANT ALL ON TABLE aud_campos_tipo TO postgres;
GRANT ALL ON TABLE aud_campos_tipo TO jboss;


--
-- Name: aud_campos_tipo_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE aud_campos_tipo_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE aud_campos_tipo_id_seq FROM postgres;
GRANT ALL ON SEQUENCE aud_campos_tipo_id_seq TO postgres;
GRANT ALL ON SEQUENCE aud_campos_tipo_id_seq TO jboss;


--
-- Name: aud_mail; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE aud_mail FROM PUBLIC;
REVOKE ALL ON TABLE aud_mail FROM postgres;
GRANT ALL ON TABLE aud_mail TO postgres;
GRANT ALL ON TABLE aud_mail TO jboss;


--
-- Name: aud_mail_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE aud_mail_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE aud_mail_id_seq FROM postgres;
GRANT ALL ON SEQUENCE aud_mail_id_seq TO postgres;
GRANT ALL ON SEQUENCE aud_mail_id_seq TO jboss;


--
-- Name: aud_sesion; Type: ACL; Schema: public; Owner: jbossuser
--

REVOKE ALL ON TABLE aud_sesion FROM PUBLIC;
REVOKE ALL ON TABLE aud_sesion FROM jbossuser;
GRANT ALL ON TABLE aud_sesion TO jbossuser;
GRANT ALL ON TABLE aud_sesion TO jboss;


--
-- Name: aud_sesion_id_seq; Type: ACL; Schema: public; Owner: jbossuser
--

REVOKE ALL ON SEQUENCE aud_sesion_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE aud_sesion_id_seq FROM jbossuser;
GRANT ALL ON SEQUENCE aud_sesion_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE aud_sesion_id_seq TO jboss;


--
-- Name: aud_users; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE aud_users FROM PUBLIC;
REVOKE ALL ON TABLE aud_users FROM postgres;
GRANT ALL ON TABLE aud_users TO postgres;
GRANT ALL ON TABLE aud_users TO jbossuser;
GRANT ALL ON TABLE aud_users TO jboss;


--
-- Name: aud_users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE aud_users_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE aud_users_id_seq FROM postgres;
GRANT ALL ON SEQUENCE aud_users_id_seq TO postgres;
GRANT ALL ON SEQUENCE aud_users_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE aud_users_id_seq TO jboss;


--
-- Name: campos_formulario; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE campos_formulario FROM PUBLIC;
REVOKE ALL ON TABLE campos_formulario FROM postgres;
GRANT ALL ON TABLE campos_formulario TO postgres;
GRANT ALL ON TABLE campos_formulario TO jbossuser;
GRANT ALL ON TABLE campos_formulario TO jboss;


--
-- Name: campos_formulario_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE campos_formulario_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE campos_formulario_id_seq FROM postgres;
GRANT ALL ON SEQUENCE campos_formulario_id_seq TO postgres;
GRANT ALL ON SEQUENCE campos_formulario_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE campos_formulario_id_seq TO jboss;


--
-- Name: campos_tipo; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE campos_tipo FROM PUBLIC;
REVOKE ALL ON TABLE campos_tipo FROM postgres;
GRANT ALL ON TABLE campos_tipo TO postgres;
GRANT ALL ON TABLE campos_tipo TO jboss;


--
-- Name: campos_tipo_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE campos_tipo_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE campos_tipo_id_seq FROM postgres;
GRANT ALL ON SEQUENCE campos_tipo_id_seq TO postgres;
GRANT ALL ON SEQUENCE campos_tipo_id_seq TO jboss;


--
-- Name: campos_validacion; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE campos_validacion FROM PUBLIC;
REVOKE ALL ON TABLE campos_validacion FROM postgres;
GRANT ALL ON TABLE campos_validacion TO postgres;
GRANT ALL ON TABLE campos_validacion TO jbossuser;
GRANT ALL ON TABLE campos_validacion TO jboss;


--
-- Name: campos_validacion_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE campos_validacion_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE campos_validacion_id_seq FROM postgres;
GRANT ALL ON SEQUENCE campos_validacion_id_seq TO postgres;
GRANT ALL ON SEQUENCE campos_validacion_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE campos_validacion_id_seq TO jboss;


--
-- Name: clasificado; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE clasificado FROM PUBLIC;
REVOKE ALL ON TABLE clasificado FROM postgres;
GRANT ALL ON TABLE clasificado TO postgres;
GRANT ALL ON TABLE clasificado TO jboss;


--
-- Name: clasificado_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE clasificado_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE clasificado_id_seq FROM postgres;
GRANT ALL ON SEQUENCE clasificado_id_seq TO postgres;
GRANT ALL ON SEQUENCE clasificado_id_seq TO jboss;


--
-- Name: currencies; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE currencies FROM PUBLIC;
REVOKE ALL ON TABLE currencies FROM postgres;
GRANT ALL ON TABLE currencies TO postgres;
GRANT ALL ON TABLE currencies TO jboss;


--
-- Name: data; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE data FROM PUBLIC;
REVOKE ALL ON TABLE data FROM postgres;
GRANT ALL ON TABLE data TO postgres;
GRANT ALL ON TABLE data TO jbossuser;
GRANT ALL ON TABLE data TO jboss;


--
-- Name: dias_precios; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE dias_precios FROM PUBLIC;
REVOKE ALL ON TABLE dias_precios FROM postgres;
GRANT ALL ON TABLE dias_precios TO postgres;
GRANT ALL ON TABLE dias_precios TO jboss;


--
-- Name: entidades_pago; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE entidades_pago FROM PUBLIC;
REVOKE ALL ON TABLE entidades_pago FROM postgres;
GRANT ALL ON TABLE entidades_pago TO postgres;
GRANT ALL ON TABLE entidades_pago TO jboss;


--
-- Name: estados_clasificado; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE estados_clasificado FROM PUBLIC;
REVOKE ALL ON TABLE estados_clasificado FROM postgres;
GRANT ALL ON TABLE estados_clasificado TO postgres;
GRANT ALL ON TABLE estados_clasificado TO jboss;


--
-- Name: estados_pedido; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE estados_pedido FROM PUBLIC;
REVOKE ALL ON TABLE estados_pedido FROM postgres;
GRANT ALL ON TABLE estados_pedido TO postgres;
GRANT ALL ON TABLE estados_pedido TO jboss;


--
-- Name: festivos; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE festivos FROM PUBLIC;
REVOKE ALL ON TABLE festivos FROM postgres;
GRANT ALL ON TABLE festivos TO postgres;
GRANT ALL ON TABLE festivos TO jboss;


--
-- Name: formulario; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE formulario FROM PUBLIC;
REVOKE ALL ON TABLE formulario FROM postgres;
GRANT ALL ON TABLE formulario TO postgres;
GRANT ALL ON TABLE formulario TO jbossuser;
GRANT ALL ON TABLE formulario TO jboss;


--
-- Name: formulario_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE formulario_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE formulario_id_seq FROM postgres;
GRANT ALL ON SEQUENCE formulario_id_seq TO postgres;
GRANT ALL ON SEQUENCE formulario_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE formulario_id_seq TO jboss;


--
-- Name: group_rol; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE group_rol FROM PUBLIC;
REVOKE ALL ON TABLE group_rol FROM postgres;
GRANT ALL ON TABLE group_rol TO postgres;
GRANT ALL ON TABLE group_rol TO jbossuser;
GRANT ALL ON TABLE group_rol TO jboss;


--
-- Name: group_rol_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE group_rol_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE group_rol_id_seq FROM postgres;
GRANT ALL ON SEQUENCE group_rol_id_seq TO postgres;
GRANT ALL ON SEQUENCE group_rol_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE group_rol_id_seq TO jboss;


--
-- Name: groups; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE groups FROM PUBLIC;
REVOKE ALL ON TABLE groups FROM postgres;
GRANT ALL ON TABLE groups TO postgres;
GRANT ALL ON TABLE groups TO jbossuser;
GRANT ALL ON TABLE groups TO jboss;


--
-- Name: groups_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE groups_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE groups_id_seq FROM postgres;
GRANT ALL ON SEQUENCE groups_id_seq TO postgres;
GRANT ALL ON SEQUENCE groups_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE groups_id_seq TO jboss;


--
-- Name: idiomas; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE idiomas FROM PUBLIC;
REVOKE ALL ON TABLE idiomas FROM postgres;
GRANT ALL ON TABLE idiomas TO postgres;
GRANT ALL ON TABLE idiomas TO jbossuser;
GRANT ALL ON TABLE idiomas TO jboss;


--
-- Name: menu; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE menu FROM PUBLIC;
REVOKE ALL ON TABLE menu FROM postgres;
GRANT ALL ON TABLE menu TO postgres;
GRANT ALL ON TABLE menu TO jbossuser;
GRANT ALL ON TABLE menu TO jboss;


--
-- Name: menu_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE menu_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE menu_id_seq FROM postgres;
GRANT ALL ON SEQUENCE menu_id_seq TO postgres;
GRANT ALL ON SEQUENCE menu_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE menu_id_seq TO jboss;


--
-- Name: parametro; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE parametro FROM PUBLIC;
REVOKE ALL ON TABLE parametro FROM postgres;
GRANT ALL ON TABLE parametro TO postgres;
GRANT ALL ON TABLE parametro TO jbossuser;
GRANT ALL ON TABLE parametro TO jboss;


--
-- Name: parametro_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE parametro_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE parametro_id_seq FROM postgres;
GRANT ALL ON SEQUENCE parametro_id_seq TO postgres;
GRANT ALL ON SEQUENCE parametro_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE parametro_id_seq TO jboss;


--
-- Name: parametros_reporte; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE parametros_reporte FROM PUBLIC;
REVOKE ALL ON TABLE parametros_reporte FROM postgres;
GRANT ALL ON TABLE parametros_reporte TO postgres;
GRANT ALL ON TABLE parametros_reporte TO jbossuser;
GRANT ALL ON TABLE parametros_reporte TO jboss;


--
-- Name: pedido; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE pedido FROM PUBLIC;
REVOKE ALL ON TABLE pedido FROM postgres;
GRANT ALL ON TABLE pedido TO postgres;
GRANT ALL ON TABLE pedido TO jboss;


--
-- Name: pedido_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE pedido_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE pedido_id_seq FROM postgres;
GRANT ALL ON SEQUENCE pedido_id_seq TO postgres;
GRANT ALL ON SEQUENCE pedido_id_seq TO jboss;


--
-- Name: precios; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE precios FROM PUBLIC;
REVOKE ALL ON TABLE precios FROM postgres;
GRANT ALL ON TABLE precios TO postgres;
GRANT ALL ON TABLE precios TO jboss;


--
-- Name: precios_clasificados_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE precios_clasificados_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE precios_clasificados_id_seq FROM postgres;
GRANT ALL ON SEQUENCE precios_clasificados_id_seq TO postgres;
GRANT ALL ON SEQUENCE precios_clasificados_id_seq TO jboss;


--
-- Name: reporte; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE reporte FROM PUBLIC;
REVOKE ALL ON TABLE reporte FROM postgres;
GRANT ALL ON TABLE reporte TO postgres;
GRANT ALL ON TABLE reporte TO jbossuser;
GRANT ALL ON TABLE reporte TO jboss;


--
-- Name: resource; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE resource FROM PUBLIC;
REVOKE ALL ON TABLE resource FROM postgres;
GRANT ALL ON TABLE resource TO postgres;
GRANT ALL ON TABLE resource TO jbossuser;
GRANT ALL ON TABLE resource TO jboss;


--
-- Name: resource_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE resource_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE resource_id_seq FROM postgres;
GRANT ALL ON SEQUENCE resource_id_seq TO postgres;
GRANT ALL ON SEQUENCE resource_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE resource_id_seq TO jboss;


--
-- Name: rol; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE rol FROM PUBLIC;
REVOKE ALL ON TABLE rol FROM postgres;
GRANT ALL ON TABLE rol TO postgres;
GRANT ALL ON TABLE rol TO jbossuser;
GRANT ALL ON TABLE rol TO jboss;


--
-- Name: rol_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE rol_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE rol_id_seq FROM postgres;
GRANT ALL ON SEQUENCE rol_id_seq TO postgres;
GRANT ALL ON SEQUENCE rol_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE rol_id_seq TO jboss;


--
-- Name: rol_resource; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE rol_resource FROM PUBLIC;
REVOKE ALL ON TABLE rol_resource FROM postgres;
GRANT ALL ON TABLE rol_resource TO postgres;
GRANT ALL ON TABLE rol_resource TO jbossuser;
GRANT ALL ON TABLE rol_resource TO jboss;


--
-- Name: rol_resource_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE rol_resource_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE rol_resource_id_seq FROM postgres;
GRANT ALL ON SEQUENCE rol_resource_id_seq TO postgres;
GRANT ALL ON SEQUENCE rol_resource_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE rol_resource_id_seq TO jboss;


--
-- Name: subtipo_publicacion; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE subtipo_publicacion FROM PUBLIC;
REVOKE ALL ON TABLE subtipo_publicacion FROM postgres;
GRANT ALL ON TABLE subtipo_publicacion TO postgres;
GRANT ALL ON TABLE subtipo_publicacion TO jboss;


--
-- Name: tipo_archivo; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tipo_archivo FROM PUBLIC;
REVOKE ALL ON TABLE tipo_archivo FROM postgres;
GRANT ALL ON TABLE tipo_archivo TO postgres;
GRANT ALL ON TABLE tipo_archivo TO jbossuser;
GRANT ALL ON TABLE tipo_archivo TO jboss;


--
-- Name: tipo_clasificado; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tipo_clasificado FROM PUBLIC;
REVOKE ALL ON TABLE tipo_clasificado FROM postgres;
GRANT ALL ON TABLE tipo_clasificado TO postgres;
GRANT ALL ON TABLE tipo_clasificado TO jboss;


--
-- Name: tipo_clasificado_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE tipo_clasificado_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tipo_clasificado_id_seq FROM postgres;
GRANT ALL ON SEQUENCE tipo_clasificado_id_seq TO postgres;
GRANT ALL ON SEQUENCE tipo_clasificado_id_seq TO jboss;


--
-- Name: tipo_id; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tipo_id FROM PUBLIC;
REVOKE ALL ON TABLE tipo_id FROM postgres;
GRANT ALL ON TABLE tipo_id TO postgres;
GRANT ALL ON TABLE tipo_id TO jbossuser;
GRANT ALL ON TABLE tipo_id TO jboss;


--
-- Name: tipo_impresion_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE tipo_impresion_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tipo_impresion_id_seq FROM postgres;
GRANT ALL ON SEQUENCE tipo_impresion_id_seq TO postgres;
GRANT ALL ON SEQUENCE tipo_impresion_id_seq TO jboss;


--
-- Name: tipo_parametro_reporte; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tipo_parametro_reporte FROM PUBLIC;
REVOKE ALL ON TABLE tipo_parametro_reporte FROM postgres;
GRANT ALL ON TABLE tipo_parametro_reporte TO postgres;
GRANT ALL ON TABLE tipo_parametro_reporte TO jbossuser;
GRANT ALL ON TABLE tipo_parametro_reporte TO jboss;


--
-- Name: tipo_precio_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE tipo_precio_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tipo_precio_id_seq FROM postgres;
GRANT ALL ON SEQUENCE tipo_precio_id_seq TO postgres;
GRANT ALL ON SEQUENCE tipo_precio_id_seq TO jboss;


--
-- Name: tipo_proceso_reporte; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE tipo_proceso_reporte FROM PUBLIC;
REVOKE ALL ON TABLE tipo_proceso_reporte FROM postgres;
GRANT ALL ON TABLE tipo_proceso_reporte TO postgres;
GRANT ALL ON TABLE tipo_proceso_reporte TO jbossuser;
GRANT ALL ON TABLE tipo_proceso_reporte TO jboss;


--
-- Name: user_group; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE user_group FROM PUBLIC;
REVOKE ALL ON TABLE user_group FROM postgres;
GRANT ALL ON TABLE user_group TO postgres;
GRANT ALL ON TABLE user_group TO jbossuser;
GRANT ALL ON TABLE user_group TO jboss;


--
-- Name: user_group_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE user_group_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE user_group_id_seq FROM postgres;
GRANT ALL ON SEQUENCE user_group_id_seq TO postgres;
GRANT ALL ON SEQUENCE user_group_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE user_group_id_seq TO jboss;


--
-- Name: users; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE users FROM PUBLIC;
REVOKE ALL ON TABLE users FROM postgres;
GRANT ALL ON TABLE users TO postgres;
GRANT ALL ON TABLE users TO jbossuser;
GRANT ALL ON TABLE users TO jboss;


--
-- Name: users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE users_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE users_id_seq FROM postgres;
GRANT ALL ON SEQUENCE users_id_seq TO postgres;
GRANT ALL ON SEQUENCE users_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE users_id_seq TO jboss;


--
-- Name: validaciones_formulario; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON TABLE validaciones_formulario FROM PUBLIC;
REVOKE ALL ON TABLE validaciones_formulario FROM postgres;
GRANT ALL ON TABLE validaciones_formulario TO postgres;
GRANT ALL ON TABLE validaciones_formulario TO jbossuser;
GRANT ALL ON TABLE validaciones_formulario TO jboss;


--
-- Name: validaciones_formulario_id_seq; Type: ACL; Schema: public; Owner: postgres
--

REVOKE ALL ON SEQUENCE validaciones_formulario_id_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE validaciones_formulario_id_seq FROM postgres;
GRANT ALL ON SEQUENCE validaciones_formulario_id_seq TO postgres;
GRANT ALL ON SEQUENCE validaciones_formulario_id_seq TO jbossuser;
GRANT ALL ON SEQUENCE validaciones_formulario_id_seq TO jboss;


--
-- PostgreSQL database dump complete
--

