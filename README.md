# 🌐 Análisis de Actividad Portuaria Global 2020 - octubre 2024

Análisis exploratorio de datos de actividad portuaria global usando SQL,
como parte de un proyecto de portafolio en análisis de datos.

> **Nota:** Este proyecto es complementario al análisis del
> [Puerto de Manzanillo](https://github.com/agaliciap27/PUERTO-EXPORTACIONES-2025),
> que profundiza en el principal puerto de México — el cual no está incluido en este dataset del IMF.

---

## 🛠️ Herramientas

- PostgreSQL 18
- pgAdmin 4

---

## 🗄️ Dataset

- **Fuente:** IMF — Global Daily Port Activity and Trade Estimates (Kaggle)
- **Registros:** 868,592
- **Puertos:** 486 puertos en más de 100 países
- **Período:** enero 2020 — octubre 2024
- **Columnas:** 30 (fecha, identificación del puerto, portcalls por tipo de buque, importaciones y exportaciones por tipo de carga)

---

## ⚠️ Limitaciones del dataset

- El dataset cubre 486 puertos **seleccionados** por el IMF y no representa la totalidad del comercio global.
Los totales deben interpretarse como **estimaciones**, no como cifras absolutas.
- Para México, los puertos más importantes — **Manzanillo y Lázaro Cárdenas** — no están incluidos en la muestra,
lo que limita la representatividad del análisis para este país.
- Los datos de **2024 cubren únicamente enero-octubre**, por lo que ese año aparece con menor volumen que los años completos.

---

## 📊 Análisis realizados

1. Año con mayor movimiento portuario por tonelaje
2. Países con mayor movimiento portuario (2020–2024)
3. Tipos de buques con mayor número de escalas
4. Países con mayor movimiento de importación global
5. Países con mayor movimiento de exportación global
6. Puertos con mayor crecimiento (2020–2023)
7. Puertos con mayor caída (2020–2023)
8. Puertos mexicanos presentes en el dataset
9. Portcalls vs Volumen: eficiencia de carga por escala

---

## 🔎 Hallazgos Principales

### 📅 Año con mayor movimiento

| Año | Movimiento total (TON) |
|-----|------------------------|
| 2023 | 4,162,055,030.87 |
| 2022 | 4,146,906,397.50 |
| 2021 | 4,130,171,120.29 |
| 2020 | 4,116,456,393.70 |
| 2024* | 3,222,938,284.94 |

*Datos parciales enero–octubre únicamente.

El año **2023** lideró el movimiento global, impulsado por la recuperación
post-pandemia: la regularización de los costos de fletes permitió el flujo
continuo y masivo de contenedores a nivel mundial.

---

### 🌍 Países con mayor movimiento total

**China** domina ampliamente con **6,475,222,917.97 TON** — casi 5 veces más que el segundo lugar.
**Singapore** ocupa el segundo lugar con 1,247,743,357.49 TON, no por ser una economía de gran tamaño,
sino por su rol como **hub de transbordo global**: los barcos llegan, transfieren carga y salen,
sin que esa carga sea necesariamente producida o consumida en Singapur.

> Redacción. (2019). *Cómo Singapur pasó de ser una isla pobre a uno de los países más ricos del mundo.*
> BBC News Mundo. https://www.bbc.com/mundo/noticias-47032379

---

### 🚢 Tipos de buques con mayor actividad

| Tipo de buque | Total de escalas |
|---------------|-----------------|
| Tanker (líquidos) | 906,523 |
| Container | 863,546 |
| General Cargo | 644,259 |
| Dry Bulk | 498,155 |
| Ro-Ro | 108,797 |

Los **tanqueros** lideran por número de escalas, seguidos de los **buques de contenedores**.
El dataset clasifica la carga en dos grandes categorías: carga seca (container, dry bulk,
general cargo, ro-ro) y carga líquida (tanker).

---

### 📦 Importaciones y exportaciones globales

**Importaciones:** China lidera con **4,231,062,523.04 TON** acumuladas (2020–2024).
El año con mayor importación global fue **2023** con 2,200,322,494.02 TON.

**Exportaciones:** China también encabeza con **2,244,160,394.93 TON**.
Brasil ocupa el segundo lugar con 694,383,041.09 TON, y la Federación de Rusia el tercero
con 686,166,526.85 TON. El año con mayor exportación global fue **2021** con 1,984,324,573.34 TON.

> La diferencia entre el pico de importaciones (2023) y exportaciones (2021) refleja
> la asimetría en la recuperación post-COVID: en 2021 se dispararon las exportaciones de
> materias primas mientras el mundo industrializado aún reactivaba su demanda de productos terminados.

---

### 📈 Puertos con mayor crecimiento (2020–2023)

| Puerto | País | Crecimiento (TON) |
|--------|------|-------------------|
| Zhoushan | China | +26,612,314.79 |
| Xiagong | China | +24,035,889.69 |
| Laem Chabang | Tailandia | +17,668,230.14 |
| Santos | Brasil | +14,100,950.07 |
| Tanjung Pelepas | Malasia | +14,008,451.18 |

---

### 📉 Puertos con mayor caída (2020–2023)

| Puerto | País | Variación (TON) |
|--------|------|-----------------|
| Ulsan | Corea del Sur | -31,357,788.37 |
| Pivdennyi | Ucrania | -28,140,484.32 |
| Qinhuangdao | China | -21,486,354.04 |
| Singapore | Singapore | -20,006,681.20 |

**Nota sobre Singapore:** La caída no representa un deterioro real del puerto.
En 2020, Singapore registró un volumen artificialmente alto al absorber carga desviada
de otros puertos congestionados por la pandemia. Al normalizarse el comercio global en 2023,
esa carga extra regresó a sus rutas originales — lo que en análisis de datos se denomina
**normalización de un valor atípico contextual.**

**Nota sobre Pivdennyi (Ucrania):** La caída está directamente relacionada con
el conflicto bélico iniciado en 2022, que afectó severamente las operaciones portuarias en el Mar Negro.

---

### 🇲🇽 Puertos mexicanos en el dataset

| Puerto | Movimiento total (TON) |
|--------|------------------------|
| Veracruz | 63,881,975.73 |
| Salina Cruz | 16,232,930.31 |
| Tuxpan | 14,471,066.07 |
| Progreso Yucatán | 12,972,469.50 |
| Tampico | 11,558,693.76 |
| San Miguel de Cozumel | 7,448,299.87 |
| Topolobampo | 7,421,106.19 |
| Rosarito | 6,827,441.67 |

El dataset incluye 8 puertos mexicanos. Sin embargo, los principales puertos del país —
**Manzanillo (#1 en contenedores) y Lázaro Cárdenas (#2)** — no están en la muestra del IMF,
lo que limita la representatividad de este análisis para México.

---

### ⚓ Portcalls vs Volumen: eficiencia de carga por escala

| Puerto | País | TON por escala |
|--------|------|----------------|
| Saldanha Bay | Sudáfrica | 59,666.32 |
| Ras Tanura | Arabia Saudita | 50,623.02 |
| Abbot Point | Australia | 49,806.72 |
| Swanport | Australia | 48,970.78 |
| Tubarao | Brasil | 48,521.14 |

Los puertos con mayor tonelaje por escala son aquellos especializados en **carga a granel masiva**:
mineral de hierro, petróleo y carbón. Estos puertos reciben pocos barcos pero de capacidad
extraordinaria — confirmando que el número de escalas no es indicador suficiente del volumen real de un puerto.

---

## 🔧 Técnicas SQL aplicadas

- `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `ORDER BY`, `LIMIT`
- Funciones de agregación: `SUM()`, `COUNT()`, `MAX()`
- `ROUND()` para formateo de resultados
- `LIKE` con comodines para filtros de texto
- `JOIN` con subconsultas para comparación de múltiples años
- `NULLIF()` para manejo de división entre cero
- Documentación con comentarios SQL (`--`)

---

## 📌 Nota

Datos de uso académico y de portafolio.

**Autora:** Andrea Galicia
