ALTER TABLE clasificado ADD nombre_ofertante varchar(1000);
ALTER TABLE clasificado ADD titulo_oferta varchar(1000);
ALTER TABLE campos_tipo DROP COLUMN salario;
ALTER TABLE campos_tipo DROP COLUMN area;
ALTER TABLE campos_tipo ADD nombre_ofertante boolean NOT NULL DEFAULT false;
ALTER TABLE campos_tipo ADD titulo_ofertante boolean NOT NULL DEFAULT false;
ALTER TABLE campos_tipo RENAME COLUMN precio TO valor;
ALTER TABLE campos_tipo RENAME COLUMN titulo_ofertante TO titulo_oferta;
