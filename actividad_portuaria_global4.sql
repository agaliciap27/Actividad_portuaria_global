-- ============================================================
-- PROYECTO: Análisis de Actividad Portuaria Global 2020 - 10-2024
-- AUTOR: Andrea Galicia 
-- FUENTE:IMF - Global Daily Port Activity and Trade Estimates (Kaggle)
	-- DESCRIPCIÓN: Analizar las capacidades portuarias globales de
	--los años 2020 a 10/2024
-- HERRAMIENTAS: PostgreSQL 18 / pgAdmin 4
-- NOTA: Datos anonimizados para uso académico/portafolio
-- ============================================================

-- ============================================================
-- CREACIÓN DE TABLA
-- ============================================================

CREATE TABLE actividad_portuaria_diaria (
    fecha        TIMESTAMP WITH TIME ZONE,
    anio         SMALLINT,
    mes          SMALLINT,
    dia          SMALLINT,
    puerto_id    TEXT,
    puerto_nombre TEXT,
    pais         TEXT,
    iso3         CHAR(3),
	portcalls_container      INTEGER,
    portcalls_dry_bulk       INTEGER,
    portcalls_general_cargo  INTEGER,
    portcalls_roro           INTEGER,
    portcalls_tanker         INTEGER,
    portcalls_cargo          INTEGER,
    portcalls                INTEGER,
	import_container      NUMERIC,
    import_dry_bulk       NUMERIC,
    import_general_cargo  NUMERIC,
    import_roro           NUMERIC,
    import_tanker         NUMERIC,
    import_cargo          NUMERIC,
    importacion           NUMERIC,
    export_container      NUMERIC,
    export_dry_bulk       NUMERIC,
    export_general_cargo  NUMERIC,
    export_roro           NUMERIC,
    export_tanker         NUMERIC,
    export_cargo          NUMERIC,
    exportacion           NUMERIC,
    object_id             INTEGER
);

-- ============================================================
-- RECONOCIMIENTO DE DATOS
-- ============================================================

SELECT COUNT(*) FROM actividad_portuaria_diaria;


SELECT puerto_id, pais
FROM actividad_portuaria_diaria
Where pais LIKE '%Mexico%';
--México tiene el puerto ID_1023

SELECT COUNT (pais)
FROM actividad_portuaria_diaria
WHERE pais LIKE '%Mexico%';

-- ============================================================
-- ANÁLISIS 1: Año con mayor movimiento portuario por tonelaje. 
-- ============================================================

SELECT ROUND(SUM(importacion +exportacion),2) as total_movimiento, anio 
FROM actividad_portuaria_diaria 
GROUP BY anio 
ORDER BY total_movimiento desc;

--El año con mayor movimiento portuario fue el 2023 con un movimiento de: 4,162,055,030.87,
--esto debido a que los países se estaban recuperando tras la pandemia, se empezaron a 
--regularizar los costos de los fletes y eso les permitió el flujo continuo y masivo de contenedores. 
--seguido de 2022 con un movimiento de 4,146,906,397.50

--NOTA: 2024 aparece al último no porque la economía se contrajo, sino porque el dataset está incompleto para ese año;
--Los datos de 2024 corresponden al período enero-octubre únicamente. 
-- =====================================================================
-- ANÁLISIS 2: Países con mayor movimiento portuario entre 2020 y 2024
-- ======================================================================

SELECT ROUND(SUM(importacion +exportacion),2) as total_movimiento, pais
FROM actividad_portuaria_diaria 
GROUP BY pais
ORDER BY total_movimiento desc
LIMIT 10;

--El país con mayor movimiento portuario es CHINA con un movimiento de 6,475,222,917.97 TON
--Seguido de SINGAPORE con 1,247,743,357.49; el puerto de Singapore se ha caracterizado por ser 
--un puerto que funciona como el principal centro de transbordos global, pues tiene conexiones importantes
--con Asia, Europa y América. Singapore se ha caracterizado por ser un puerto que ofrece servicios portuarios
--rapidos, aduanas altamente eficientes y tecnología altamente eficiente. 
--DATO:
--Redacción. (2019, 29 enero). Cómo Singapur pasó de ser una isla pobre a uno de los países más ricos del mundo (y qué amenaza enfrenta ahora). BBC News Mundo. https://www.bbc.com/mundo/noticias-47032379

-- =====================================================================
-- ANÁLISIS 3: ¿Qué tipo de buques son los que más se mueven?
-- ======================================================================

SELECT SUM (portcalls_container) as total_portcalls_container,
SUM (portcalls_dry_bulk) as total_dry_bulk,
SUM (portcalls_general_cargo) as total_general_cargo,
SUM (portcalls_roro) as total_roro,
SUM (portcalls_tanker) as total_tanker,
SUM (portcalls_cargo) as subtotal_cargo,
SUM (portcalls) as total_general
FROM actividad_portuaria_diaria;

--El subtotal incluye todos los buques que mueven carga seca: 
--Container:     863,546
--Dry Bulk:      498,155
--General Cargo: 644,259
--Ro-Ro:         108,797
--─────────────────────
--Subtotal:    2,114,757 ← 

-- En el total general se agregan los buques tanqueros los que mueven líquidos 
--(petróleo, químicos y gas)
--+ Tanker:      906,523
--─────────────────────
--	Total:       3,021,280  ←
--Los buques que mueven mayor carga son:
-- Container:     863,546  ←
-- Tanker:      906,523  ←


-- ====================================================
-- ANÁLISIS 4: Países con mayor movimiento de importación global
-- ====================================================

SELECT pais, ROUND(SUM(importacion),2) as total_movimiento
FROM actividad_portuaria_diaria 
GROUP BY pais
ORDER BY total_movimiento desc
LIMIT 10;

--El país con mayor importación fue China entre 2020 y 2024 con 4,231,062,523.04
--seguido de The Netherlands con 724,266,736.29

SELECT pais, anio, ROUND(SUM(importacion),2) as total_movimiento
FROM actividad_portuaria_diaria 
GROUP BY pais, anio
ORDER BY total_movimiento desc
LIMIT 10;

--China se lleva la posición del primer lugar en todos los años, siendo el 
--2020 con mayor movimiento de importación: 907,825,576.94

--NOTA: 2024 aparece más bajo no porque la economía se contrajo, sino porque el dataset está incompleto para ese año;
--Los datos de 2024 corresponden al período enero-octubre únicamente. 

--TOTAL GLOBAL DE IMPORTACIONES:
SELECT ROUND(SUM(importacion),2) as total_movimiento, anio 
FROM actividad_portuaria_diaria 
GROUP BY anio 
ORDER BY total_movimiento desc;

-- =============================================================
-- ANÁLISIS 5: Países con mayor movimiento de exportación global
-- ==============================================================

SELECT pais, ROUND(SUM(exportacion),2) as total_movimiento
FROM actividad_portuaria_diaria 
GROUP BY pais
ORDER BY total_movimiento desc
LIMIT 10;

--China encabezo las exportaciones totales de los años 2020 a 2024 con un total de:
-- 2,244,160,394.93 ←
--seguido de Brasil con un total de: 694,383,041.09 ←
--Y, en tercer lugar la Federación de Rusia con 686,166,526.85 ←

SELECT pais, anio, ROUND(SUM(exportacion),2) as total_movimiento
FROM actividad_portuaria_diaria 
GROUP BY pais, anio
ORDER BY total_movimiento desc
LIMIT 10;

--Una vez más CHINA encabeza las exportaciones en el año 2021 encabezó el movimiento con un total de:
-- 489,283,482.30 
--En el 2023 La federación de Rusia tuvo un total de: 160,145,522.27

--TOTAL GLOBAL DE EXPORTACIONES:
SELECT ROUND(SUM(exportacion),2) as total_movimiento, anio 
FROM actividad_portuaria_diaria 
GROUP BY anio 
ORDER BY total_movimiento desc;

--El año con mayor movimiento de exportaciones fue el 2021 con:
--1,984,324,573.34 <-

--NOTA: "El dataset cubre 486 puertos seleccionados por el IMF y no representa la totalidad del comercio global. Los totales deben interpretarse como estimaciones."

-- ========================================================================
-- ANÁLISIS 6: Puertos con mayor crecimiento en el periodo de 2020 y 2023
-- ========================================================================

SELECT a.puerto_nombre,
a.total_2020,
b.total_2023,
b.total_2023 - a.total_2020 as crecimiento
FROM
(SELECT puerto_nombre,
ROUND(sum(importacion + exportacion),2) as total_2020
FROM actividad_portuaria_diaria 
WHERE anio = 2020
GROUP BY puerto_nombre) as a
JOIN
(SELECT puerto_nombre, 
ROUND(sum(importacion + exportacion),2) as total_2023
FROM actividad_portuaria_diaria 
WHERE anio = 2023
GROUP BY puerto_nombre) as b
ON a.puerto_nombre = b.puerto_nombre
ORDER BY crecimiento DESC
LIMIT 10;


-- Análisis de 2020 a 2023
SELECT a.puerto_nombre,
a.total_2020,
b.total_2021,
c.total_2022,
d.total_2023,
d.total_2023 - a.total_2020 as crecimiento
FROM
(SELECT puerto_nombre,
ROUND(sum(importacion + exportacion),2) as total_2020
FROM actividad_portuaria_diaria 
WHERE anio = 2020
GROUP BY puerto_nombre) as a
JOIN
(SELECT puerto_nombre,
ROUND(sum(importacion + exportacion),2) as total_2021
FROM actividad_portuaria_diaria 
WHERE anio = 2021
GROUP BY puerto_nombre) as b
ON a.puerto_nombre = b.puerto_nombre 
JOIN
(SELECT puerto_nombre,
ROUND(sum(importacion + exportacion),2) as total_2022
FROM actividad_portuaria_diaria 
WHERE anio = 2022
GROUP BY puerto_nombre) as c
ON b.puerto_nombre = c.puerto_nombre 
JOIN
(SELECT puerto_nombre, 	
ROUND(sum(importacion + exportacion),2) as total_2023
FROM actividad_portuaria_diaria 
WHERE anio = 2023
GROUP BY puerto_nombre) as d
ON c.puerto_nombre = d.puerto_nombre
ORDER BY crecimiento DESC
LIMIT 10;

--Los puertos con mayor crecimiento entre 2020 y 2023 han sido:
--Zhoushan(China):         26,612,314.79
--Xiagong(China):          24,035,889.69
--Laem Chabang(Tailandia): 17,668,230.14
--Santos(Brasil):          14,100,950.07
--─────────────────────

-- ========================================================================
-- ANÁLISIS 7: Puertos con menor crecimiento en el periodo de 2020 y 2023
-- ========================================================================

-- Análisis de 2020 a 2023
SELECT a.puerto_nombre,
a.total_2020,
b.total_2021,
c.total_2022,
d.total_2023,
d.total_2023 - a.total_2020 as crecimiento
FROM
(SELECT puerto_nombre,
ROUND(sum(importacion + exportacion),2) as total_2020
FROM actividad_portuaria_diaria 
WHERE anio = 2020
GROUP BY puerto_nombre) as a
JOIN
(SELECT puerto_nombre,
ROUND(sum(importacion + exportacion),2) as total_2021
FROM actividad_portuaria_diaria 
WHERE anio = 2021
GROUP BY puerto_nombre) as b
ON a.puerto_nombre = b.puerto_nombre 
JOIN
(SELECT puerto_nombre,
ROUND(sum(importacion + exportacion),2) as total_2022
FROM actividad_portuaria_diaria 
WHERE anio = 2022
GROUP BY puerto_nombre) as c
ON b.puerto_nombre = c.puerto_nombre 
JOIN
(SELECT puerto_nombre, 	
ROUND(sum(importacion + exportacion),2) as total_2023
FROM actividad_portuaria_diaria 
WHERE anio = 2023
GROUP BY puerto_nombre) as d
ON c.puerto_nombre = d.puerto_nombre
ORDER BY crecimiento ASC
LIMIT 10;

--Los puertos con menor crecimiento entre 2020 y 2023 han sido:
--Ulsan(Corea del sur):  -31,357,788.37
--Pivdennyi(Ucrania):    -28,140,484.32
--Qinhuangdao(China):    -21,486,354.04
--Singapore:             -20,006,681.20
--─────────────────────

--El puerto de Singapore tuvo una subida en 2020 debido a que → 
--Singapur tuvo volumen artificialmente alto porque absorbió carga desviada de otros puertos congestionados
--Y, en 2023 →  El mundo se normalizó, los puertos se desconestionaron, y esa carga extra regresó a sus rutas originales

-- ========================================================================
-- ANÁLISIS 8: Puertos con mayor movimiento en México
-- ========================================================================

--Puertos con Mayor movimiento en México: 

SELECT pais, puerto_nombre, ROUND(SUM(importacion + exportacion),2) as total_movimiento
FROM actividad_portuaria_diaria 
WHERE pais LIKE '%Mexico%'
GROUP BY pais, puerto_nombre
ORDER BY total_movimiento desc;


--Al analizar los puertos mexicanos presentes en el dataset, encontramos que los
--principales puertos del país — Manzanillo y Lázaro Cárdenas - no están incluidos en
--la muestra del IMF, lo que limita la representatividad del análisis para México. 
--Pero con respecto al data set los principales puertos que más mueven, son:

--- Veracruz:        63,881,975.73
-- Salina Cruz:      16,232,930.31
-- Tuxpan:           14,471,066.07
--────────────────────────────────
-- ========================================================================
-- ANÁLISIS 9: Portcalls vs Volumen
-- ========================================================================
	
SELECT 
ROUND(SUM(importacion + exportacion) /  NULLIF(SUM(portcalls), 0), 2) as Toneladas_por_escalas, puerto_nombre
FROM actividad_portuaria_diaria
GROUP BY puerto_nombre
ORDER BY Toneladas_por_escalas desc
LIMIT 10;	

--Este análisis refleja los puertos que reciben pocos barcos pero con mucha carga, 
--Por ejemplo, los puertos que reciben barcos graneleros o tanqueros, reciben
-- millones de toneladas en una sola escala. Los puertos con mayor carga son:

--Saldanha Bay(Sudáfrica):      59,666.32; se especializa principalmente en exportaciones de carga a granel (Seca y liquida)
--Ras Tanura(Arabia Saudita):   50,623.02; es el mayor centro de exportaciones de petróleo en el mundo.
--Abbot Point(Australia):       49,806.72; Se especializa exclusivamente en la exportación de carbón. 
--Swanport(Australia):          48,970.78; Exportación de minerales. 
--─────────────────────────────────

-- ============================================================
-- FIN DEL ANÁLISIS 
-- ============================================================



