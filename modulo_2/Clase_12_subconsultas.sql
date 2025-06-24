-- ***********************************************************************************
--  SQL Subconsultas y Subconsultas Correlacionadas 🚀
--  Hoy nos enfocaremos en una de las herramientas más potentes y versátiles en SQL: las subconsultas.
--  Aprenderemos cómo estas "preguntas dentro de preguntas" nos permiten extraer información más detallada
--  y realizar comparaciones complejas en nuestra base de datos.
-- ***********************************************************************************

-- ***********************************************************************************
--  1. Subconsultas
-- ***********************************************************************************

-- Una subconsulta es, básicamente, una consulta que se ejecuta dentro de otra consulta.
-- Imagina que estás haciendo una gran pregunta (consulta principal) y dentro de esa pregunta,
-- haces otra más pequeña (subconsulta) para obtener una respuesta que te ayude.
-- Se usan cuando necesitamos datos adicionales de otra tabla o resultado para completar nuestra consulta principal.

-- Dónde usar subconsultas:
-- Principalmente, las empleamos en las cláusulas WHERE y HAVING.
-- Nos centraremos en las subconsultas utilizadas en la cláusula WHERE,
-- donde los datos que deseamos ver están en una tabla, pero para seleccionar
-- las filas de esa tabla, necesitamos información que reside en otra tabla.


-- Sintaxis general de una subconsulta en WHERE:
-- SELECT columna1, columna2
-- FROM tabla_principal
-- WHERE columna_filtro OPERADOR (SELECT columna_subconsulta FROM tabla_secundaria WHERE condicion);

-- ***********************************************************************************
--  1.1 Operador IN en Subconsultas
-- ***********************************************************************************

-- El operador IN se utiliza para seleccionar valores que coinciden con lo que devuelve la subconsulta.
-- Nos permite seleccionar registros de la consulta principal cuando algún atributo de la tabla principal
-- coincide con uno o más valores dentro de un conjunto de valores devueltos por la subconsulta.
-- En otras palabras, la subconsulta en este contexto devuelve un conjunto de registros
-- y cada uno de estos registros se utiliza para verificar la condición establecida en la consulta principal.

-- En la BBDD tienda, quiero ver los empleados que son de Boston
USE tienda;

SELECT office_code
FROM offices
WHERE city = 'Boston'; -- Desde la tabla offices, puedo filtrar por ciudad

/*
SELECT nombre_empleado
FROM employees
WHERE office_code = al código de Boston
*/

SELECT first_name, last_name, office_code
FROM employees
WHERE office_code IN (SELECT office_code FROM offices WHERE city = 'Boston');

-- Ejemplo: Listar los nombres de los empleados que trabajan en oficinas ubicadas en 'USA'.
-- La subconsulta obtiene los `office_code` de las oficinas en 'USA'.
-- La consulta principal luego filtra los empleados que están asociados a esos códigos de oficina.

SELECT first_name, last_name, office_code
FROM employees
WHERE office_code IN (SELECT office_code FROM offices WHERE country = 'USA');


-- Ejemplo: Obtener el nombre y límite de crédito de los clientes que han realizado al menos un pago.
-- Aquí, la subconsulta encuentra todos los números de cliente que tienen un registro en la tabla `payments`.
-- Luego, la consulta principal usa esos números para filtrar los clientes en la tabla `customers`.

SELECT customer_name, credit_limit
FROM customers
WHERE customer_number IN (SELECT DISTINCT customer_number FROM payments);


-- Ejemplo: Encontrar los nombres de los productos que se han incluido en algún pedido con un precio por unidad mayor a 100.
-- La subconsulta primero identifica los códigos de producto de los `order_details` que cumplen la condición de precio.
-- Luego, la consulta principal selecciona los nombres de esos productos de la tabla `products`.

SELECT product_name, product_code
FROM products
WHERE product_code IN (SELECT DISTINCT product_code FROM order_details WHERE price_each > 100);



-- ***********************************************************************************
--  1.2 Operador NOT IN en Subconsultas
-- ***********************************************************************************

-- El operador NOT IN se utiliza para seleccionar los que no coinciden.
-- Se utiliza para recuperar registros de la consulta principal para los cuales no existe
-- ningún registro en la subconsulta que tenga un valor coincidente.
-- Este operador nos permite identificar registros que no tienen un equivalente en la subconsulta.


-- Ejemplo: Obtener el nombre y país de los clientes que NO han realizado ningún pedido.
-- La subconsulta encuentra todos los números de cliente que tienen un registro en la tabla `orders`.
-- Luego, la consulta principal usa esos números para excluir a esos clientes de la tabla `customers`.

SELECT customer_name, country
FROM customers
WHERE customer_number NOT IN (SELECT DISTINCT customer_number FROM orders);


-- Ejemplo: Listar los productos que NO han sido incluidos en ningún detalle de pedido (es decir, nunca han sido pedidos).
-- La subconsulta obtiene todos los `product_code` que aparecen en la tabla `order_details`.
-- La consulta principal excluye esos productos, mostrando solo los que no están en la lista.

SELECT product_name
FROM products
WHERE product_code NOT IN (SELECT DISTINCT product_code FROM order_details);

-- Ejemplo: Encontrar los empleados que NO son "Sales Reps".
-- Aunque se podría hacer directamente, para fines de demostración, asumamos que
-- 'Sales Rep' es una categoría compleja derivada de otra tabla (aquí simulada).
-- La subconsulta encuentra los `employee_number` de todos los empleados que son 'Sales Rep'.
-- La consulta principal excluye a esos empleados.

SELECT
    first_name,
    last_name,
    job_title
FROM
    employees
WHERE
    employee_number NOT IN (SELECT employee_number 
						    FROM employees 
                            WHERE job_title = 'Sales Rep');


-- ***********************************************************************************
--  2. Subconsultas Correlacionadas 📝
-- ***********************************************************************************

-- En una subconsulta normal, la subconsulta se ejecuta una vez y le da sus resultados a la consulta principal.
-- Pero en una subconsulta correlacionada, la subconsulta depende de cada fila de la consulta principal.
-- Es decir, la subconsulta se ejecuta una vez por cada fila de la consulta principal.
-- Es como si la consulta principal y la subconsulta estuvieran teniendo una conversación constante.
-- La subconsulta correlacionada no puede evaluarse de manera independiente, ya que depende de los valores
-- de la consulta principal para evaluar sus condiciones.

-- Para visualizarlo, puedes imaginarlo como un bucle (loop) en programación: la consulta principal 
-- es el bucle externo que itera sobre cada fila, y para cada iteración, el valor de esa fila se usa en la subconsulta.

-- Este tipo de subconsultas es útil cuando necesitas comparar datos dentro de un grupo específico o contexto.
-- Por ejemplo, comparar salarios dentro de un país, departamento o equipo.
-- Es fundamental comprender que cuando se ejecuta una consulta que contiene una subconsulta correlacionada,
-- esta subconsulta se ejecuta para cada fila de la consulta principal.
-- Esto puede tener un impacto significativo en el tiempo total de ejecución de la consulta,
-- especialmente en bases de datos y tablas muy grandes.

-- hay situaciones donde las subconsultas correlacionadas son la forma más natural o incluso la única forma directa 
-- de expresar una lógica compleja. Por ejemplo, cuando necesitas comparar cada fila con un agregado de un subconjunto 
-- *dependiente* de esa fila (como "encontrar empleados que ganan más que el promedio de su propio departamento"). 
-- Sin embargo, siempre se debe evaluar si la misma lógica se puede lograr con:
-- `JOIN` + `GROUP BY`: A menudo es una alternativa más eficiente para problemas que involucran agregaciones en grupos.

-- Sintaxis general de una subconsulta correlacionada:
-- SELECT columna1, columna2
-- FROM tabla_principal AS alias_principal
-- WHERE condicion_principal OPERADOR (SELECT columna_subconsulta 
--                                     FROM tabla_secundaria AS alias_secundario 
--                                     WHERE alias_secundario.columna = alias_principal.columna);


SELECT AVG(buy_price) 
FROM products
WHERE product_line = 'Classic Cars'; -- 64

SELECT AVG(buy_price) 
FROM products
WHERE product_line = 'Motorcycles'; -- 50

SELECT * 
FROM products AS p1
WHERE buy_price > (SELECT AVG(buy_price)
				   FROM products AS p2
                   WHERE p2.product_line = p1.product_line);


-- ***********************************************************************************
--  2.1 Operador ANY en Subconsultas
-- ***********************************************************************************

-- Con el operador ANY seleccionamos registros basados en múltiples comparaciones.
-- Permite recuperar registros de una consulta principal cuando satisfacen una condición establecida
-- para al menos uno de los valores especificados. La condición debe ser verdadera para al menos un valor.

/*
🎯 IDEA PRINCIPAL:

* `ANY` = al menos uno cumple la condición.

📊 Ejemplo simple: películas y sus duraciones

Supón que tienes esta tabla `peliculas`:

| id | título     | duracion | clasificacion |
| -- | ---------- | -------- | ------------- |
| 1  | Toy Story  | 80       | PG            |
| 2  | Nemo       | 90       | PG            |
| 3  | Matrix     | 130      | R             |
| 4  | El Padrino | 175      | R             |
| 5  | Titanic    | 195      | PG-13         |


🧪 Consulta con `ANY`

> Quiero ver las películas cuya duración es mayor que al menos una de las películas PG.

SELECT titulo, duracion
FROM peliculas
WHERE duracion > ANY (
    SELECT duracion
    FROM peliculas
    WHERE clasificacion = 'PG'
);


✅ Traducción humana:

> Dame las películas que duran más que 80 o 90 (las duraciones de películas PG).

✔ Coincidirán: Matrix (130), El Padrino (175), Titanic (195), Nemo (90)
✖ No coincidirán: Toy Story (80)

> Si la clasificacion fuera R, entonces solo entrarían Padrino y Titanic.
*/


-- Ejemplo: Listar los clientes cuyo `credit_limit` es mayor que el `credit_limit` de AL MENOS otro cliente en su MISMO país.
-- Esto excluiría al cliente con el límite de crédito más bajo en cada país, si es que hay más de uno.

SELECT
    customer_name,
    country,
    credit_limit
FROM
    customers AS C1
WHERE
    C1.credit_limit > ANY (
        SELECT C2.credit_limit
        FROM customers AS C2
        WHERE C2.country = C1.country AND C2.customer_number <> C1.customer_number
    );


-- Lo mismo usando un SELF JOIN
SELECT DISTINCT C1.customer_name, C1.country, C1.credit_limit
FROM customers C1
JOIN customers C2
  ON C1.country = C2.country
  AND C1.customer_number <> C2.customer_number
  AND C1.credit_limit > C2.credit_limit;


-- ***********************************************************************************
--  2.2 Operador ALL en Subconsultas Correlacionadas
-- ***********************************************************************************

-- El operador ALL funciona de manera similar al operador ANY, pero con una diferencia clave:
-- la condición debe cumplirse para TODOS los registros dentro de la cláusula ALL.

/*
⚠️ Clave para entender ALL:
El operador se aplica a cada valor del subconjunto y debe cumplirse con todos.

Por ejemplo: x > ALL(5, 8, 10) → x debe ser mayor que 10 (el mayor valor).
             x < ALL(5, 8, 10) → x debe ser menor que 5 (el menor valor).


🎯 IDEA PRINCIPAL:

* `ALL` = **todos deben cumplir** la condición.

📊 Ejemplo simple: películas y sus duraciones

Supón que tienes esta tabla `peliculas`:

| id | título     | duracion | clasificacion |
| -- | ---------- | -------- | ------------- |
| 1  | Toy Story  | 80       | PG            |
| 2  | Nemo       | 90       | PG            |
| 3  | Matrix     | 130      | R             |
| 4  | El Padrino | 175      | R             |
| 5  | Titanic    | 195      | PG-13         |

---

🧪 Consulta con `ALL`

> Quiero ver las películas cuya duración es mayor que todas las películas PG.


SELECT titulo, duracion
FROM peliculas
WHERE duracion > ALL (
    SELECT duracion
    FROM peliculas
    WHERE clasificacion = 'PG'
);


✅ Traducción humana:

> Dame las películas que duran más que todas las películas PG (es decir, más que 90, que es la mayor de ellas).

✔ Coincidirán: El Padrino (175), Titanic (195),  Matrix (130)
✖ No coincidirán: Toy Story (80), Nemo (90)

---
*/

-- Ejemplo: Listar los clientes cuyo `credit_limit` es mayor o igual que el `credit_limit` de TODOS los demás clientes en su MISMO país.
-- Esto identificará el cliente con el límite de crédito más alto (o uno de los más altos) en cada país.

SELECT
    customer_name,
    country,
    credit_limit
FROM
    customers AS C1
WHERE
    C1.credit_limit >= ALL (
        SELECT C2.credit_limit
        FROM customers AS C2
        WHERE C2.country = C1.country AND C2.customer_number <> C1.customer_number
    );


-- ***********************************************************************************
--  2.3 Operador EXISTS en Subconsultas Correlacionadas
-- ***********************************************************************************

-- El operador EXISTS se utiliza para determinar si los resultados de una subconsulta son verdaderos o falsos.
-- Nos indica si la subconsulta ha devuelto algún registro o si, por el contrario, está vacía.
-- EXISTS es útil para determinar si una subconsulta devuelve algún resultado válido y puede ser una
-- herramienta poderosa para filtrar datos en función de esta condición de existencia.

/*
`EXISTS` comprueba si una subconsulta devuelve algún resultado.

* Devuelve `TRUE` si la subconsulta tiene al menos una fila.
* Devuelve `FALSE` si la subconsulta no tiene filas.

🔎 Es útil cuando no necesitas los valores de la subconsulta, sino simplemente saber si existe una relación o condición cumplida.

---

## 📦 Ejemplo simple con la base de datos `tienda`

Supongamos estas dos tablas:

`clientes`

| id\_cliente | nombre |
| ----------- | ------ |
| 1           | Ana    |
| 2           | Marta  |
| 3           | Lucía  |
| 4           | Raúl   |

`pedidos`

| id\_pedido | id\_cliente | producto |
| ---------- | ----------- | -------- |
| 101        | 1           | Camiseta |
| 102        | 3           | Sudadera |
| 103        | 1           | Gorro    |

---

🎯 Objetivo:

> Mostrar solo los clientes que han hecho al menos un pedido.

SELECT nombre
FROM clientes c
WHERE EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.id_cliente = c.id_cliente
);


🔍 Explicación:

* El `EXISTS` comprueba para cada cliente si existe algún pedido con su `id_cliente`.
* Si existe al menos uno, incluye ese cliente en el resultado.

👀 Resultado:

| nombre |
| ------ |
| Ana    |
| Lucía  |

(Raúl y Marta no tienen pedidos → no aparecen)

---

🛑 Importante:

* `SELECT 1` dentro del `EXISTS` no importa lo que devuelve; lo relevante es que devuelva algo.
Cuando usamos EXISTS, no importa qué seleccionamos dentro del subquery. Solo importa si el subquery devuelve al menos una fila.
SELECT 1, SELECT *, SELECT nombre, etc. → son equivalentes en este contexto.
Se suele usar SELECT 1 por convención, para indicar que el contenido no importa, solo la existencia.

* Es más eficiente que `IN` cuando hay muchas filas.

---

## 📌 ¿Cuándo usar `EXISTS`?

Usa `EXISTS` cuando:

* Solo necesitas verificar la existencia de algo.
* Trabajas con grandes volúmenes de datos y quieres mejorar rendimiento.
* Necesitas condiciones basadas en relaciones entre tablas.
*/


-- Ejemplo: Seleccionar los clientes que tienen al menos un pedido con el estado 'Disputed'.
-- La consulta principal itera sobre cada cliente (C1).
-- La subconsulta verifica si existe algún pedido (O1) para ese cliente (C1) con el estado 'Disputed'.
-- Si la subconsulta devuelve al menos una fila (es decir, existe tal pedido), la condición `WHERE EXISTS` es verdadera.

SELECT
    customer_name,
    customer_number
FROM
    customers AS C1
WHERE EXISTS (
    SELECT 1
    FROM orders AS O1
    WHERE O1.customer_number = C1.customer_number AND O1.status = 'Disputed'
);





