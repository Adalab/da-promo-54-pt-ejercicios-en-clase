-- ***********************************************************************************
-- Clase de SQL: Joins Avanzados
-- Hoy continuaremos profundizando en cómo combinar y extraer información valiosa de múltiples tablas.
-- En esta sesión, nos enfocaremos en los tipos de JOINs que nos permiten obtener
-- vistas más completas y útiles de nuestros datos, incluso cuando hay ausencias.
-- Aprenderemos sobre:
-- 1. LEFT JOIN y RIGHT JOIN 
-- 2. FULL JOIN 
-- 3. SELF JOIN
-- ***********************************************************************************

-- Antes de empezar, asegúrense de que tienen seleccionada la base de datos 'tienda'.
-- Pueden hacerlo ejecutando:
USE tienda;

-- ***********************************************************************************
-- 1. LEFT JOIN 👈 y RIGHT JOIN 👉
-- ***********************************************************************************

-- El LEFT JOIN (también conocido como LEFT OUTER JOIN) es una operación de unión
-- que devuelve todas las filas de la tabla de la izquierda y las filas coincidentes de la tabla de la derecha.
-- Si no hay una coincidencia para una fila de la tabla de la izquierda en la tabla de la derecha,
-- las columnas de la tabla de la derecha mostrarán valores NULL para esa fila.
-- Es útil cuando queremos ver todos los registros de una tabla principal, incluso si no tienen datos relacionados en otra tabla.

-- Sintaxis general para LEFT JOIN:
-- SELECT tabla1.columna1, tabla1.columna2, tabla2.columna1, ....
-- FROM tabla1
-- LEFT JOIN tabla2 ON tabla1.columna_comun = tabla2.columna_comun;

-- Ejemplo 1 de LEFT JOIN con la base de datos 'tienda':
-- Queremos ver a todos los clientes y los detalles de sus pedidos,
-- incluyendo aquellos clientes que quizás aún no han realizado ningún pedido.


SELECT
    c.customer_number,      -- Número del cliente
    c.customer_name,        -- Nombre del cliente
    o.order_number,         -- Número de pedido
    o.status                -- Estado del pedido
FROM
    customers AS c          -- Tabla izquierda (clientes) con alias 'c'
LEFT JOIN
    orders AS o             -- Tabla derecha (pedidos) con alias 'o'
ON
    c.customer_number = o.customer_number; -- Condición de unión basada en el número de cliente
-- WHERE order_number IS NULL;


-- Ejemplo 2 de LEFT JOIN:
-- Queremos ver todos los productos y, si han sido pedidos, los detalles de la cantidad y precio por unidad.
-- Esto nos permitirá identificar productos que no han sido vendidos aún.

SELECT
    p.product_code,         -- Código del producto
    p.product_name,         -- Nombre del producto
    od.quantity_ordered,    -- Cantidad pedida
    od.price_each           -- Precio unitario en el pedido
FROM
    products AS p           -- Tabla izquierda (productos) con alias 'p'
LEFT JOIN
    order_details AS od     -- Tabla derecha (detalles de pedidos) con alias 'od'
ON
    p.product_code = od.product_code; -- Condición de unión basada en el código de producto
-- WHERE quantity_ordered IS NULL;



-- El RIGHT JOIN (también conocido como RIGHT OUTER JOIN) es el opuesto del LEFT JOIN.
-- Devuelve todas las filas de la tabla de la derecha y las filas coincidentes de la tabla de la izquierda.
-- Si no hay una coincidencia para una fila de la tabla de la derecha en la tabla de la izquierda,
-- las columnas de la tabla de la izquierda mostrarán valores NULL para esa fila.
-- Es útil cuando queremos asegurar que todos los registros de la tabla derecha estén presentes en el resultado.

-- Sintaxis general para RIGHT JOIN:
-- SELECT tabla1.columna1, tabla1.columna2, tabla2.columna1, ....
-- FROM tabla1
-- RIGHT JOIN tabla2 ON tabla1.columna_comun = tabla2.columna_comun;

-- Ejemplo 3 de RIGHT JOIN con la base de datos 'tienda':
-- Queremos listar todos los empleados y los detalles de las oficinas,
-- asegurando que todas las oficinas sean mostradas, incluso si no tienen empleados asignados (hipotéticamente).

SELECT
    e.first_name,           -- Nombre del empleado
    e.last_name,            -- Apellido del empleado
    o.office_code,          -- Código de oficina
    o.city,                 -- Ciudad de la oficina
    o.country               -- País de la oficina
FROM
    employees AS e          -- Tabla izquierda (empleados) con alias 'e'
RIGHT JOIN
    offices AS o            -- Tabla derecha (oficinas) con alias 'o'
ON
    e.office_code = o.office_code; -- Condición de unión basada en el código de oficina


-- Ejemplo 4 de RIGHT JOIN:
-- Queremos ver todas las líneas de productos y los productos que pertenecen a cada una,
-- asegurándonos de que todas las líneas de productos sean mostradas, incluso si no tienen productos asociados.

SELECT
    pl.product_line,            -- Nombre de la línea de producto
    pl.text_description,        -- Descripción de la línea de producto
    p.product_name              -- Nombre del producto
FROM
    products AS p               -- Tabla izquierda (productos) con alias 'p'
RIGHT JOIN
    product_lines AS pl         -- Tabla derecha (líneas de productos) con alias 'pl'
ON
    p.product_line = pl.product_line; -- Condición de unión basada en la línea de producto

  


-- ***********************************************************************************
-- 2. FULL JOIN (Simulación en MySQL) 🔄
-- ***********************************************************************************

-- El FULL JOIN (o FULL OUTER JOIN) combina todos los registros de ambas tablas.
-- Muestra todas las filas, tanto de la tabla de la izquierda como de la derecha,
-- incluso si no hay coincidencias entre ellas.
-- Si no hay datos coincidentes en una tabla, esas columnas aparecerán como NULL.
-- En MySQL, no existe un comando FULL (OUTER) JOIN directo. Sin embargo,
-- podemos simularlo combinando un LEFT JOIN y un RIGHT JOIN utilizando la cláusula UNION.
-- UNION se utiliza para combinar los conjuntos de resultados de dos o más sentencias SELECT.
-- Por defecto, UNION elimina filas duplicadas.


-- Sintaxis general para simular FULL JOIN en MySQL:

-- SELECT tabla1.columna1, tabla1.columna2, tabla2.columna1, ...
-- FROM tabla1 LEFT JOIN tabla2 ON tabla1.columna_comun = tabla2.columna_comun
-- UNION
-- SELECT tabla1.columna1, tabla1.columna2, tabla2.columna1, ...
-- FROM tabla1 RIGHT JOIN tabla2 ON tabla1.columna_comun = tabla2.columna_comun;

-- Ejemplo 5 de simulación de FULL JOIN:
-- Queremos ver todos los clientes y todos sus pedidos,
-- incluyendo clientes sin pedidos y pedidos (hipotéticamente) sin clientes asociados.


SELECT
    c.customer_number,      -- Número del cliente
    c.customer_name,        -- Nombre del cliente
    o.order_number,         -- Número de pedido
    o.order_date,           -- Fecha del pedido
    o.status                -- Estado del pedido
FROM
    customers AS c
LEFT JOIN
    orders AS o
ON
    c.customer_number = o.customer_number
    
UNION

SELECT
    c.customer_number,      -- Número del cliente
    c.customer_name,        -- Nombre del cliente
    o.order_number,         -- Número de pedido
    o.order_date,           -- Fecha del pedido
    o.status                -- Estado del pedido
FROM
    customers AS c
RIGHT JOIN
    orders AS o
ON
    c.customer_number = o.customer_number;


-- Ejemplo 6 de simulación de FULL JOIN:
-- Queremos ver todos los empleados y todas las oficinas,
-- incluyendo empleados sin oficina (si los hubiera) y oficinas sin empleados (si las hubiera).

SELECT
    e.employee_number,      -- Número de empleado
    e.first_name,           -- Nombre del empleado
    e.last_name,            -- Apellido del empleado
    o.office_code,          -- Código de oficina
    o.city,                 -- Ciudad de la oficina
    o.country               -- País de la oficina
FROM
    employees AS e
LEFT JOIN
    offices AS o
ON
    e.office_code = o.office_code
UNION
SELECT
    e.employee_number,      -- Número de empleado
    e.first_name,           -- Nombre del empleado
    e.last_name,            -- Apellido del empleado
    o.office_code,          -- Código de oficina
    o.city,                 -- Ciudad de la oficina
    o.country               -- País de la oficina
FROM
    employees AS e
RIGHT JOIN
    offices AS o
ON
    e.office_code = o.office_code;


-- ***********************************************************************************
-- 3. SELF JOIN 👯‍♀️
-- ***********************************************************************************

-- Un SELF JOIN es un tipo especial de unión que se utiliza para unir una tabla consigo misma.
-- Esto es útil cuando queremos comparar filas dentro de la misma tabla o cuando una tabla
-- tiene relaciones jerárquicas, como empleados y sus supervisores.
-- Al usar SELF JOIN, necesitamos usar alias para las dos instancias de la misma tabla
-- para diferenciarlas y evitar ambigüedades en las columnas.

-- Sintaxis general para SELF JOIN:
-- SELECT
--     t1.columna_a,           -- Columna de la primera instancia de la tabla
--     t2.columna_b            -- Columna de la segunda instancia de la tabla
-- FROM
--     tabla AS t1             -- Primera instancia de la tabla con alias t1
-- JOIN
--     tabla AS t2             -- Segunda instancia de la tabla con alias t2
-- ON
--     t1.columna_comun = t2.columna_relacionada; -- Condición de unión


-- Ejemplo 7 de SELF JOIN:
-- Queremos ver la relación jerárquica entre los empleados y sus gerentes.
-- La tabla 'employees' tiene una columna 'reports_to' que hace referencia a 'employee_number'
-- en la misma tabla, indicando quién es el gerente de un empleado.

SELECT e.first_name, e.last_name, m.first_name, m.last_name
FROM employees AS e
JOIN employees AS m
ON e.reports_to = m.employee_number
WHERE m.reports_to IS NOT NULL;


-- Ejemplo 8 de SELF JOIN:
-- Queremos encontrar pares de empleados que trabajan en la misma oficina
-- pero que no son la misma persona.

SELECT
    e1.first_name AS employee1_first_name, -- Primer empleado de la pareja
    e1.last_name AS employee1_last_name,   -- Apellido del primer empleado
    e2.first_name AS employee2_first_name, -- Segundo empleado de la pareja
    e2.last_name AS employee2_last_name,   -- Apellido del segundo empleado
    e1.office_code                         -- Código de oficina compartida
FROM
    employees AS e1
JOIN
    employees AS e2
ON
    e1.office_code = e2.office_code
WHERE
    e1.employee_number <> e2.employee_number; -- Asegurar que no sean el mismo empleado


-- ***********************************************************************************
-- Hoy hemos explorado cómo LEFT JOIN, RIGHT JOIN, la simulación de FULL JOIN y SELF JOIN
-- nos permiten combinar y analizar datos de maneras complejas y potentes.
-- Puntos clave para recordar:
-- - LEFT JOIN: Todas las filas de la izquierda, y las coincidencias de la derecha (NULL si no hay).
-- - RIGHT JOIN: Todas las filas de la derecha, y las coincidencias de la izquierda (NULL si no hay).
-- - FULL JOIN (Simulación): Unión de un LEFT JOIN y un RIGHT JOIN para obtener todas las filas de ambos lados.
-- - SELF JOIN: Unir una tabla consigo misma para comparar filas internas (¡recuerden los alias!).
-- La práctica es esencial para dominar estos conceptos.
-- ¡Sigan explorando y experimentando con sus datos! 💪💻
-- ***********************************************************************************












