-- ***********************************************************************************
--  Clase de SQL Avanzado: Funciones Agregadas y Cláusulas de Agrupación y Condición
--  En esta lección vamos a conocer temas importantes que nos ayudarán a realizar
--  análisis más completos en SQL. No se preocupen si al principio suenan complicados,
--  iremos paso a paso y lo entenderemos juntas.
--  Hoy vamos a ver dos temas clave:
--  1. Funciones Agregadas: Nos permiten hacer cálculos sobre nuestros datos.
--  2. GROUP BY, HAVING, y CASE: Herramientas para organizar y filtrar nuestros datos
--  de una manera más precisa.
-- ***********************************************************************************

-- ***********************************************************************************
--  Para poder seguir los ejemplos de esta lección, vamos a usar la bbdd_alumnas
-- ***********************************************************************************

-- Asumiendo que tienes una base de datos creada, la seleccionamos para trabajar.
-- Si aún no la tienes, puedes crearla con 'CREATE DATABASE bbdd_alumnas;' y luego usarla.
USE bbdd_alumnas;

-- Crear la tabla 'alumnas' si no existe.
CREATE TABLE IF NOT EXISTS alumnas (
    id_alumna INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    pais VARCHAR(100),
    PRIMARY KEY (id_alumna)
);

-- Insertar los datos en la tabla 'alumnas'.
INSERT INTO alumnas (nombre, apellido, email, telefono, direccion, ciudad, pais) VALUES
('Ana', 'González', 'ana@adalab.es', '654785214', 'Calle Alumna 1', 'Madrid', 'España'),
('Maria', 'López', 'maria@adalab.es', '689656322', 'Calle Alumna 2', 'Barcelona', 'España'),
('Lucía', 'Ramos', 'lucia@adalab.es', '674459123', 'Calle Alumna 3', 'Valencia', 'España'),
('Elena', 'Bueno', 'elena@adalab.es', '628546577', 'Calle Alumna 4', 'Bilbao', 'España'),
('Sara', 'López', 'sara@adalab.es', '673453771', 'Calle Alumna 5', NULL, 'España'),
('Rocío', 'García', 'rocio@adalab.es', '616365624', 'Calle Alumna 6', 'Paris', 'Francia');


-- ***********************************************************************************
--  1. Funciones Agregadas 📊
-- ***********************************************************************************

-- Las funciones agregadas en SQL sirven para realizar cálculos sobre un conjunto de filas 
-- y devolver un único valor como resultado. 
-- Se utilizan comúnmente en consultas de resumen o análisis de datos.

-- ¿Para qué sirven?
-- Resumir y conocer la información: como contar registros, obtener promedios o encontrar valores máximos.

--  Estas funciones, como MIN, MAX, SUM, AVG, y COUNT, te van a permitir
--  descubrir patrones clave en nuestros datos.
--  Estamos realizando cálculos sobre una columna específica en una tabla.
--  Los resultados de estas funciones proporcionan información resumida sobre los valores
--  dentro de esa columna.
--  Estas funciones se aplican a todo el conjunto de datos y generan un único valor
--  que representan esos datos.


-- ***********************************************************************************
--  1.1. MIN y MAX: Valores Mínimos y Máximos 📈📉
-- ***********************************************************************************

--  Con MIN y MAX, podrás identificar el valor más pequeño y más grande en una columna.
--  Estas funciones te devuelven el valor máximo o mínimo en una columna numérica.
--  También se pueden usar con datos alfanuméricos.
--  En ese caso, MIN se queda con el resultado que sería el primero si ordenásemos
--  los registros por orden alfabético (de la A a la Z).
--  MAX sería similar, pero quedándose con el último resultado.

--  Sintaxis:
--  SELECT MIN(columna) FROM tabla;
--  SELECT MAX(columna) FROM tabla;

--  Ejemplos prácticos:


SELECT * FROM alumnas;

--  Ejemplo: Encontrar el ID de alumna más bajo en la tabla 'alumnas'.
SELECT MIN(id_alumna) AS IDMenor 
FROM alumnas;

--  Ejemplo: Encontrar el ID de alumna más alto en la tabla 'alumnas'.
SELECT MAX(id_alumna) AS IDMayor 
FROM alumnas;

--  Ejemplo: Encontrar el nombre de alumna que sería el "primero" alfabéticamente.
SELECT MIN(nombre) AS PrimerNombreAlfabetico 
FROM alumnas;

--  Ejemplo: Encontrar el nombre de alumna que sería el "último" alfabéticamente.
SELECT MAX(nombre) AS UltimoNombreAlfabetico 
FROM alumnas;


--  Ejemplo: Saber el producto más caro y el más barato:

--  Ejemplo: Vamos a usar la bbdd tienda.
USE tienda;

SELECT * FROM products;


SELECT MAX(buy_price) AS producto_mas_caro,
       MIN(buy_price) AS producto_mas_barato
FROM products;


SELECT product_name, buy_price
FROM products
ORDER BY buy_price
LIMIT 1;


-- ***********************************************************************************
--  1.2. SUM: Suma de Valores Numéricos ➕
-- ***********************************************************************************

--  SUM te ayudará a sumar todos los valores numéricos de una columna.
--  Es ideal para calcular totales numéricos, como el total de ventas.

--  Sintaxis:
--  SELECT SUM(columna) FROM tabla;

-- Queremos saber la cantidad total de todos los productos vendidos

SELECT * FROM order_details;

SELECT SUM(quantity_ordered) AS TotalCantidad
FROM order_details;

-- Calcular la suma total pagada por todos los clientes**

SELECT * FROM payments;

SELECT SUM(amount) AS TotalPagado
FROM payments;


-- ***********************************************************************************
--  1.3. AVG: Cálculo de Promedios 📉
-- ***********************************************************************************

--  AVG sirve para calcular el promedio (average) de los valores en una columna.

--  Sintaxis:
--  SELECT AVG(columna) FROM tabla;

--  Obtener el precio medio de los productos**

SELECT * FROM products;

SELECT AVG(buy_price) AS precio_medio
FROM products;


-- ***********************************************************************************
--  1.4. COUNT: Conteo de Registros 🔢
-- ***********************************************************************************

--  Y con COUNT, podrás contar cuántos registros hay en un conjunto de datos.
--  Nos ofrece el número de filas en una columna o conjunto.

--  Sintaxis:
--  SELECT COUNT(columna) FROM tabla;

-- Contar cuántos pedidos hay

SELECT COUNT(*) AS total_pedidos
FROM orders; 

SELECT * FROM orders;

--  Contar el número total de alumnas en la tabla 'alumnas'.
USE bbdd_alumnas;
SELECT COUNT(id_alumna) AS TotalAlumnas FROM alumnas;


-- ***********************************************************************************
--  2. GROUP BY, HAVING, y CASE: Herramientas Avanzadas de Filtrado y Agrupación 🔍
-- ***********************************************************************************

--  En esta lección, vamos a explorar tres herramientas muy útiles que nos permitirán
--  organizar y analizar nuestros datos de manera más avanzada.


-- ***********************************************************************************
--  2.1. GROUP BY: Agrupando Resultados 
-- ***********************************************************************************

--  GROUP BY nos ayuda a agrupar los resultados en base a una o más columnas,
--  para poder aplicar funciones agregadas a cada grupo.
--  Imagina que tenemos muchos datos y queremos agruparlos según una categoría específica,
--  como el país o la ciudad de nuestras alumnas.
--  Al utilizar GROUP BY, podemos agrupar filas en función de valores comunes en
--  una columna y luego realizar cálculos y análisis dentro de esos grupos individuales.
--  Esta segmentación nos permite comprender cómo se distribuyen los datos en función
--  de ciertas características.

--  Sintaxis básica:
--  SELECT columna_agrupada, función_agregación(columna_calculo)
--  FROM tabla
--  GROUP BY columna_agrupada;

--  Donde:
--  - columna_agrupada: Es la columna por la cual deseas agrupar tus datos.
--  - función_agregación: Es una función de agregación como SUM, AVG, MIN, MAX o COUNT.
--  - columna_calculo: Es la columna a la cual aplicarás la función de agregación.

-- Ejemplos:

-- Importe total pagado por cada cliente

SELECT customer_number, SUM(amount) AS TotalPagado
FROM payments
GROUP BY customer_number;

-- Importe mínimo y máximo pagado por cada cliente

SELECT customer_number, 
	   MIN(amount) AS importe_minimo, 
       MAX(amount) AS importe_maximo
FROM payments
GROUP BY customer_number;

-- Média de importe pagado por cada cliente

SELECT customer_number, AVG(amount) AS media_importe
FROM payments
GROUP BY customer_number;

-- Stock total por línea de producto

SELECT product_line, SUM(quantity_in_stock) AS cantidad_total_stock
FROM products
GROUP BY product_line;

-- Cuantas oficinas hay por cada país? 

SELECT country, COUNT(*) AS num_oficinas
FROM offices
GROUP BY country;

-- Clientes con mayor volumen de pagos (TOP 5)

SELECT customer_number, SUM(amount) AS total_pagado
FROM payments
GROUP BY customer_number
ORDER BY total_pagado DESC
LIMIT 5;


-- ***********************************************************************************
--  2.2. HAVING: Filtrando Grupos
-- ***********************************************************************************

--  A veces, después de agrupar los datos, solo nos interesan aquellos grupos que
--  cumplen ciertos criterios. Aquí entra HAVING.
--  Mientras que WHERE nos permite filtrar filas individuales, HAVING nos brinda la
--  capacidad de filtrar grupos generados por la cláusula GROUP BY.
--  La sentencia HAVING funciona como un filtro de grupo, lo que significa que
--  tendremos que usarla con un GROUP BY siempre.
--  Esto nos permite aplicar condiciones a grupos específicos en función de los
--  resultados de las funciones agregadas, como SUM, AVG, COUNT, MIN y MAX.

--  Sintaxis:
--  SELECT columna1, función_agregada(columna2)
--  FROM tabla
--  GROUP BY columna3
--  HAVING condición;

--  Ejemplo práctico:

-- ¿Qué pedidos tienen un total superior a 5.000 €?

-- Paso 1: Calculamos el total por pedido
SELECT order_number, SUM(quantity_ordered * price_each) AS total_pedido
FROM order_details
GROUP BY order_number;

-- Paso 2: Aplicamos la condición con `HAVING`
SELECT order_number, SUM(quantity_ordered * price_each) AS total_pedido
FROM order_details
GROUP BY order_number
HAVING total_pedido > 5000;

-- ¿Qué clientes han hecho más de 3 pedidos?
SELECT customer_number, COUNT(order_number) AS total_pedidos
FROM orders
GROUP BY customer_number
HAVING total_pedidos > 3;

-- ¿Qué productos han sido pedidos más de 1000 veces en total?
SELECT product_code, SUM(quantity_ordered) AS total_unidades
FROM order_details
GROUP BY product_code
HAVING total_unidades > 1000;



/*

| Filtro   | ¿Dónde se aplica?      | ¿Cuándo se usa?             |
| -------- | ---------------------- | --------------------------- |
| `WHERE`  | Antes del `GROUP BY`   | Filtra filas individuales   |
| `HAVING` | Después del `GROUP BY` | Filtra resultados agregados |

*/


-- ***********************************************************************************
--  2.3. CASE: Lógica Condicional Personalizada
-- ***********************************************************************************

--  Esta función te permite crear reglas y condiciones dentro de tus consultas SQL,
--  lo que te da más flexibilidad para clasificar o cambiar los resultados
--  según tus necesidades.
--  La expresión CASE nos permite aplicar lógica condicional dentro de nuestras
--  consultas SQL.
--  Puedes establecer condiciones y definir valores o expresiones a utilizar en
--  función de si esas condiciones se cumplen (similar al 'if' de Python).
--  Con esta expresión vamos a crear temporalmente una nueva columna basada en las
--  condiciones que hayamos establecido (nunca existirá en la tabla de la BBDD).
--  Cada CASE debe tener su END asociado (y de manera opcional su alias).
--  Es importante añadir los operadores ELSE para que SQL sepa cómo actuar cuando
--  no se cumpla ninguna de las condiciones consideradas en los CASE.


-- La sintaxis general de la expresión CASE es la siguiente:

/*
CASE -- Inicia la expresión condicional
    WHEN condicion1 THEN resultado1 -- Define una condición a evaluar (condicion) y el valor (resultado) que se devolverá si 
                                    -- esa condición es verdadera. Puedes tener múltiples cláusulas WHEN
    WHEN condicion2 THEN resultado2
    WHEN condicion3 THEN resultado3
    -- Puedes añadir más cláusulas WHEN...THEN
    ELSE resultado_por_defecto -- La cláusula ELSE es opcional, pero se recomienda
                               -- Especifica el valor que se devolverá si ninguna de las condiciones WHEN anteriores se cumple
                               -- Es importante para cubrir todos los casos
END AS nombre_alias_columna_temporal;-- Marca el final de la expresión CASE. Es un operador obligatorio y puedes añadir un alias

-- AS nombre_alias_columna_temporal: Permite asignar un alias a la nueva columna que CASE crea temporalmente en los resultados de la consulta.
-- Sin ELSE, si ninguna condición se cumple, CASE devolverá NULL
*/


-- Ejemplo 1:
-- ¿Cómo podemos clasificar los productos según su precio? Queremos saber si un producto es barato, medio o caro.

SELECT product_name,
       buy_price,
       CASE
         WHEN buy_price < 50 THEN 'Barato'
         WHEN buy_price BETWEEN 50 AND 100 THEN 'Medio'
         ELSE 'Caro'
       END AS rango_precio
FROM products
LIMIT 10;

-- Aquí el `CASE` evalúa `buy_price` y devuelve una **etiqueta categórica** según el rango.


-- Ejemplo 2:
-- ¿Podemos mostrar si un cliente tiene o no límite de crédito? Queremos mostrar “Sí” si tiene `credit_limit`, o “No” si es cero.

SELECT customer_name,
       credit_limit,
       CASE
         WHEN credit_limit = 0 THEN 'No'
         ELSE 'Sí'
       END AS tiene_credito
FROM customers;

-- Es útil para reemplazar valores numéricos con texto más legible.


-- Ejemplo 3:
-- ¿Qué etiqueta le pondríamos a la cantidad de stock de cada producto? Queremos indicar si el stock es bajo, medio o alto.

SELECT product_name,
       quantity_in_stock,
       CASE
         WHEN quantity_in_stock < 1000 THEN 'Bajo'
         WHEN quantity_in_stock BETWEEN 1000 AND 5000 THEN 'Medio'
         ELSE 'Alto'
       END AS nivel_stock
FROM products;



-- Ayuda a hacer reportes legibles.


-- Ejemplo 5:
-- ¿Podemos mostrar una etiqueta con el territorio de una oficina con más contexto?

SELECT territory,
       COUNT(office_code) AS conteo_officinas,
       CASE territory
         WHEN 'NA' THEN 'Norteamérica'
         WHEN 'EMEA' THEN 'Europa / África / Oriente Medio'
         WHEN 'APAC' THEN 'Asia Pacífico'
         ELSE 'Otro'
       END AS region_expandida
FROM offices
GROUP BY territory;



-- ***********************************************************************************
--  8.3. Resumen y Conclusión 🌟
-- ***********************************************************************************

--  En esta lección hemos explorado dos temas fundamentales en SQL que son esenciales
--  para el análisis de datos.

--  1. Funciones Agregadas:
--     - MIN: Encuentra el valor más bajo en una columna.
--     - MAX: Identifica el valor más alto en una columna.
--     - SUM: Suma todos los valores numéricos de una columna, ideal para calcular totales.
--     - AVG: Calcula el promedio de los valores en una columna.
--     - COUNT: Cuenta el número de registros en un conjunto de datos, útil para determinar ocurrencias.
--     Estas funciones nos permiten resumir y entender mejor la distribución de
--     nuestros datos, identificando patrones clave y estadísticas esenciales.

--  2. GROUP BY, HAVING, y CASE:
--     - GROUP BY: Agrupa filas que comparten valores en una o más columnas,
--       facilitando análisis por categorías.
--     - HAVING: Filtra los grupos resultantes de GROUP BY, permitiendo
--       condiciones en las estadísticas calculadas.
--     - CASE: Aplica lógica condicional en nuestras consultas, permitiendo crear
--       columnas nuevas basadas en condiciones específicas.
--     Estos conceptos amplían nuestra capacidad para realizar análisis más
--     complejos y personalizados, enriqueciendo nuestros informes.







