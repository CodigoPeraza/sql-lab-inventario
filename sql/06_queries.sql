-- Consultas de verificación y reportes.
-- Ejecutar con: make shell < sql/06_queries.sql

USE inventario;

-- 1. Catálogo completo con categoría y proveedor.
SELECT
    p.id,
    p.nombre AS producto,
    c.nombre AS categoria,
    pr.nombre AS proveedor,
    p.precio,
    p.stock
FROM productos AS p
INNER JOIN categorias AS c ON c.id = p.categoria_id
LEFT JOIN proveedores AS pr ON pr.id = p.proveedor_id
WHERE p.activo = TRUE
ORDER BY c.nombre, p.nombre;

-- 2. Productos por debajo del stock mínimo.
SELECT *
FROM vw_productos_bajo_minimo
ORDER BY unidades_faltantes DESC;

-- 3. Valor del inventario por categoría.
SELECT *
FROM vw_inventario_por_categoria
ORDER BY valor_inventario DESC;

-- 4. Historial reciente de movimientos.
SELECT *
FROM vw_movimientos_recientes;

-- 5. Productos que nunca han tenido movimientos.
SELECT
    p.id,
    p.nombre,
    p.stock
FROM productos AS p
LEFT JOIN movimientos AS m ON m.producto_id = p.id
WHERE m.id IS NULL;

-- 6. Total de entradas y salidas por producto.
SELECT
    p.nombre AS producto,
    SUM(CASE WHEN m.tipo = 'ENTRADA' THEN m.cantidad ELSE 0 END) AS total_entradas,
    SUM(CASE WHEN m.tipo = 'SALIDA' THEN m.cantidad ELSE 0 END) AS total_salidas,
    SUM(CASE WHEN m.tipo = 'AJUSTE' THEN m.cantidad ELSE 0 END) AS total_ajustes
FROM productos AS p
LEFT JOIN movimientos AS m ON m.producto_id = p.id
GROUP BY p.id, p.nombre
ORDER BY p.nombre;

-- 7. Top 3 productos con mayor valor en stock.
SELECT
    p.nombre,
    p.stock,
    p.precio,
    (p.stock * p.precio) AS valor_stock
FROM productos AS p
WHERE p.activo = TRUE
ORDER BY valor_stock DESC
LIMIT 3;
