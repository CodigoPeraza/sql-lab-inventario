# Normalización y decisiones de diseño

## Primera forma normal (1NF)

Cada columna almacena un único valor atómico. No se guardan listas de teléfonos, categorías ni proveedores dentro de una misma columna.

## Segunda forma normal (2NF)

Las tablas tienen claves primarias simples (`id`) y todos los atributos dependen de la clave completa. Las categorías y los proveedores se separan de los productos para evitar duplicar sus datos en cada fila.

## Tercera forma normal (3NF)

Los atributos no clave no dependen de otros atributos no clave:

- El nombre de la categoría vive en `categorias`.
- Los datos del proveedor viven en `proveedores`.
- El historial de stock vive en `movimientos`.
- El producto no almacena el nombre de su categoría ni el nombre del proveedor.

## Decisiones adicionales

- **Stock derivado del historial:** el stock se actualiza con un trigger a partir de los movimientos. Así se evita que la aplicación pueda dejar el inventario y el historial inconsistentes.
- **Salidas validadas:** un trigger `BEFORE INSERT` rechaza salidas mayores al stock disponible.
- **Productos inactivos:** se usa `activo` en lugar de eliminar productos con historial.
- **Índices:** se indexan las claves foráneas y las columnas usadas en filtros frecuentes (`activo`, `creado_en`).
- **Restricciones:** `CHECK` protege precios y cantidades negativas; las claves foráneas protegen la integridad referencial.
