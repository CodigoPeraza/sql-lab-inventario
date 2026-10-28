-- Vistas de consulta para operaciones y reportes.

CREATE OR REPLACE VIEW vw_productos_bajo_minimo AS
SELECT
    p.id,
    p.nombre,
    c.nombre AS categoria,
    p.stock,
    p.stock_minimo,
    (p.stock_minimo - p.stock) AS unidades_faltantes
FROM productos AS p
INNER JOIN categorias AS c ON c.id = p.categoria_id
WHERE p.activo = TRUE
  AND p.stock < p.stock_minimo;

CREATE OR REPLACE VIEW vw_inventario_por_categoria AS
SELECT
    c.id AS categoria_id,
    c.nombre AS categoria,
    COUNT(p.id) AS total_productos,
    COALESCE(SUM(p.stock), 0) AS unidades_en_stock,
    COALESCE(SUM(p.stock * p.precio), 0) AS valor_inventario
FROM categorias AS c
LEFT JOIN productos AS p
    ON p.categoria_id = c.id
   AND p.activo = TRUE
GROUP BY c.id, c.nombre;

CREATE OR REPLACE VIEW vw_movimientos_recientes AS
SELECT
    m.id,
    p.nombre AS producto,
    m.tipo,
    m.cantidad,
    m.motivo,
    m.creado_en
FROM movimientos AS m
INNER JOIN productos AS p ON p.id = m.producto_id
ORDER BY m.creado_en DESC
LIMIT 20;
