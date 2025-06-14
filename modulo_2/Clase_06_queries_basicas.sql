-- ***********************************************************************************
--  Clase de Consultas Básicas en SQL 🌟
--  Hoy nos adentraremos en el mundo de las consultas básicas en SQL.
--  Conocer cómo consultar la información es de vital importancia.
-- ***********************************************************************************

-- ***********************************************************************************
--  Preparación: Base de Datos de Prueba 📚
-- ***********************************************************************************

--  Para aprender a utilizar los comandos SQL, vamos a realizar ejercicios sobre una base de datos de prueba.
--  Esta base de datos se llama "bbdd_alumnas" y contiene la tabla "alumnas".
--  Se puede obtener esta tabla desde un archivo SQL proporcionado que creará la base de datos.

--  Pasos para configurar la base de datos en MySQL:
--  1. Una vez descargado el archivo (bbdd_alumnas.sql), dentro de MySQL debes ir a "File".
--  2. En las opciones desplegables, selecciona "Open SQL Script" para elegir el archivo que acabas de descargar.
--  3. Ejecútalo y eso hará que se cree la base de datos en el Panel de esquemas.
--  No olvides que cada sentencia que hagas, antes debes indicarle qué base de datos quieres utilizar.

--  Ejemplo de uso de la base de datos:
USE bbdd_alumnas;

-- ***********************************************************************************
--  1. SELECT y WHERE: La Esencia de las Consultas ✨
-- ***********************************************************************************

--  Comenzaremos con las cláusulas SELECT y WHERE, que son el corazón de cualquier consulta en SQL.
--  Estas dos cláusulas son muy poderosas juntas y son las más importantes para empezar.

-- ***********************************************************************************
--  1.1. SELECT: Cómo Traer las Columnas de una Tabla 📋
-- ***********************************************************************************

--  La cláusula SELECT nos ayuda a elegir columnas específicas de una tabla.
--  Nos permite obtener una vista preliminar de los datos almacenados.
--  Es como pedir una lista personalizada de la información que queremos ver.
--  Con SELECT podemos extraer datos de una o varias columnas de una tabla.

--  Sintaxis básica para seleccionar una columna:
--  SELECT columna FROM tabla;

--  Ejemplo 1.1.1: Seleccionar la columna 'nombre' de la tabla 'alumnas'
SELECT nombre -- Nombre de la columna
FROM alumnas; -- Nombre de la tabla

--  Sintaxis para seleccionar más de una columna:
--  Si queremos seleccionar más de una columna, indicaremos los nombres de las columnas dentro de la cláusula SELECT separadas por comas.
--  SELECT columna1, columna2, ... FROM tabla;

--  Ejemplo 1.1.2: Seleccionar las columnas 'nombre' y 'apellido' de la tabla 'alumnas'
SELECT nombre, apellido
FROM alumnas;

--  Sintaxis para seleccionar todas las columnas:
--  Si queremos seleccionarlos todos, existe una manera sencilla de hacerlo sin tener que escribir toda la lista en la consulta SELECT.
--  SELECT * FROM tabla;

--  Ejemplo 1.1.3: Seleccionar todas las columnas de la tabla 'alumnas'
SELECT * -- Usando un asterisco le decimos que queremos todas las columnas
FROM alumnas;

-- ***********************************************************************************
--  1.2. WHERE: Filtrando Resultados con Condiciones 🧹
-- ***********************************************************************************

--  En SQL, la cláusula WHERE se utiliza para filtrar los resultados de una consulta.
--  Permite especificar condiciones que deben cumplirse para que una fila sea seleccionada y devuelta.
--  En otras palabras, permite establecer criterios que los registros deben satisfacer para ser incluidos en el conjunto de resultados.
--  Esto les ayudará a extraer solo la información relevante y a evitar datos innecesarios.

--  Sintaxis básica para realizar consultas con la instrucción WHERE:
--  SELECT columna FROM tabla WHERE columna = condición;

--  Ejemplo 1.2.1: Filtrar nuestros datos para que nos devuelva los nombres y apellidos de las alumnas cuyo 'país' sea "Francia"
--  Las condiciones que se pueden poner no tienen por qué estar relacionadas solamente con las columnas que estamos seleccionando.
SELECT nombre, apellido
FROM alumnas
WHERE pais = "Francia";

-- ***********************************************************************************
--  1.3. Operadores de Condición y Lógicos para WHERE ✔
-- ***********************************************************************************

--  Hasta este punto, solo hemos utilizado el operador de igualdad (=) para realizar comparaciones.
--  Sin embargo, no siempre querremos que la condición contenida en el WHERE sea de igualdad.
--  Por ejemplo, podemos querer que la condición sea de desigualdad o, cuando se trate de evaluar un número, que este sea mayor o menor que cierta cantidad.

--  Operadores de Comparación:
--  =   Igual que (cuando queremos que el atributo sea igual que un valor)
--  <>  Distinto de (cuando queremos que el atributo sea distinto a un valor) -> También puede ser !=
--  <   Menor que (cuando queremos que el atributo sea menor que un valor)
--  >   Mayor que (cuando queremos que el atributo sea mayor que un valor)
--  <=  Menor o igual que
--  >=  Mayor o igual que

--  Ejemplo 1.3.1: Seleccionar 'ciudad' y 'país' de las alumnas cuyo 'teléfono' sea distinto a 674459123
SELECT ciudad, pais, id_alumna
FROM alumnas
WHERE telefono <> 674459123;

--  Operadores Lógicos para Múltiples Condiciones:
--  También se pueden establecer varias condiciones al mismo tiempo.
--  AND: Se deben de cumplir todas las condiciones especificadas.
--  OR: Se debe de cumplir al menos una de las condiciones.
--  NOT: Negará la condición que venga después del mismo.

--  Sintaxis con AND:
--  SELECT * FROM tabla WHERE columna1 = condicion1 AND columna2 = condicion2;

--  Ejemplo 1.3.2: Seleccionar 'teléfono' y 'dirección' de alumnas cuyo 'país' sea "España" Y 'apellido' sea "Garcia"
SELECT telefono, direccion
FROM alumnas
WHERE pais = "España" AND apellido = "Garcia";

--  Sintaxis con OR:
--  SELECT * FROM tabla WHERE columna1 = condicion1 OR columna2 = condicion2;

--  Ejemplo 1.3.3: Seleccionar 'nombre' y 'apellido' de alumnas cuya 'ciudad' sea "Valencia" O 'ciudad' sea "Bilbao"
SELECT nombre, apellido
FROM alumnas
WHERE ciudad = "Valencia" OR ciudad = "Bilbao";

--  Sintaxis con NOT:
--  SELECT * FROM tabla WHERE NOT columna = condición;

--  Ejemplo 1.3.4: Descartar todos aquellos registros de alumnas cuyo 'país' sea "España"
SELECT telefono, direccion, id_alumna
FROM alumnas
WHERE NOT pais = "España";

-- ***********************************************************************************
--  1.4. WHERE: IS NULL y IS NOT NULL (Manejo de Valores Nulos) 🚫
-- ***********************************************************************************

--  La cláusula WHERE columna IS NULL se utiliza para seleccionar registros en los que la columna especificada tiene un valor nulo.
--  Esta cláusula permite enfocarse en registros que carecen de información en una columna particular.

--  Sintaxis IS NULL:
--  SELECT columna1, columna2, ... FROM tabla WHERE columna IS NULL;

--  Ejemplo 1.4.1: Devolver el 'nombre', 'apellido' y 'email' de aquellas alumnas para las que no conocíamos la 'ciudad' a la hora de introducir sus datos.
SELECT nombre, apellido, email, id_alumna
FROM alumnas
WHERE ciudad IS NULL;

--  IS NULL puede negarse añadiendo la palabra reservada NOT para invertir su comportamiento.
--  De esa manera, tendríamos IS NOT NULL, que buscaría aquellos registros que sí tengan valores almacenados para ciertos atributos.

--  Sintaxis IS NOT NULL:
--  SELECT columna1, columna2, ... FROM tabla WHERE columna IS NOT NULL;

--  Ejemplo 1.4.2: Buscar aquellas alumnas que sí tienen almacenado un valor para 'ciudad'
SELECT nombre, apellido, email
FROM alumnas
WHERE ciudad IS NOT NULL;

-- ***********************************************************************************
--  2. Otras Consultas Importantes 🔍
-- ***********************************************************************************

--  Si bien vimos 2 de las más importantes (SELECT y WHERE), obviamente no son las únicas.
--  Veremos a continuación algunas de las más importantes, que se utilizan mucho en el día a día de las consultas.

-- ***********************************************************************************
--  2.1. ORDER BY: Ordenando los Resultados 📈
-- ***********************************************************************************

--  La cláusula ORDER BY les dará el poder de organizar los resultados en un orden específico.
--  Puede ser ascendente o descendente.
--  Esto es esencial para visualizar los datos de manera más clara y comprensible, como ordenar una lista de tareas por fecha de vencimiento.
--  Permite organizar los registros basado en los valores de una o varias columnas.

--  Sintaxis para orden Ascendente (ASC):
--  SELECT * FROM tabla ORDER BY columna ASC; -- el ASC viene de ASCENDENTE
--  (El orden ascendente es el predeterminado si no se especifica nada)

--  Sintaxis para orden Descendente (DESC):
--  SELECT * FROM tabla ORDER BY columna DESC; -- el DESC viene de DESCENDENTE

--  Ejemplo 2.1.1: Seleccionar todas las columnas de la tabla 'alumnas' y ordenarlas de manera descendente por 'apellido'
--  Como ves en la tabla, hemos seleccionado todas las columnas, con el detalle que queremos que se ordene de manera descendente por apellido.
SELECT *
FROM alumnas
ORDER BY apellido DESC;

-- ***********************************************************************************
--  2.2. DISTINCT: Valores Únicos 🌈
-- ***********************************************************************************

--  Aprenderán a utilizar DISTINCT para identificar y mostrar valores únicos en una columna.
--  Esto es especialmente útil para entender la distribución de los datos y evitar duplicados.
--  Es como ver qué tipos de productos únicos tenemos en una tienda.
--  Esta cláusula nos permite examinar la diversidad de valores presentes en una columna y obtener una vista única de las opciones disponibles.

--  Sintaxis básica para una columna:
--  SELECT DISTINCT columna FROM nombre_tabla;

--  Ejemplo 2.2.1: Seleccionar valores únicos de la columna 'país' en la tabla 'alumnas'
SELECT DISTINCT pais
FROM alumnas;

--  Sintaxis para múltiples columnas:
--  También podremos usarlo con varias columnas. En este caso, el resultado reflejará las combinaciones únicas de todos los atributos.
--  SELECT DISTINCT columna1, columna2 FROM nombre_tabla;

--  Ejemplo 2.2.2: Seleccionar combinaciones únicas de 'nombre' y 'apellido' de la tabla 'alumnas'
SELECT DISTINCT nombre, apellido
FROM alumnas;


-- ***********************************************************************************
--  2.3. LIMIT y OFFSET: Controlando la Cantidad de Resultados 📉
-- ***********************************************************************************

--  Descubrirán cómo limitar la cantidad de resultados que se muestran con LIMIT.
--  La cláusula LIMIT se utiliza para limitar el número de filas que se muestran en el resultado de una consulta.
--  Esto es especialmente útil cuando trabajamos con tablas que contienen una gran cantidad de registros y solo estamos interesados en una parte de ellos.

--  Sintaxis básica de la cláusula LIMIT:
--  SELECT columnas FROM nombre_tabla WHERE condición LIMIT cantidad_filas;

--  Ejemplo 2.3.1: Limitar la consulta a los primeros 2 registros de la tabla 'alumnas'
--  Aunque hayamos seleccionado la tabla completa al usar * en el SELECT, la consulta nos devuelve dos valores.
SELECT *
FROM alumnas
LIMIT 2;

--  La cláusula LIMIT se puede usar en combinación con otras, por ejemplo, ORDER BY.

--  Ejemplo 2.3.2: Seleccionar 'nombre', 'apellido' y 'salario' de la tabla 'empleadas', ordenado por apellido de forma descendente y solo los primeros 10 registros (ejemplo con otra tabla)
SELECT nombre, apellido, salario
FROM empleadas
ORDER BY apellido DESC
LIMIT 10;

SELECT id_alumna, nombre, ciudad
FROM alumnas
ORDER BY nombre DESC
LIMIT 4;

--  OFFSET se utiliza junto con la cláusula LIMIT para seleccionar un subconjunto específico de resultados a partir de un punto determinado en los resultados completos.
--  Con OFFSET, descartamos los primeros resultados de la consulta y nos devuelve solo aquellos a partir de la posición indicada.
--  Esto les permitirá manejar grandes conjuntos de datos de manera más eficiente, como ver solo una página de un libro a la vez.

--  Sintaxis de LIMIT y OFFSET:
--  SELECT columnas FROM nombre_tabla LIMIT cantidad OFFSET inicio;

SELECT id_alumna
FROM alumnas
LIMIT 4
OFFSET 2;

--  Ejemplo 2.3.3: 
SELECT id_alumna, nombre, apellido, ciudad
FROM alumnas
ORDER BY id_alumna DESC
LIMIT 2 
OFFSET 1;

--  Ejemplo 2.3.4: 
SELECT id_alumna, nombre, apellido, ciudad
FROM alumnas
WHERE pais = 'España'
ORDER BY id_alumna
LIMIT 3
OFFSET 2;

-- Omite los primeros registros de la consulta. Importante: se usa siempre junto con LIMIT.

-- ***********************************************************************************
--  2.4. BETWEEN: Selección en un Rango de Valores 📊
-- ***********************************************************************************

--  Exploraremos cómo utilizar BETWEEN para seleccionar registros dentro de un rango específico de valores.
--  Esto es útil para establecer condiciones que involucran fechas o rangos numéricos.
--  ¡Perfecto para encontrar todas las ventas realizadas en un mes específico!
--  La cláusula BETWEEN es especialmente útil cuando trabajamos con datos numéricos o fechas y deseamos limitar los resultados a un intervalo específico.

--  Sintaxis de BETWEEN:
--  SELECT columnas FROM nombre_tabla WHERE columna BETWEEN valor_inicio AND valor_fin;

--  Ejemplo 2.4.1: Seleccionar el 'nombre' y 'apellido' de aquellas alumnas cuyo 'id_alumna' se encuentre entre los valores 3 y 5.
--  Ambos valores (3 y 5) están incluidos, al ser equivalente a un operador >= y un operador <=.
SELECT id_alumna, nombre, apellido
FROM alumnas
WHERE id_alumna BETWEEN 3 AND 5;

--  Ejemplo 2.4.2: 
SELECT nombre, apellido, ciudad
FROM alumnas
WHERE apellido BETWEEN 'González' AND 'Ramos'
ORDER BY apellido;


-- ***********************************************************************************
--  2.5. IN: Coincidencia de Valores Múltiples 🛒
-- ***********************************************************************************

--  Aprenderán a usar IN para comparar un valor con una lista de posibles valores.
--  Esto simplificará las consultas que implican múltiples opciones.
--  ¡Así podemos buscar todos los registros que pertenecen a una lista específica de categorías!
--  La cláusula IN es especialmente útil cuando deseamos realizar consultas que involucren múltiples opciones en una sola columna.

--  Sintaxis de IN:
--  SELECT columnas FROM nombre_tabla WHERE columna IN (valor1, valor2, valor3);


--  Ejemplo 2.5.1: Seleccionar 'nombre' y 'apellido' de alumnas cuyas 'Ciudad' coincidan con 'Madrid', 'Valencia' o 'Barcelona'
SELECT nombre, apellido
FROM alumnas
WHERE ciudad IN ('Madrid', 'Valencia', 'Barcelona');

--  También se puede usar NOT IN para seleccionar registros que NO coincidan con los valores en la lista.
--  Ejemplo 2.5.2:
SELECT nombre, apellido
FROM alumnas
WHERE ciudad NOT IN ('Madrid', 'Valencia', 'Barcelona');

-- 📌 Equivalente: También podrías escribirla así, usando el operador NOT IN sin NOT al principio:
SELECT nombre, apellido
FROM alumnas
WHERE NOT ciudad IN ('Madrid', 'Valencia', 'Barcelona');


-- ***********************************************************************************
--  2.6. AS: Renombrando Columnas y Tablas 🏷
-- ***********************************************************************************

--  Finalmente, nos sumergiremos en el uso de la palabra clave AS para renombrar columnas y tablas en nuestros resultados.
--  Esto mejorará la legibilidad de los datos y facilitará el análisis, haciendo que los nombres sean más claros y descriptivos.

--  Sintaxis para alias de Columnas:
--  SELECT columna AS alias FROM nombre_tabla;

--  Sintaxis para alias de Tablas:
--  SELECT columna FROM nombre_tabla AS alias;

--  Ejemplo 2.6.1: Renombrar la columna 'nombre' como 'Name' y 'apellido' como 'Surname', y renombrar la tabla 'alumnas' como 'Students'
SELECT nombre AS Name, apellido AS Surname
FROM alumnas AS Students;

-- ***********************************************************************************
--  3. Orden de Escritura de las Cláusulas y Resumen 🧠
-- ***********************************************************************************

--  Al igual que una buena receta de cocina, en todas las sentencias de SQL se debe respetar un orden de escritura.
--  No podemos pasar las cláusulas a MySQL de cualquier forma.

--  Orden de escritura de las cláusulas en una consulta SQL (las vistas hasta ahora):
--  1. SELECT 
--  2. FROM
--  3. WHERE
--  4. ORDER BY
--  5. LIMIT 
--  6. OFFSET

--  Ejemplo de orden de cláusulas: SELECT, FROM, WHERE
SELECT nombre AS Name
FROM alumnas
WHERE nombre = "Ana";

--  Ejemplo de orden de cláusulas: SELECT, FROM, WHERE, ORDER BY
SELECT nombre AS Name
FROM alumnas
WHERE apellido = "López"
ORDER BY nombre DESC;

--  Ejemplo de orden de cláusulas: SELECT, FROM, WHERE, ORDER BY, LIMIT
SELECT nombre AS Name
FROM alumnas
WHERE pais = "España"
ORDER BY nombre DESC
LIMIT 3;


-- ***********************************************************************************
--  Resumen de la Lección 🌟
-- ***********************************************************************************

--  Aquí les traigo un breve resumen de las cláusulas clave que hemos abordado hoy:

--  SELECT:
--  Añadimos el nombre de la columna o columnas que queremos extraer.
--  Sintaxis: SELECT columna FROM tabla;

--  WHERE:
--  Ponemos condiciones para extraer los datos. Se pueden utilizar varias columnas en las condiciones.
--  Sintaxis: SELECT columna FROM tabla WHERE columna = condición;

--  IS NULL/NOT NULL:
--  Lo usamos en el WHERE para obtener los registros nulos o no nulos de una columna.
--  Sintaxis: SELECT nombre, apellido, email FROM alumnas WHERE ciudad IS NULL;

--  ORDER BY:
--  Ordena los registros en base a una columna (ASC o DESC).
--  Sintaxis: SELECT * FROM tabla ORDER BY columna ASC;

--  DISTINCT:
--  Muestra valores únicos de una columna.
--  Sintaxis: SELECT DISTINCT columna FROM nombre_tabla;

--  LIMIT:
--  Limita el número de registros de la consulta. Muestra los primeros X registros.
--  Podemos usarlo junto con ORDER BY.
--  Sintaxis: SELECT nombre, apellido, salario FROM empleadas ORDER BY apellido DESC LIMIT 10;

--  OFFSET:
--  Omite los primeros registros de la consulta. Importante: se usa siempre junto con LIMIT.
--  La consulta nos muestra el número de registros que hemos establecido en el LIMIT.
--  Sintaxis: SELECT columnas FROM nombre_tabla LIMIT cantidad OFFSET inicio;

--  BETWEEN:
--  Selecciona registros cuyos valores se encuentren dentro de un rango determinado (ambos inclusivos).
--  Sintaxis: SELECT columnas FROM nombre_tabla WHERE columna BETWEEN valor_inicio AND valor_fin;

--  IN:
--  Selecciona registros cuyos valores en una columna coinciden con cualquiera de los valores proporcionados en una lista.
--  Sintaxis: SELECT columnas FROM nombre_tabla WHERE columna IN (valor1, valor2, valor3);

--  AS:
--  Proporciona alias (nombres alternativos) a columnas y tablas.
--  Sintaxis columna: SELECT columna AS alias FROM nombre_tabla;
--  Sintaxis tabla: SELECT columna FROM nombre_tabla AS alias;


-- ***********************************************************************************
--  Hemos aprendido cómo usar la cláusula SELECT para elegir las columnas que queremos ver.
--  También aplicamos la cláusula WHERE para filtrar los datos y obtener la información más relevante.
--  Además, exploramos consultas más avanzadas como ORDER BY, DISTINCT, LIMIT, OFFSET, BETWEEN, IN, y el uso de alias con AS.
-- ***********************************************************************************








