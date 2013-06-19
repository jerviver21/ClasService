ALTER TABLE tipo_precio ADD precio numeric(10, 2);
ALTER TABLE precios_clasificados DROP COLUMN precio;
ALTER TABLE precios_clasificados ADD procesar_x_palabra boolean NOT NULL DEFAULT true;
