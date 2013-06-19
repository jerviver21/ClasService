ALTER TABLE tipo_precio RENAME TO precios;
ALTER TABLE precios_clasificados RENAME TO dias_precios;
CREATE TABLE festivos (
	fecha date NOT NULL
);
ALTER TABLE festivos ADD CONSTRAINT festivos_pk PRIMARY KEY(fecha);
