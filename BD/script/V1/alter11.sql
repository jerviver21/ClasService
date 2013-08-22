ALTER TABLE pedido ADD dni_cliente varchar(20);
ALTER TABLE pedido ADD nombre_cliente varchar(255);
ALTER TABLE pedido DROP COLUMN fecha_vencimiento;
ALTER TABLE pedido ADD fecha_vencimiento date;
