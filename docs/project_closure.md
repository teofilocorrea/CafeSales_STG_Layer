# Project Closure — CafeSales STG Layer

## 📋 Información del proyecto

| Campo | Detalle |
|---|---|
| **Proyecto** | CafeSales STG Layer |
| **Fase** | 2 de 5 — Capa STG |
| **Autor** | Teófilo Correa Rojas |
| **Fecha inicio** | Julio 2026 |
| **Fecha cierre** | Julio 2026 |
| **Estado** | ✅ Completado |

---

## 🎯 Objetivos — ¿Se cumplieron?

| Objetivo | Estado |
|---|---|
| Diseñar la tabla de staging para datos crudos | ✅ Completado |
| Documentar el modelo como Diccionario de Datos | ✅ Completado |
| Cargar los 10,000 registros del dataset original | ✅ Completado |
| Preservar los datos sucios sin transformación | ✅ Completado |
| Validar la integridad de la carga | ✅ Completado |

---

## 🧱 Lo que se construyó

### Tabla creada

| Tabla | Campos | Registros |
|---|---|---|
| `stg.sales` | 8 (todos TEXT) | 10,000 |

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

### Documentos creados

| Documento | Descripción |
|---|---|
| `data_dictionary_stg.md` | Definición de los 8 campos y problemas esperados |
| `README.md` (capa) | Reglas y decisiones de la capa STG |
| `01_create_stg_sales.sql` | Script de creación de la tabla |

---

## 📚 Lo que aprendí en esta fase

| Concepto | Descripción |
|---|---|
| STG con datos sucios | Todos los campos como TEXT para evitar fallos de carga |
| Sin PRIMARY KEY en STG | Podrían existir IDs duplicados o vacíos en datos crudos |
| `COPY` vs `\copy` | COPY busca el archivo en el servidor; \copy en el cliente |
| Docker y rutas | COPY con Docker requiere el archivo dentro del contenedor |
| Repos autosuficientes | Cada repo debe incluir los archivos que sus scripts necesitan |

### Decisiones técnicas importantes

- Todos los campos se declararon como `TEXT` para preservar valores como `ERROR`
- No se aplicó PRIMARY KEY: se validará la unicidad de `transaction_id` en Silver
- La carga se realizó con el importador de DataGrip para evitar complejidad con Docker
- El dataset se incluyó en el repo para que sea autosuficiente

---

## 🔑 Lección más importante

```
En un proyecto con datos sucios,
la capa STG no puede imponer
ninguna restricción de tipo.
Un solo valor "ERROR" en un campo
numérico haría fallar la carga
completa de 10,000 registros.
STG acepta todo. Silver decide.
```

---

## ⚠️ Problemas de calidad identificados (a resolver en Silver)

| Problema | Ejemplo | Campos afectados |
|---|---|---|
| Valores de error | `ERROR` | price_per_unit, total_spent, payment_method |
| Valores desconocidos | `UNKNOWN` | item, payment_method |
| Valores nulos | `[null]` | total_spent, entre otros |
| Campos vacíos | *(vacío)* | item, payment_method, location |

---

## 🔜 Próximas fases

| Fase | Proyecto | Enfoque |
|---|---|---|
| 1 | CafeSales_Database_Infrastructure | Infraestructura ✅ |
| 2 | CafeSales_STG_Layer | Datos crudos ✅ |
| 3 | CafeSales_Bronze_Layer | Auditoría |
| 4 | CafeSales_Silver_Layer | Limpieza + análisis exploratorio ⭐ |
| 5 | CafeSales_Gold_Layer | Modelo dimensional + análisis de negocio |

---

## 👤 Autor

### Teófilo Correa Rojas

**TI Project Manager | Data analytic**

🔗 [LinkedIn](https://www.linkedin.com/in/teófilo-correa-rojas/)