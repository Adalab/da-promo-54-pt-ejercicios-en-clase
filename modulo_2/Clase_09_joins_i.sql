-- ***********************************************************************************
--  Uniendo Tablas en SQL (Joins I) 🌟
--  Hoy nos enfocaremos en un tema esencial en el análisis de datos: las JOINs.
--  Imaginemos que tenemos información distribuida en varias tablas de nuestra base
--  de datos 'tienda', como la lista de nuestros clientes y los pedidos que han
--  realizado.
--  ¿Cómo combinamos esta información para obtener una vista completa y útil?
--  Aquí es donde las JOINs nos asisten, permitiéndonos consolidar datos de
--  diferentes tablas para obtener una vista completa y útil.
--  En esta sesión, exploraremos 3 tipos fundamentales de JOINs:
--  1. Cross Join
--  2. Natural Join
--  3. Inner Join
--  Cada una tiene un propósito distinto y comprenderlas nos permitirá manipular
--  los datos para extraer exactamente lo que necesitamos.
-- ***********************************************************************************


-- ***********************************************************************************
--  1. Cross Join ✨
-- ***********************************************************************************
-- Un Cross Join, también conocido como producto cartesiano, combina cada fila de
-- una tabla con cada fila de otra tabla. Es como si cada persona en una
-- fiesta hablara con todas las demás.
-- A diferencia de otros tipos de JOINs, el Cross Join no necesita que las filas
-- de las tablas coincidan en alguna columna.
-- Esto puede generar una gran cantidad de resultados. Por ejemplo, si una
-- tabla tiene 100 filas y la otra 200, obtendrás 20,000 combinaciones.
-- Por ello, debe usarse con precaución.
-- A menudo, necesitaremos añadir una condición con la cláusula WHERE para
-- filtrar solo las combinaciones que nos interesan y que tengan sentido
-- para el análisis.

-- Sintaxis básica:
-- SELECT columna1, columna2, ...
-- FROM tabla1
-- CROSS JOIN tabla2;

/*
Casos de uso comunes : Aunque el Cross Join crea todas las combinaciones posibles, 
rara vez se usa directamente sin una cláusula WHERE en un entorno de producción. 
Su uso principal suele ser para generar conjuntos de datos de prueba, simular todas las posibles relaciones entre dos entidades o, 
servir como base para otras operaciones. 
También puede ser útil para calcular todas las combinaciones posibles de ítems.

Implicaciones de rendimiento: Es crucial reiterar y quizás expandir la advertencia sobre el gran número de resultados. 
Un Cross Join es computacionalmente costoso si las tablas son grandes, ya que el número de filas en el resultado 
es el producto del número de filas de cada tabla. Esto puede llevar a problemas de rendimiento severos y un consumo 
excesivo de memoria si no se maneja con cuidado.
*/


-- Ejemplo 1: Combinar cada línea de producto con cada producto disponible.
-- Esto creará todas las combinaciones posibles, incluso si el producto no
-- pertenece realmente a esa línea de producto.
-- Fijaros que tenemos 7 filas para las categorias y 110 para los productos. 
-- El resultado del CROSS JOIN debería devolvernos 770 filas.

SELECT pl.product_line, p.product_name
FROM product_lines AS pl
CROSS JOIN products AS p;



-- Ejemplo 2: Un Cross Join para mostrar todas las posibles asignaciones
-- de un empleado a una oficina, sin importar si realmente trabajan allí.
-- Esto es útil para generar listas exhaustivas de posibilidades.

SELECT e.first_name, e.last_name, o.city, o.country
FROM employees e
CROSS JOIN offices o;


-- Ejemplo 3 con WHERE para filtrar resultados relevantes
-- Se puede usar WHERE para filtrar combinaciones y obtener solo aquellas que realmente tienen una relación.
-- Aquí, estamos combinando productos y líneas de productos, y luego filtrando
-- para mostrar solo las combinaciones donde el 'product_line' de ambas tablas coincide. 
-- Esto es lo que haría un Inner Join si las columnas tuvieran el mismo nombre.

SELECT pl.product_line, p.product_name
FROM product_lines AS pl
CROSS JOIN products AS p
WHERE pl.product_line = p.product_line;



-- ***********************************************************************************
--  2. Natural Join
-- ***********************************************************************************
-- El Natural Join es una operación muy intuitiva. Busca automáticamente
-- columnas con el mismo nombre y tipo de dato en ambas tablas y las usa para combinar los datos.
-- Si ambas tablas tienen una columna llamada, por ejemplo, 'customer_number', el
-- Natural Join las combinará basándose en esa columna.
-- Este tipo de join es muy cómodo cuando las tablas están bien diseñadas.

-- Sin embargo, ¡ojo con las limitaciones! Aunque es práctico, hay que tener
-- cuidado. Si los nombres de las columnas cambian en el futuro,
-- podríamos obtener resultados inesperados o unir cosas que no queríamos.
-- El Natural Join fusiona las columnas duplicadas automáticamente, mostrando la 
-- columna común solo una vez en el resultado.

-- Sintaxis:
-- SELECT columna1, columna2, ...
-- FROM tabla1
-- NATURAL JOIN tabla2;

/*
Riesgos en bases de datos grandes: La mayor desventaja del NATURAL JOIN es su "magia" automática. 
Si se añade una nueva columna con un nombre existente en ambas tablas a cualquiera de las dos tablas en el futuro, 
el NATURAL JOIN podría accidentalmente unirse sobre esa nueva columna, llevando a resultados incorrectos sin previo aviso o 
cambio explícito en la consulta. Por esta razón, muchos desarrolladores de bases de datos y DBAs prefieren evitar el 
NATURAL JOIN en favor del INNER JOIN con cláusulas ON o USING explícitas, que son más robustas y predecibles.

Forma compacta de unión: Aunque es arriesgado, es la forma más concisa de realizar una unión si las columnas de unión 
tienen exactamente el mismo nombre y significado en ambas tablas, y no hay otras columnas con nombres idénticos 
que no deban ser parte de la condición de unión.
*/




-- Ejemplo 1: Unir la tabla 'employees' y 'offices' para ver los detalles de los
-- empleados junto con la ciudad de su oficina. Ambas tablas tienen una columna
-- llamada 'office_code'.

SELECT e.first_name, e.last_name, o.city, o.country
FROM employees AS e
NATURAL JOIN offices AS o;


-- Ejemplo 2: Unir la tabla 'orders' y 'customers' para ver los pedidos junto con
-- el nombre del cliente. Ambas tablas tienen una columna llamada 'customer_number'.

SELECT o.order_number, o.order_date, c.customer_name
FROM orders As o
NATURAL JOIN customers AS c;


-- Ejemplo 3: Unir la tabla 'order_details' y 'products' para ver los productos
-- pedidos y sus nombres. Ambas tablas tienen 'product_code'.
SELECT od.order_number, p.product_name, od.quantity_ordered
FROM order_details od
NATURAL JOIN products p;


-- ***********************************************************************************
--  3. Inner Join 
-- ***********************************************************************************
-- El Inner Join es probablemente el tipo de JOIN más utilizado.
-- Solo devuelve las filas que tienen coincidencias en ambas tablas.
-- En otras palabras, solo veremos los datos que están presentes en ambas tablas
-- y cumplen con la condición de unión.
-- Es como el Natural Join, pero con una gran ventaja: nos permite enlazar tablas
-- incluso si las columnas que estamos utilizando para la unión NO tienen el mismo
-- nombre. Para lograr esto, utilizamos la palabra reservada ON.
-- Si un registro en una tabla no tiene una coincidencia en la otra, ese registro
-- no aparecerá en el resultado.
-- El resultado de un Inner Join contiene todas las columnas originales, incluso
-- si se llaman igual en ambas tablas (a diferencia del Natural Join que las fusiona).
-- No devolverá registros que sean NULL en las columnas de unión en ambas tablas.

-- Sintaxis básica con ON:
-- SELECT tabla1.columna1, tabla2.columnaX, ...
-- FROM tabla1
-- INNER JOIN tabla2 ON tabla1.columna_join = tabla2.columna_join;

-- Ejemplo 1: Queremos ver los nombres de los clientes y el nombre de su representante
-- de ventas. La tabla 'customers' tiene 'sales_rep_employee_number' y 'employees'
-- tiene 'employee_number'. Natural Join no funcionaría directamente aquí debido
-- a los diferentes nombres de columna, pero Inner Join es perfecto.
SELECT c.customer_name AS cliente, e.first_name AS nombre_rep_ventas, e.last_name AS apellido_rep_ventas
FROM customers AS c
INNER JOIN employees AS e ON c.sales_rep_employee_number = e.employee_number;


-- Ejemplo 2: Ver los detalles de los pedidos y los productos que contienen.
-- Unimos 'orders' con 'order_details' y 'order_details' con 'products'.
-- Aquí 'order_number' y 'product_code' son los puntos de unión.

SELECT o.order_number, o.order_date, p.product_name, od.quantity_ordered, od.price_each
FROM orders AS o
INNER JOIN order_details AS od ON o.order_number = od.order_number
INNER JOIN products AS p ON od.product_code = p.product_code;


-- Ejemplo 3: Listar los productos y sus líneas de producto correspondientes.
-- La columna de unión 'product_line' tiene el mismo nombre en ambas tablas,
-- pero con INNER JOIN ON, la explicitamos.
SELECT p.product_name, pl.product_line, pl.text_description
FROM products AS p 
INNER JOIN product_lines AS pl ON p.product_line = pl.product_line;


-- Uso de INNER JOIN con el operador USING:
-- El operador USING permite especificar una columna de unión sin tener que
-- calificarla con el nombre de la tabla, ya que asume que las columnas tienen
-- el mismo nombre en ambas tablas. Esto hace que las consultas sean más
-- concisas y legibles.

-- Sintaxis básica del INNER JOIN con el operador USING:
-- SELECT columnas
-- FROM tabla1
-- INNER JOIN tabla2 USING (columna_comun);

-- Ejemplo 4 con USING: Unir 'employees' y 'offices' usando 'office_code'.
-- Esto producirá un resultado similar al Natural Join si 'office_code' es la
-- única columna en común, pero con la diferencia de que controlamos qué
-- columnas se usan para la unión.
SELECT
    e.first_name,
    e.last_name,
    o.city AS office_city
FROM
    employees e
INNER JOIN
    offices o USING (office_code);




-- ***********************************************************************************
--  Reflexiones finales:
-- ***********************************************************************************
-- Hoy hemos aprendido a combinar datos de diferentes tablas utilizando los
-- JOINs. Esta es una habilidad fundamental en SQL para obtener información
-- más completa y significativa.
-- Hemos cubierto:
-- *   Cross Join: Para todas las combinaciones posibles, útil con filtros.
-- *   Natural Join: Para uniones automáticas por nombre de columna, conveniente
--                  pero requiere cuidado con el diseño de la base de datos.
-- *   Inner Join: El más común, une solo donde hay coincidencias, ofreciendo
--                 flexibilidad con la cláusula ON o concisión con USING.
-- La importancia de las coincidencias: Recuerden que el INNER JOIN solo incluirá
-- registros que tienen coincidencias en ambas tablas.
-- Flexibilidad: El INNER JOIN nos permite usar columnas que no se llaman igual,
-- lo que nos da mayor libertad al trabajar con nuestros datos.
-- ***********************************************************************************










