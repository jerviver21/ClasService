INSERT INTO estados_pedido values (1, 'ACTIVO PARA PAGO');
INSERT INTO estados_pedido values (2, 'PAGO');
INSERT INTO estados_pedido values (3, 'VENCIDO');
INSERT INTO estados_pedido values (4, 'CANCELADO');

INSERT INTO estados_clasificado values (1, 'PEDIDO POR PAGAR');
INSERT INTO estados_clasificado values (2, 'PUBLICADO');
INSERT INTO estados_clasificado values (3, 'CANCELADO');
INSERT INTO estados_clasificado values (4, 'PEDIDO VENCIDO');
INSERT INTO estados_clasificado values (5, 'VENDIDO');
INSERT INTO estados_clasificado values (6, 'EXPIRADO');

INSERT INTO entidades_pago (id, nombre, mensaje_pago) values (1, 'PAGAR EN SEDE DEL PERIODICO', 'Acerquece a una sede del periodico y utilice el código de pago COD_PAGO para realizar su pago');
INSERT INTO entidades_pago (id, nombre, mensaje_pago) values (2, 'BANCO DE CRÉDITO', 'Acerquese a un agente BCP o utilice viabcp.com y utilice el código de pago COD_PAGO para realizar su pago');





