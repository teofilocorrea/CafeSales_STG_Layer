# STG Layer — CafeSales

## ¿Qué es esta capa?

La capa STG (Staging) es la primera capa de la arquitectura
Medallion. Almacena los datos **crudos tal como vienen del
dataset original**, sin ninguna transformación ni validación.

---

## 📋 Reglas de esta capa

- Todos los campos se declaran como `TEXT`
- Sin PRIMARY KEY
- Sin NOT NULL
- Sin constraints de ningún tipo
- Los datos sucios se preservan tal cual (ERROR, UNKNOWN, nulos, vacíos)

---

## 💡 ¿Por qué todo es TEXT?

El dataset contiene valores como `ERROR` mezclados con números.
Si se declarara `price_per_unit` como `NUMERIC`, la carga fallaría
al encontrar un valor de texto.

```
price_per_unit → contiene "3.0" y también "ERROR"
→ NUMERIC rechazaría "ERROR" ❌
→ TEXT acepta ambos ✅
```

La conversión de tipos se realizará en la capa Silver, después de
la limpieza.

---

## 💡 ¿Por qué sin PRIMARY KEY?

Un PRIMARY KEY exige valores únicos y no nulos. En datos sucios
podrían existir `transaction_id` duplicados o vacíos, lo que
haría fallar la carga.

```
STG acepta TODO sin rechazar nada
"Primero cargo, después valido"
```

El PRIMARY KEY se aplicará en Silver, sobre datos ya validados.

---

## 📊 Tabla

| Tabla | Descripción | Registros |
|---|---|---|
| `stg.sales` | Transacciones de venta en formato crudo | 10,000 |

### Campos

| Campo | Nombre original | Tipo |
|---|---|---|
| `transaction_id` | Transaction ID | TEXT |
| `item` | Item | TEXT |
| `quantity` | Quantity | TEXT |
| `price_per_unit` | Price Per Unit | TEXT |
| `total_spent` | Total Spent | TEXT |
| `payment_method` | Payment Method | TEXT |
| `location` | Location | TEXT |
| `transaction_date` | Transaction Date | TEXT |

---

## ⚠️ Problemas de calidad presentes

| Problema | Ejemplo | Campos afectados |
|---|---|---|
| Valores de error | `ERROR` | price_per_unit, total_spent, payment_method |
| Valores desconocidos | `UNKNOWN` | item, payment_method |
| Valores nulos | `[null]` | total_spent, entre otros |
| Campos vacíos | *(vacío)* | item, payment_method, location |

Estos problemas se diagnosticarán y limpiarán en la capa Silver.

---

## 📖 Diccionario de Datos

📄 [data_dictionary_stg.md](data_dictionary_stg.md)

---

## 🔄 Proceso de carga

Los 10,000 registros se cargaron mediante el importador de datos
de DataGrip desde `dirty_cafe_sales.csv` hacia `stg.sales`.

**Validación de la carga:**

```sql
SELECT COUNT(*) AS total_registros
FROM stg.sales;

-- Resultado esperado: 10000
```

---

## 🗂️ Estructura de archivos

```
01_stg/
├── create_tables/
│   └── 01_create_stg_sales.sql
├── insert_data/
│   └── 01_load_stg_sales.md
├── README.md
└── data_dictionary_stg.md
```

---

## 🔗 Capas relacionadas

| Capa | Descripción |
|---|---|
| ➡️ **STG** | Estás aquí — datos crudos sin transformar |
| ⬇️ Bronze | Próxima capa — copia con auditoría |
| ⬇️ Silver | Limpieza y validación de datos |
| ⬇️ Gold | Modelo dimensional y análisis |