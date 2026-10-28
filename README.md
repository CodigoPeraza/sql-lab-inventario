<div align="center">

# SQL Lab — Inventario

**Laboratorio de diseño y administración de bases de datos con MariaDB, Docker y SQL.**

![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Make](https://img.shields.io/badge/Make-6D00CC?style=for-the-badge&logo=gnu&logoColor=white)

</div>

## Descripción

Laboratorio de base de datos para un inventario pequeño. El proyecto cubre el ciclo completo: modelo entidad-relación, normalización, creación del esquema, datos de prueba, consultas, vistas, triggers, procedimiento almacenado, roles y respaldo/restauración.

El objetivo es demostrar diseño y administración de bases de datos más allá de un CRUD básico, manteniendo la lógica crítica dentro del motor y documentando las decisiones.

## Funcionalidades

- Esquema relacional con categorías, proveedores, productos y movimientos.
- Restricciones de integridad: claves foráneas, `CHECK` y unicidad.
- Trigger que actualiza el stock a partir de entradas, salidas y ajustes.
- Trigger que rechaza salidas con stock insuficiente.
- Procedimiento almacenado para registrar movimientos.
- Vistas para productos bajo mínimo, valor por categoría y movimientos recientes.
- Consultas de reporte con `JOIN`, agregaciones y `CASE`.
- Usuario y rol de solo lectura para reportes.
- Scripts de backup y restauración.
- Entorno reproducible con Docker Compose.

## Stack

- MariaDB 11.4
- SQL (DDL, DML, vistas, triggers, procedimientos, roles)
- Docker Compose
- Bash para backup/restore
- Make para tareas frecuentes

## Estructura

```text
sql-lab-inventario/
├── docker-compose.yml
├── Makefile
├── .env.example
├── sql/
│   ├── 01_schema.sql
│   ├── 02_procedure_trigger.sql
│   ├── 03_seed.sql
│   ├── 04_views.sql
│   ├── 05_roles.sql
│   └── 06_queries.sql
├── scripts/
│   ├── backup.sh
│   └── restore.sh
├── docs/
│   ├── erd.md
│   └── normalizacion.md
└── backups/
```

## Puesta en marcha

```bash
cp .env.example .env
make up
```

Espera a que el contenedor termine de inicializar y verifica:

```bash
docker compose ps
make logs
```

La base de datos queda expuesta en `localhost:3307`.

### Credenciales de demostración

| Uso | Usuario | Contraseña | Base |
| --- | --- | --- | --- |
| Administración | `root` | `rootpass` | `inventario` |
| Aplicación | `inventario_app` | `apppass` | `inventario` |
| Solo lectura | `lector` | `lectorpass` | `inventario` |

> Las credenciales son de laboratorio. Cámbialas antes de usar el proyecto fuera de un entorno local.

## Consultas de verificación

```bash
make shell < sql/06_queries.sql
```

O entra a la consola interactiva:

```bash
make shell
```

## Backup y restauración

```bash
make backup
make restore FILE=backups/inventario_20260101_120000.sql.gz
```

Los respaldos se generan en `backups/` y no se versionan en Git.

## Diseño

- [Modelo entidad-relación](docs/erd.md)
- [Normalización y decisiones](docs/normalizacion.md)

## Decisiones técnicas destacadas

- **Stock derivado:** el trigger mantiene el stock sincronizado con el historial de movimientos.
- **Validación en la base:** una salida mayor al stock disponible se rechaza con `SIGNAL SQLSTATE`.
- **Integridad referencial:** las claves foráneas y los `CHECK` evitan datos inconsistentes.
- **Separación de responsabilidades:** la base conserva la lógica de inventario y el respaldo se automatiza con scripts.
- **Roles:** se crea un usuario de solo lectura para reportes, aplicando el principio de mínimo privilegio.

## Limitaciones

- El proyecto está pensado para un entorno local con Docker.
- El script de roles asume que la base se llama `inventario`; si cambias el nombre, ajusta `sql/05_roles.sql`.
- No incluye una aplicación web ni API; el foco es la base de datos.
- Los respaldos son locales; en producción deberían almacenarse fuera del servidor y cifrarse.

## Materias que respalda

- Introducción a las Bases de Datos.
- Diseño y Programación de Base de Datos.
- Administración de Bases de Datos.

## Autor

**Francisco Javier Peraza** · [GitHub](https://github.com/CodigoPeraza) · [contacto.peraza@gmail.com](mailto:contacto.peraza@gmail.com)
