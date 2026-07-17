-- ============================================================
-- Tabla: stg.sales
-- Descripción: Almacena las transacciones de ventas de la
--              cafetería en formato crudo. Todos los campos
--              son TEXT para preservar los datos sucios.
-- Autor: Teofilo Correa Rojas
-- Fecha: 17 de julio 2026
-- ============================================================

CREATE TABLE IF NOT EXISTS stg.sales (

    transaction_id      TEXT,
    item                TEXT,
    quantity            TEXT,
    price_per_unit      TEXT,
    total_spent         TEXT,
    payment_method      TEXT,
    location            TEXT,
    transaction_date    TEXT

);