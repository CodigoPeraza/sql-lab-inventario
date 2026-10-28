-- Usuario de solo lectura para reportes y auditoría.
-- Las credenciales son de demostración; cámbialas en un entorno real.

CREATE ROLE IF NOT EXISTS 'rol_lectura';

GRANT SELECT ON inventario.* TO 'rol_lectura';

CREATE USER IF NOT EXISTS 'lector'@'%' IDENTIFIED BY 'lectorpass';

GRANT 'rol_lectura' TO 'lector'@'%';

SET DEFAULT ROLE 'rol_lectura' FOR 'lector'@'%';
