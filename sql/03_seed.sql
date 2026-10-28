-- Datos de demostración.
-- El stock inicial se construye mediante movimientos para ejercitar el trigger.

INSERT INTO categorias (nombre, descripcion) VALUES
    ('Lácteos', 'Productos refrigerados y derivados de la leche'),
    ('Granos', 'Arroz, café, frijoles y productos secos'),
    ('Limpieza', 'Detergentes, jabones y suministros de aseo'),
    ('Bebidas', 'Agua, jugos y bebidas listas para consumir');

INSERT INTO proveedores (nombre, contacto, telefono, email) VALUES
    ('Distribuidora La Central', 'Ana López', '2201-0101', 'ventas@lacentral.example'),
    ('Agropecuaria El Valle', 'Carlos Méndez', '2202-0202', 'pedidos@elvalle.example'),
    ('Suministros del Sur', 'María Rivera', '2203-0303', 'contacto@delsur.example');

INSERT INTO productos
    (nombre, descripcion, precio, stock, stock_minimo, categoria_id, proveedor_id)
VALUES
    ('Leche entera 1 L', 'Leche entera pasteurizada', 1.25, 0, 10, 1, 1),
    ('Arroz 5 lb', 'Arroz blanco de grano largo', 4.50, 0, 8, 2, 2),
    ('Detergente 1 kg', 'Detergente en polvo multiusos', 3.75, 0, 6, 3, 3),
    ('Café molido 500 g', 'Café tostado y molido', 6.80, 0, 5, 2, 1),
    ('Agua 600 ml', 'Agua purificada sin gas', 0.60, 0, 24, 4, 3),
    ('Yogurt natural 1 L', 'Yogurt natural sin azúcar', 1.80, 0, 8, 1, 1);

INSERT INTO movimientos (producto_id, tipo, cantidad, motivo) VALUES
    (1, 'ENTRADA', 40, 'Compra inicial'),
    (2, 'ENTRADA', 25, 'Compra inicial'),
    (3, 'ENTRADA', 12, 'Compra inicial'),
    (4, 'ENTRADA', 10, 'Compra inicial'),
    (5, 'ENTRADA', 60, 'Compra inicial'),
    (6, 'ENTRADA', 5, 'Compra inicial'),
    (1, 'SALIDA', 12, 'Venta mostrador'),
    (5, 'SALIDA', 18, 'Venta mostrador'),
    (6, 'SALIDA', 1, 'Venta mostrador');
