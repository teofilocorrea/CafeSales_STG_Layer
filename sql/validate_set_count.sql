-- ============================================================
-- Script   : Validación de carga STG
-- Capa     : STG
-- Objetivo : Verificar que los 10,000 registros del dataset
--            se cargaron correctamente en stg.sales
-- Autor    : Teofilo Correa Rojas
-- Fecha    : 19 de julio 2026
-- ============================================================

SELECT COUNT(*) AS total_registros
FROM stg.sales;

-- Resultado esperado: 10000