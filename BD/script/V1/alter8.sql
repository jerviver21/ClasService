ALTER TABLE clasificado ADD id_subtipo6 int4;
ALTER TABLE clasificado ADD CONSTRAINT subtipo6_fk FOREIGN KEY (id_subtipo6) REFERENCES tipo_clasificado(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
