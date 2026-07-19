# Diccionario de Datos — STG Layer

## Propósito de la capa
La capa STG (Staging) almacena los datos crudos tal como vienen
del dataset original, sin ninguna transformación. Todos los campos
se declaran como TEXT para preservar los valores sucios (ERROR,
UNKNOWN, nulos, campos vacíos) sin que la base de datos los rechace.

## Regla clave de esta capa
Ningún campo usa tipos numéricos o de fecha todavía. Un campo como
`price_per_unit` puede contener el texto "ERROR", por lo que forzar
un tipo NUMERIC provocaría un fallo en la carga. La conversión de
tipos se realizará en la capa Silver.

---

## Tabla: stg.sales

### Descripción
Almacena las transacciones de ventas de la cafetería en formato
crudo. Cada registro representa una transacción individual.

### Campos

| Campo | Nombre original | Tipo | ¿Qué guarda? |
|---|---|---|---|
| `transaction_id` | Transaction ID | TEXT | Identificador único de la transacción |
| `item` | Item | TEXT | Nombre del producto comprado |
| `quantity` | Quantity | TEXT | Cantidad de unidades compradas |
| `price_per_unit` | Price Per Unit | TEXT | Precio de una unidad del producto |
| `total_spent` | Total Spent | TEXT | Monto total gastado en la transacción |
| `payment_method` | Payment Method | TEXT | Método de pago utilizado |
| `location` | Location | TEXT | Ubicación donde se realizó la venta |
| `transaction_date` | Transaction Date | TEXT | Fecha de la transacción |

---

## Problemas de calidad esperados

| Problema | Ejemplo | Campos afectados |
|---|---|---|
| Valores de error | `ERROR` | price_per_unit, total_spent, payment_method |
| Valores desconocidos | `UNKNOWN` | item, payment_method |
| Valores nulos | `[null]` | total_spent, entre otros |
| Campos vacíos | *(vacío)* | item, payment_method, location |

Estos problemas se diagnosticarán y limpiarán en la capa Silver.

---

## Nota sobre la conversión de tipos

Los tipos finales esperados (a aplicar en Silver) serán:

| Campo | Tipo STG | Tipo Silver (futuro) |
|---|---|---|
| `transaction_id` | TEXT | VARCHAR |
| `item` | TEXT | VARCHAR |
| `quantity` | TEXT | INTEGER |
| `price_per_unit` | TEXT | NUMERIC(10,2) |
| `total_spent` | TEXT | NUMERIC(10,2) |
| `payment_method` | TEXT | VARCHAR |
| `location` | TEXT | VARCHAR |
| `transaction_date` | TEXT | DATE |