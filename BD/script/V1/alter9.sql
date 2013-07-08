ALTER TABLE clasificado ADD id_currency_oferta int4;
CREATE TABLE currencies (
	id int4 NOT NULL,
	nombre varchar(25) NOT NULL,
	cambio numeric(10, 2) NOT NULL
);
ALTER TABLE currencies ADD CONSTRAINT currencies_pk PRIMARY KEY(id);
ALTER TABLE clasificado ADD CONSTRAINT currency_fk FOREIGN KEY (id_currency_oferta) REFERENCES currencies(id) ON DELETE NO ACTION ON UPDATE NO ACTION;
