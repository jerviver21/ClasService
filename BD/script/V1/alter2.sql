ALTER TABLE clasificado ADD publicarweb boolean;
ALTER TABLE clasificado ADD area_oferta int4;
ALTER TABLE clasificado ADD publicarimpreso boolean;
ALTER TABLE clasificado ADD precio_oferta numeric(10, 2);
ALTER TABLE tipo_clasificado ADD subtipo int4;
ALTER TABLE tipo_clasificado ADD name varchar(25);
ALTER TABLE tipo_clasificado RENAME COLUMN name TO nombre;
