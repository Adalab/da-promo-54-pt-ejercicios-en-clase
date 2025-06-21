-- ***********************************************************************************
--  Hoy nos enfocaremos en descubrir patrones y conexiones en nuestros datos, 
--  lo que nos ayudará a tomar decisiones informadas basadas en información real.
--  Aprenderemos sobre combinar y filtrar datos de manera más eficiente en SQL.
--  Dominaremos herramientas poderosas como UNION, UNION ALL, IN, NOT IN, LIKE, NOT LIKE y REGEX.
-- ***********************************************************************************


-- ***********************************************************************************
--  1. UNION 🔗
-- ***********************************************************************************

-- La operación UNION es una forma súper útil de combinar los resultados de dos o más consultas en un solo conjunto de datos.
-- Lo más genial de todo es que no solo junta los datos, sino que también elimina automáticamente cualquier duplicado,
-- ofreciéndonos una lista única y ordenada.
-- Imagina que tienes dos listas y quieres una lista combinada sin elementos repetidos. ¡Esa es la idea!

-- Para que UNION funcione correctamente, ambas consultas deben tener:
-- - El mismo número de columnas.
-- - Los mismos tipos de datos en esas columnas (por ejemplo, si en la primera consulta estás obteniendo ciudades,
--   en la segunda también deben ser ciudades, no números ni fechas).
-- - La primera consulta será la que decida el orden de los resultados finales si no se especifica un ORDER BY final.

-- Sintaxis básica de UNION:
-- SELECT columnas FROM tabla1 UNION SELECT columnas FROM tabla2;

-- Ejemplo 1: Obtener la lista de todos los países únicos donde tenemos clientes y oficinas.
-- Usaremos la tabla `customers` y la tabla `offices` de la base de datos `tienda`.
SELECT
    country -- Seleccionamos la columna 'country' de la tabla 'customers'
FROM
    customers -- Desde la tabla 'customers'
UNION -- Combinamos los resultados, eliminando duplicados
SELECT
    country -- Seleccionamos la columna 'country' de la tabla 'offices'
FROM
    offices; -- Desde la tabla 'offices'

-- Explicación del resultado del Ejemplo 1:
-- Al ejecutar esta consulta, obtendremos una lista de valores únicos de países
-- que aparecen en ambas tablas (`customers` y `offices`).
-- UNION eliminará automáticamente los países duplicados, así que veremos cada país solo una vez.


-- Ejemplo 2: Obtener la lista de todas las ciudades únicas de clientes y oficinas.
-- Es importante que las columnas tengan tipos de datos compatibles. Ambas columnas `city` son de tipo `VARCHAR`.
SELECT
	city -- Seleccionamos la columna 'city' de la tabla 'customers'
FROM
    customers -- Desde la tabla 'customers'
UNION -- Combinamos los resultados, eliminando duplicados
SELECT
    city -- Seleccionamos la columna 'city' de la tabla 'offices'
FROM
    offices; -- Desde la tabla 'offices'

-- Explicación del resultado del Ejemplo 2:
-- Esta consulta nos dará una lista de todas las ciudades únicas donde tenemos clientes o donde se encuentran nuestras oficinas.


-- ***********************************************************************************
--  2. UNION ALL 📚
-- ***********************************************************************************

-- UNION ALL es una operación súper útil cuando queremos combinar resultados de varias consultas
-- y no nos importa si hay valores duplicados.
-- Es ideal cuando queremos todos los resultados, sin eliminar nada.
-- La sentencia UNION ALL en MySQL nos permite combinar los resultados de dos o más consultas,
-- manteniendo todos los registros, incluso si hay duplicados.
-- Esto la diferencia de UNION, que elimina automáticamente los duplicados.

-- Sintaxis básica de UNION ALL:
-- SELECT columnas FROM tabla1 UNION ALL SELECT columnas FROM tabla2;

-- Ejemplo 1: Obtener la lista de todos los países de clientes y oficinas, incluyendo duplicados.
-- Usaremos las mismas tablas `customers` y `offices` para mostrar la diferencia con UNION.
SELECT
    country -- Seleccionamos la columna 'country' de la tabla 'customers'
FROM
    customers -- Desde la tabla 'customers'
UNION ALL -- Combinamos todos los resultados, manteniendo duplicados
SELECT
    country -- Seleccionamos la columna 'country' de la tabla 'offices'
FROM
    offices; -- Desde la tabla 'offices'

-- Explicación del resultado del Ejemplo 1:
-- Al ejecutar esta consulta, veremos todos los países, incluyendo aquellos que se repiten
-- en ambas tablas (`customers` y `offices`).


-- Ejemplo 2: Obtener la lista de todas las ciudades de clientes y oficinas, incluyendo duplicados.
SELECT
    city -- Seleccionamos la columna 'city' de la tabla 'customers'
FROM
    customers -- Desde la tabla 'customers'
UNION ALL -- Combinamos todos los resultados, manteniendo duplicados
SELECT
    city -- Seleccionamos la columna 'city' de la tabla 'offices'
FROM
    offices; -- Desde la tabla 'offices'

-- Explicación del resultado del Ejemplo 2:
-- Esta consulta listará todas las ciudades, y si una ciudad aparece en ambas tablas
-- o varias veces en una misma tabla, se mostrará tantas veces como aparezca.


-- Cómo usar ORDER BY y LIMIT con UNION ALL:
-- Podemos combinar ORDER BY y LIMIT con UNION ALL para ordenar los resultados
-- y limitar cuántos queremos ver. Estas cláusulas deben ir al final de toda la consulta.

-- Ejemplo 3: Obtener los primeros 10 países de clientes y oficinas, ordenados alfabéticamente, incluyendo duplicados.
SELECT
    country -- Seleccionamos el país de la tabla 'customers'
FROM
    customers -- Desde la tabla 'customers'
UNION ALL -- Combinamos todos los resultados, incluyendo duplicados
SELECT
    country -- Seleccionamos el país de la tabla 'offices'
FROM
    offices -- Desde la tabla 'offices'
ORDER BY
    country -- Ordenamos los resultados por país alfabéticamente
LIMIT 10; -- Limitamos la salida a los primeros 10 registros

-- Explicación del resultado del Ejemplo 3:
-- Esta consulta devolverá una lista combinada de los países, ordenados alfabéticamente,
-- y se mostrarán los primeros 10 de la lista resultante, incluso si hay repeticiones.


-- ***********************************************************************************
--  3. IN ✔ y NOT IN ❌
-- ***********************************************************************************

-- IN nos permite seleccionar filas donde el valor de una columna coincide
-- con uno de varios valores que le pasamos.
-- Esto es súper útil cuando queremos filtrar datos sin tener que escribir varias veces OR.

-- Sintaxis básica de IN:
-- SELECT columnas FROM tabla WHERE columna IN (valor1, valor2, valor3, ...);


-- Ejemplo 1: Seleccionar clientes que son de 'USA' o 'France'.
-- Usaremos la tabla `customers`.
SELECT
    customer_name, -- Seleccionamos el nombre del cliente
    country -- Seleccionamos el país del cliente
FROM
    customers -- Desde la tabla 'customers'
WHERE
    country IN ('USA', 'France'); -- Filtramos donde el país esté en la lista ('USA', 'France')

-- Explicación del resultado del Ejemplo 1:
-- Esta consulta nos devolverá los nombres y países de todos los clientes
-- que se encuentran en Estados Unidos o Francia.



-- Ejemplo 2: Seleccionar órdenes con el estado 'Shipped' o 'Disputed'.
-- Usaremos la tabla `orders`.
SELECT
    order_number, -- Seleccionamos el número de orden
    status, -- Seleccionamos el estado de la orden
    order_date -- Seleccionamos la fecha de la orden
FROM
    orders -- Desde la tabla 'orders'
WHERE
    status IN ('Shipped', 'Disputed'); -- Filtramos donde el estado sea 'Shipped' o 'Disputed'

-- Explicación del resultado del Ejemplo 2:
-- Obtendremos una lista de órdenes que han sido enviadas o que están en estado de disputa.



-- NOT IN nos ayuda a excluir datos fácilmente.
-- Con esta sentencia, excluimos los valores que están en una lista.
-- Perfecto cuando queremos centrarnos en datos que no están en una lista específica.

-- Sintaxis básica de NOT IN:
-- SELECT columnas FROM tabla WHERE columna NOT IN (valor1, valor2, valor3, ...);


-- Ejemplo 3: Seleccionar clientes que NO son de 'Spain' ni 'Germany'.
-- Usaremos la tabla `customers`.
SELECT
    customer_name, -- Seleccionamos el nombre del cliente
    country -- Seleccionamos el país del cliente
FROM
    customers -- Desde la tabla 'customers'
WHERE
    country NOT IN ('Spain', 'Germany'); -- Filtramos donde el país NO esté en la lista ('Spain', 'Germany')

-- Explicación del resultado del Ejemplo 3:
-- Esta consulta nos mostrará los clientes de cualquier país, excepto España y Alemania.


-- Ejemplo 4: Seleccionar productos que NO pertenecen a las líneas 'Classic Cars' ni 'Motorcycles'.
-- Usaremos la tabla `products`.
SELECT
    product_name, -- Seleccionamos el nombre del producto
    product_line -- Seleccionamos la línea de producto
FROM
    products -- Desde la tabla 'products'
WHERE
    product_line NOT IN ('Classic Cars', 'Motorcycles'); -- Filtramos donde la línea de producto NO sea 'Classic Cars' ni 'Motorcycles'

-- Explicación del resultado del Ejemplo 4:
-- Obtendremos todos los productos que no son ni coches clásicos ni motocicletas.



-- ***********************************************************************************
--  4. LIKE 🌟 y NOT LIKE 🚫
-- ***********************************************************************************

-- Las cláusulas LIKE y NOT LIKE nos permiten buscar patrones dentro de nuestras tablas.
-- Esto es súper práctico cuando no sabemos el valor exacto que queremos buscar,
-- pero sí tenemos una idea de cómo podría verse.
-- LIKE nos permite buscar patrones en lugar de coincidencias exactas.
-- NOT LIKE hace lo contrario: nos ayuda a excluir aquellos registros que cumplen con un patrón determinado.
-- No distingue entre mayúscula y minúscula.

-- Sintaxis básica de LIKE:
-- SELECT columnas FROM tabla WHERE columna LIKE 'patron';

-- Comodines en LIKE:
-- - % : Representa cualquier cantidad de caracteres (incluyendo ninguno).
--   Por ejemplo, 'A%' encontrará cualquier valor que comience con 'A', sin importar qué más venga después.
-- - _ : Representa exactamente un carácter.
--   Si ponemos 'B__', estamos buscando algo que comience con 'B' y tenga exactamente dos caracteres más.


-- Ejemplo 1: Buscar nombres de clientes que empiecen con 'A'.
-- Usaremos la tabla `customers`.
SELECT
    customer_name -- Seleccionamos el nombre del cliente
FROM
    customers -- Desde la tabla 'customers'
WHERE
    customer_name LIKE 'A%'; -- Filtramos donde el nombre del cliente comience con 'A'

-- Explicación del resultado del Ejemplo 1:
-- Esta consulta devolverá todos los clientes cuyo nombre empieza con la letra 'A'.


-- Ejemplo 2: Buscar nombres de productos que contengan la palabra 'Ford'.
-- Usaremos la tabla `products`.
SELECT
    product_name -- Seleccionamos el nombre del producto
FROM
    products -- Desde la tabla 'products'
WHERE
    product_name LIKE '%Ford%'; -- Filtramos donde el nombre del producto contenga la palabra 'Ford' en cualquier posición

-- Explicación del resultado del Ejemplo 2:
-- Obtendremos una lista de productos que tienen 'Ford' en su nombre,
-- independientemente de si está al principio, al final o en medio.


-- Ejemplo 3: Buscar extensiones de empleados que tengan 'x' seguido de tres caracteres.
-- Usaremos la tabla `employees`.
SELECT
    first_name, -- Seleccionamos el nombre del empleado
    last_name, -- Seleccionamos el apellido del empleado
    extension -- Seleccionamos la extensión del empleado
FROM
    employees -- Desde la tabla 'employees'
WHERE
    extension LIKE 'x___'; -- Filtramos donde la extensión comience con 'x' y tenga exactamente tres caracteres más

-- Explicación del resultado del Ejemplo 3:
-- Esta consulta mostrará los empleados cuyas extensiones siguen el patrón 'x' seguido de tres caracteres.


-- Sintaxis básica de NOT LIKE:
-- SELECT columna1, columna2, ... FROM tabla WHERE columna NOT LIKE 'patron';



-- Ejemplo 4: Excluir productos cuyos nombres empiecen con '19'.
-- Usaremos la tabla `products`.
SELECT
    product_name -- Seleccionamos el nombre del producto
FROM
    products -- Desde la tabla 'products'
WHERE
    product_name NOT LIKE '19%'; -- Excluimos los productos cuyo nombre comienza con '19'

-- Explicación del resultado del Ejemplo 4:
-- Obtendremos todos los nombres de productos excepto aquellos que comienzan con "19".


-- Ejemplo 5: Excluir empleados cuyo email contenga 'classicmodelcars.com'.
-- Usaremos la tabla `employees`.
SELECT
    first_name, -- Seleccionamos el nombre del empleado
    last_name, -- Seleccionamos el apellido del empleado
    email -- Seleccionamos el email del empleado
FROM
    employees -- Desde la tabla 'employees'
WHERE
    email NOT LIKE '%classicmodelcars.com%'; -- Excluimos los emails que contienen 'classicmodelcars.com'

-- Explicación del resultado del Ejemplo 5:
-- Esta consulta mostrará los empleados cuyos correos electrónicos no pertenecen
-- al dominio 'classicmodelcars.com'.




-- Ejemplo 6: Buscar descripciones de productos que contengan un signo de porcentaje literal.
-- Usaremos la columna `product_description` en `products`.
-- Asumimos que algunas descripciones podrían contener texto como "50% de descuento".
SELECT
    product_name, -- Seleccionamos el nombre del producto
    product_description -- Seleccionamos la descripción del producto
FROM
    products -- Desde la tabla 'products'
WHERE
    product_description LIKE '%\%%'; -- Buscamos descripciones que contengan un '%' literal

-- Explicación del resultado del Ejemplo 6:
-- Esta consulta encontrará productos en cuya descripción aparezca el símbolo literal de porcentaje.



-- ***********************************************************************************
--  5. REGEX 🔍
-- ***********************************************************************************
-- Las expresiones regulares, o REGEX, en SQL son una herramienta poderosa que te permite buscar y filtrar datos basándose 
-- en patrones complejos, yendo más allá de las capacidades de `LIKE`. 
-- Te permiten definir reglas específicas para encontrar caracteres o combinaciones dentro de tus columnas.

-- Cuándo usar REGEX:
-- - Cuando queramos encontrar correos electrónicos que contienen ciertos dominios.
-- - Cuando las cadenas de texto comiencen, terminen o contengan letras o palabras específicas.
-- - ¡Y muchas otras cosas más!

-- Sintaxis básica de REGEX:
-- SELECT columna1, columna2, ... FROM tabla WHERE columna REGEXP 'patron';


-- Operadores clave en REGEX:
-- - . (Punto): Representa cualquier carácter individual en la cadena.
-- - * : Coincide con cero o más repeticiones del carácter o patrón anterior.
-- - + : Coincide con una o más repeticiones del carácter o patrón anterior.
-- - ? : Coincide con cero o una repetición del carácter o patrón anterior.
-- - | (Barra vertical): Funciona como un operador "o" para alternativas.
-- - [] (Corchetes): Permite definir un conjunto de caracteres válidos para una posición específica en la cadena.
-- - [^] (Corchetes con acento circunflejo): Excluye un conjunto de caracteres para una posición específica en la cadena.
-- - () (Paréntesis): Agrupa elementos para aplicar operadores a un conjunto completo.
-- - {n} : Coincide exactamente con n repeticiones del carácter o patrón anterior.
-- - {n, m} : Coincide con un rango de repeticiones, desde n hasta m, del carácter o patrón anterior.
-- - ^ : Marca el inicio de la cadena.
-- - $ : Marca el final de la cadena.


-- Ejemplo 1: Buscar productos cuyo nombre contenga "Ford" o "Chevy".
-- Usaremos la tabla `products`.
SELECT
    product_name -- Seleccionamos el nombre del producto
FROM
    products -- Desde la tabla 'products'
WHERE
    product_name REGEXP 'Ford|Chevy'; -- Filtramos donde el nombre del producto contenga 'Ford' O 'Chevy'

-- Explicación del resultado del Ejemplo 1:
-- Esta consulta encontrará todos los productos que mencionan "Ford" o "Chevy" en su nombre.



-- Ejemplo 2: Buscar números de teléfono de clientes que comiencen con el signo '+'.
-- Usaremos la tabla `customers`.
-- El carácter '+' tiene un significado especial en REGEX, por lo que necesita ser escapado con '\\'.
SELECT
    customer_name, -- Seleccionamos el nombre del cliente
    phone -- Seleccionamos el número de teléfono
FROM
    customers -- Desde la tabla 'customers'
WHERE
    phone REGEXP '^\\+'; -- Filtramos donde el número de teléfono comience con '+'

-- Explicación del resultado del Ejemplo 2:
-- Esta consulta devolverá los clientes cuyos números de teléfono son internacionales,
-- es decir, aquellos que empiezan con el símbolo '+'.




-- Ejemplo 3: Buscar comentarios de órdenes que contengan la palabra "customer" (insensible a mayúsculas/minúsculas).
-- Usaremos la tabla `orders`.
-- `[Cc]` permite que la primera letra sea 'C' o 'c'.
SELECT
    order_number, -- Seleccionamos el número de orden
    comments -- Seleccionamos los comentarios de la orden
FROM
    orders -- Desde la tabla 'orders'
WHERE
    comments REGEXP '[Cc]ustomer'; -- Filtramos donde los comentarios contengan 'Customer' o 'customer'

-- Explicación del resultado del Ejemplo 3:
-- Se mostrarán las órdenes que tienen algún comentario que menciona la palabra "customer",
-- sin importar si empieza con mayúscula o minúscula.



-- Ejemplo 4: Buscar productos cuyo código comience con 'S10' o 'S12'.
-- Usaremos la tabla `products`.
SELECT
    product_name, -- Seleccionamos el nombre del producto
    product_code -- Seleccionamos el código del producto
FROM
    products -- Desde la tabla 'products'
WHERE
    product_code REGEXP '^(S10|S12)'; -- Filtramos donde el código del producto comience con 'S10' O 'S12'

-- Explicación del resultado del Ejemplo 4:
-- Esta consulta listará todos los productos cuyos códigos comienzan con "S10" o "S12".


SELECT
    product_name, -- Seleccionamos el nombre del producto
    product_code -- Seleccionamos el código del producto
FROM
    products -- Desde la tabla 'products'
WHERE
    product_code LIKE 'S10%' OR product_code LIKE 'S12%';


