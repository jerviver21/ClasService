CREATE TABLE publicidad (
	id bigserial NOT NULL,
	ubicacion int4 NOT NULL,
	fecha_publicacion date NOT NULL
);
ALTER TABLE publicidad ADD CONSTRAINT publicidad_pk PRIMARY KEY(id);
CREATE TABLE imagenes_publicidad (
	id bigserial NOT NULL,
	ruta_imagen varchar(1000) NOT NULL,
	nombre_cliente varchar(1000) NOT NULL,
	nid varchar(50) NOT NULL,
	telefono varchar(50)
);
ALTER TABLE imagenes_publicidad ADD CONSTRAINT imagenes_publicidad_pk PRIMARY KEY(id);
CREATE UNIQUE INDEX publicidad_ui1 ON publicidad (ubicacion,fecha_publicacion);
ALTER TABLE publicidad ADD id_imagen bigint NOT NULL;
ALTER TABLE publicidad ADD CONSTRAINT imagen_publicidad_fk FOREIGN KEY (id_imagen) REFERENCES imagenes_publicidad(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
DROP INDEX publicidad_ui1;
CREATE UNIQUE INDEX publicidad_ui1 ON publicidad (fecha_publicacion);
ALTER TABLE publicidad DROP COLUMN ubicacion;
DROP INDEX publicidad_ui1;
ALTER TABLE publicidad ADD ubicacion varchar(10);
CREATE UNIQUE INDEX publicidad_ui1 ON publicidad (fecha_publicacion,ubicacion);
CREATE TABLE tipo_fuente (
	id int4 NOT NULL,
	nombre varchar(25) NOT NULL
);
ALTER TABLE tipo_fuente ADD CONSTRAINT tipo_fuente_pk PRIMARY KEY(id);
ALTER TABLE imagenes_publicidad ADD url_aterrizaje varchar(1000);
ALTER TABLE imagenes_publicidad ADD id_tipo_fuente int4;
ALTER TABLE imagenes_publicidad RENAME COLUMN ruta_imagen TO url_fuente;
ALTER TABLE imagenes_publicidad ADD CONSTRAINT tipo_fuente_fk FOREIGN KEY (id_tipo_fuente) REFERENCES tipo_fuente(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE publicidad ADD num_clicks bigint NOT NULL DEFAULT 0;
ALTER TABLE publicidad ADD fecha_fin date;
ALTER TABLE publicidad RENAME COLUMN fecha_publicacion TO fecha_ini;
ALTER TABLE publicidad ADD num_impresiones bigint NOT NULL DEFAULT 0;
ALTER TABLE publicidad RENAME COLUMN ubicacion TO seccion_page;
ALTER TABLE publicidad ADD heigh int4;
ALTER TABLE publicidad ADD width int4;
