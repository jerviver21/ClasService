ALTER TABLE clasificado ADD valor_oferta numeric(10, 2);
ALTER TABLE campos_tipo DROP COLUMN salario;
ALTER TABLE campos_tipo DROP COLUMN area;
ALTER TABLE campos_tipo RENAME COLUMN precio TO valor;
