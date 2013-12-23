ALTER TABLE img_clasificado ADD CONSTRAINT img_clasificado_fk FOREIGN KEY (id_clasificado) REFERENCES clasificado(id) ON DELETE CASCADE ON UPDATE CASCADE;
