INSERT INTO tipo_publicacion values (1, 'NORMAL');
INSERT INTO tipo_publicacion values (2, 'ECONOMICOS');
INSERT INTO tipo_publicacion values (3, 'SUPERECONOMICOS');
INSERT INTO tipo_publicacion values (4, 'WEB');


INSERT INTO precios values (1,'NORMAL SEMANAL', 0.10, true);
INSERT INTO precios values (2,'NORMAL DOMINICAL', 0.15, true);
INSERT INTO precios values (3,'NORMAL FESTIVO', 0.20, true);

INSERT INTO precios values (4,'ECONOMICO SEMANAL', 0.05, true);
INSERT INTO precios values (5,'ECONOMICO DOMINICAL',0.10, true);
INSERT INTO precios values (6,'ECONOMICO FESTIVO', 0.15, true);

INSERT INTO precios values (7,'SUPER ECONOMICO SEMANAL', 0.04, true);
INSERT INTO precios values (8,'SUPER ECONOMICO DOMINICAL', 0.11, true);
INSERT INTO precios values (9,'SUPER ECONOMICO FESTIVO', 0.16, true);

INSERT INTO precios values (10,'WEB', 1.00, false);


INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (1, 1, 'DOMINGO', 2);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (1, 2, 'LUNES', 1);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (1, 3, 'MARTES', 1);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (1, 4, 'MIERCOLES', 1);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (1, 5, 'JUEVES', 1);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (1, 6, 'VIERNES', 1);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (1, 7, 'SABADO', 1);

INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (2, 1, 'DOMINGO', 5);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (2, 2, 'LUNES', 4);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (2, 3, 'MARTES', 4);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (2, 4, 'MIERCOLES', 4);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (2, 5, 'JUEVES', 4);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (2, 6, 'VIERNES', 4);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (2, 7, 'SABADO', 4);

INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (3, 1, 'DOMINGO', 8);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (3, 2, 'LUNES', 7);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (3, 3, 'MARTES', 7);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (3, 4, 'MIERCOLES', 7);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (3, 5, 'JUEVES', 7);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (3, 6, 'VIERNES', 7);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (3, 7, 'SABADO', 7);

INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (4, 1, 'DOMINGO', 10);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (4, 2, 'LUNES', 10);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (4, 3, 'MARTES', 10);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (4, 4, 'MIERCOLES', 10);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (4, 5, 'JUEVES', 10);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (4, 6, 'VIERNES', 10);
INSERT INTO dias_precios (id_tipo_publicacion, iddia, nombre_dia, id_precio) values (4, 7, 'SABADO', 10);


