INSERT INTO reporte  VALUES ('clasificadosxdia','ROLE_ADMIN, ROLE_USER',1, 2);
INSERT INTO archivo (nombre, nombre_archivo, nombre_jasper, id_tipo_archivo, id_reporte) VALUES ('clasificadosxdia','clasificadosP{fecha}.pdf','clasificadosxdia.jasper',2,2);
insert into data (id, nombre, descripcion) values (500,'TIPO_PUBLICACION','tipos de publicación');
insert into parametros_reporte (nombre, etiqueta, id_tipo, id_data, id_reporte, id) values ('fecha', 'FECHA:', 3, null, 2, 3);
insert into parametros_reporte (nombre, etiqueta, id_tipo, id_data, id_reporte, id) values ('tipo', 'TIPO:', 5, 500, 2, 4);
