ALTER TABLE tipo_publicacion RENAME TO subtipo_publicacion;
ALTER TABLE clasificado RENAME COLUMN id_tipo_publicacion TO id_subtipo_publicacion;
CREATE TABLE tipo_publicacion (
	id int4,
	nombre varchar(255)
);
ALTER TABLE tipo_publicacion ADD CONSTRAINT tipo_publicacion_pk PRIMARY KEY(id);
ALTER TABLE clasificado ADD id_tipo_publicacion int4;
ALTER TABLE clasificado ADD CONSTRAINT tp_fk1 FOREIGN KEY (id_tipo_publicacion) REFERENCES tipo_publicacion(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE clasificado DROP COLUMN prioridad;
ALTER TABLE subtipo_publicacion ADD id_tipo_publicacion int4;
ALTER TABLE clasificado DROP CONSTRAINT tp_fk1;
ALTER TABLE clasificado DROP COLUMN id_tipo_publicacion;
ALTER TABLE subtipo_publicacion ADD CONSTRAINT tipo_sub_fk1 FOREIGN KEY (id_tipo_publicacion) REFERENCES tipo_publicacion(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
