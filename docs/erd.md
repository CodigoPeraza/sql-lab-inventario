# Modelo entidad-relación

```mermaid
erDiagram
    CATEGORIAS ||--o{ PRODUCTOS : clasifica
    PROVEEDORES ||--o{ PRODUCTOS : suministra
    PRODUCTOS ||--o{ MOVIMIENTOS : registra

    CATEGORIAS {
        bigint id PK
        varchar nombre UK
        varchar descripcion
        timestamp creado_en
    }

    PROVEEDORES {
        bigint id PK
        varchar nombre UK
        varchar contacto
        varchar telefono
        varchar email
        timestamp creado_en
    }

    PRODUCTOS {
        bigint id PK
        varchar nombre
        varchar descripcion
        decimal precio
        int stock
        int stock_minimo
        bigint categoria_id FK
        bigint proveedor_id FK
        boolean activo
        timestamp creado_en
        timestamp actualizado_en
    }

    MOVIMIENTOS {
        bigint id PK
        bigint producto_id FK
        enum tipo
        int cantidad
        varchar motivo
        timestamp creado_en
    }
```

## Reglas del modelo

- Un producto pertenece a una categoría.
- Un producto puede tener un proveedor; si el proveedor se elimina, el producto queda sin proveedor.
- Cada movimiento pertenece a un producto y conserva el historial de entradas, salidas y ajustes.
- El stock se modifica mediante un trigger, no directamente desde la aplicación.
- Los productos inactivos se conservan para no perder el historial.
