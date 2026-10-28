-- Lógica de negocio en la base de datos.
-- El trigger mantiene el stock sincronizado con el historial de movimientos.

DELIMITER //

CREATE TRIGGER trg_movimientos_valida_stock
BEFORE INSERT ON movimientos
FOR EACH ROW
BEGIN
    DECLARE v_stock_actual INT DEFAULT 0;

    SELECT stock INTO v_stock_actual
    FROM productos
    WHERE id = NEW.producto_id;

    IF NEW.tipo = 'SALIDA' AND v_stock_actual < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock insuficiente para registrar la salida';
    END IF;
END//

CREATE TRIGGER trg_movimientos_actualiza_stock
AFTER INSERT ON movimientos
FOR EACH ROW
BEGIN
    IF NEW.tipo = 'ENTRADA' THEN
        UPDATE productos
        SET stock = stock + NEW.cantidad
        WHERE id = NEW.producto_id;
    ELSEIF NEW.tipo = 'SALIDA' THEN
        UPDATE productos
        SET stock = stock - NEW.cantidad
        WHERE id = NEW.producto_id;
    ELSE
        UPDATE productos
        SET stock = NEW.cantidad
        WHERE id = NEW.producto_id;
    END IF;
END//

CREATE PROCEDURE sp_registrar_movimiento(
    IN p_producto_id BIGINT UNSIGNED,
    IN p_tipo VARCHAR(10),
    IN p_cantidad INT,
    IN p_motivo VARCHAR(255)
)
BEGIN
    INSERT INTO movimientos (producto_id, tipo, cantidad, motivo)
    VALUES (p_producto_id, p_tipo, p_cantidad, p_motivo);
END//

DELIMITER ;
