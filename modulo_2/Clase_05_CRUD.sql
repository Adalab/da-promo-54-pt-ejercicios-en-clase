-- ***********************************************************************************
--  Modificación e inserción de datos 🌟
--  Hoy nos enfocaremos en **cómo modificar e insertar datos** en una base de datos.
--  Las bases de datos no son estáticas; requieren ajustes y actualizaciones para
--  adaptarse a nuevas necesidades. En esta clase, exploraremos cómo modificar y
--  mantener nuestras tablas de manera eficiente.
--  Aprenderemos sobre las seis operaciones fundamentales divididas en dos grupos
--  principales: las operaciones **CRUD** (Create, Read, Update, Delete) y **ALTER TABLE/DROP TABLE**.
-- ***********************************************************************************

-- ***********************************************************************************
--  1. Preparación del Entorno en MySQL Workbench
-- ***********************************************************************************

-- Para empezar, necesitamos asegurarnos de que estamos trabajando en la base de datos correcta.

-- 1.1. **Crear el Esquema (Base de Datos)**
-- Primero, vamos a crear el esquema (base de datos) si no existe.
-- Esto nos permite crear la base de datos por línea de comandos.
-- Sintaxis: CREATE SCHEMA IF NOT EXISTS nombre_esquema;

CREATE SCHEMA IF NOT EXISTS adalab;

-- 1.2. **Usar la Base de Datos**
-- Con el comando `USE`, le indicamos a MySQL que todas las operaciones siguientes
-- se realizarán sobre esta base de datos.
-- Sintaxis: USE nombre_base_de_datos;
USE promo_paola;

-- ***********************************************************************************
--  2. Creación de Tabla (CREATE TABLE)
-- ***********************************************************************************

-- Vamos a crear la tabla 'adalabers' para nuestros ejemplos.
-- Una tabla siempre debe tener una **clave primaria (PRIMARY KEY)**, que es **única y no se puede repetir**.
-- `AUTO_INCREMENT` se usa para que el ID se genere automáticamente al insertar nuevos registros.
-- Las columnas con `NOT NULL` no pueden tener valores vacíos.
-- La columna `UNIQUE` asegura que cada valor en esa columna sea único en toda la tabla.
-- `ENUM` permite definir una lista de valores predefinidos para una columna.
-- `BOOLEAN` representa valores verdaderos o falsos.
-- Las fechas se suelen manejar con el tipo `DATE`.

-- Sintaxis Básica:
-- CREATE TABLE IF NOT EXISTS nombre_tabla (
--    nombre_columna1 TIPO_DATO [RESTRICCIONES],
--    nombre_columna2 TIPO_DATO [RESTRICCIONES],
--    ...
-- );

CREATE TABLE IF NOT EXISTS adalabers (
	id_adalaber INT AUTO_INCREMENT PRIMARY KEY, 
    nombre_completo VARCHAR(30) NOT NULL, 
    apellido VARCHAR(30) NOT NULL,
    ciudad VARCHAR(60), 
    correo VARCHAR(100) UNIQUE, 
    telefono VARCHAR(15), 
    curso VARCHAR(50), 
    conocimientos_previos ENUM('Python', 'SQL', 'Excel', 'Ninguno'), 
    permiso_redes_sociales BOOLEAN, 
    fecha_registro DATE NOT NULL
);


-- ***********************************************************************************
--  3. Modificación de Tablas (ALTER TABLE)
-- ***********************************************************************************

-- La instrucción `ALTER TABLE` nos permite ajustar la estructura de nuestras tablas existentes.

-- 3.1. **Añadir Columnas (ADD COLUMN)**
-- Si queremos añadir una nueva columna a una tabla existente, usamos `ADD COLUMN`.

-- Sintaxis: ALTER TABLE nombre_tabla ADD COLUMN nombre_nueva_columna TIPO_DATO [RESTRICCIONES];

ALTER TABLE adalabers
ADD COLUMN username VARCHAR(50);

-- Puedes verificar el cambio actualizando el esquema en Workbench o haciendo un SELECT:
SELECT * FROM adalabers;

-- 3.2. **Eliminar Columnas (DROP COLUMN)**
-- Si necesitamos eliminar una columna que ya no usamos, podemos usar `DROP COLUMN`.
-- **¡OJO! Eliminar una columna borrará también todos los datos que contenía**.
-- Sintaxis: ALTER TABLE nombre_tabla DROP COLUMN nombre_columna;

ALTER TABLE adalabers
DROP COLUMN username;

-- 3.3. **Cambiar el Tipo de Datos de una Columna (MODIFY COLUMN)**
-- Si necesitamos cambiar el tipo de datos de una columna existente, usamos `MODIFY COLUMN`.
-- Sintaxis: ALTER TABLE nombre_tabla MODIFY COLUMN nombre_columna NUEVO_TIPO_DATO [NUEVAS_RESTRICCIONES];

ALTER TABLE adalabers
MODIFY COLUMN nombre_completo VARCHAR(50);

-- 3.4. **Renombrar una Columna (CHANGE COLUMN)**
-- Podemos cambiar el nombre de una columna y su tipo de dato al mismo tiempo con `CHANGE COLUMN`.
-- Sintaxis: ALTER TABLE nombre_tabla CHANGE nombre_antiguo_columna nombre_nuevo_columna TIPO_DATO [RESTRICCIONES];

ALTER TABLE adalabers
CHANGE COLUMN nombre_completo nombre_adalaber VARCHAR(20);

-- También podemos usar `RENAME COLUMN` para solo cambiar el nombre, sin modificar el tipo de dato.
-- Sintaxis: ALTER TABLE nombre_tabla RENAME COLUMN nombre_antiguo_columna TO nombre_nuevo_columna;
ALTER TABLE adalabers
RENAME COLUMN nombre_adalaber TO nombre_completo; -- Para volver al nombre original (ejemplo)

-- 3.5. **Cambiar el Nombre de una Tabla (RENAME TABLE)**
-- Para cambiar el nombre de una tabla completa.
-- Si ejecutas esto, todos los comandos siguientes deberán usar el nuevo nombre en lugar del original.
-- Sintaxis: RENAME TABLE nombre_antiguo_tabla TO nombre_nuevo_tabla;

RENAME TABLE alumnas TO adalabers;

-- ***********************************************************************************
--  4. Eliminar Tablas (DROP TABLE)
-- ***********************************************************************************
-- La sentencia `DROP TABLE` **elimina por completo una tabla y todos los datos que contiene**.
-- **¡Es una operación irreversible!** Una vez que borras la tabla, no puedes recuperarla.
-- Por esta razón, no la ejecutaremos aquí para no borrar nuestra tabla de trabajo.
-- Se usa `IF EXISTS` para evitar un error si la tabla no existe.
-- Sintaxis: DROP TABLE [IF EXISTS] nombre_tabla;

-- DROP TABLE IF EXISTS adalabers;

-- Para eliminar múltiples tablas a la vez:
-- DROP TABLE IF EXISTS tabla1, tabla2, tabla3;



-- ***********************************************************************************
--  5. Operaciones CRUD (Create, Read, Update, Delete)
-- ***********************************************************************************

-- **CRUD** se refiere a las cuatro operaciones básicas que podemos hacer con nuestros datos:
-- **C**reate (Crear): Añadir nuevos datos.
-- **R**ead (Leer): Consultar y visualizar datos.
-- **U**pdate (Actualizar): Modificar datos existentes.
-- **D**elete (Eliminar): Borrar datos.


-- 5.2. **Insertar Datos (INSERT INTO) - (CREATE)**
-- La instrucción `INSERT INTO` se usa para añadir nuevas filas (registros) a nuestras tablas.
-- Es **muy importante** que la cantidad de columnas que especifiques coincida con la cantidad de valores que pases,
-- y que el orden de los valores sea el mismo que el de las columnas.

-- **Consejos útiles al insertar datos:**
-- * La columna `id_adalaber` es `AUTO_INCREMENT`, por lo que **no necesitamos introducir ese valor**.
-- * Los textos (cadenas de caracteres) deben ir entre **comillas simples (' ')**.
-- * Los números no necesitan comillas. Si un número empieza por '0' y es tipo numérico, el '0' inicial se descartará.
-- * Las fechas deben introducirse en el formato `AAAA-MM-DD` (Año-Mes-Día) y entre comillas simples.

-- Sintaxis Básica:
-- INSERT INTO nombre_tabla (columna1, columna2, ...) VALUES (valor1, valor2, ...);

-- Para insertar múltiples registros:
-- INSERT INTO nombre_tabla (columna1, columna2, ...) VALUES (valor1a, valor2a, ...), (valor1b, valor2b, ...);

-- Ejemplo 1: Insertar un único registro
INSERT INTO adalabers (nombre_completo, apellido, ciudad, correo, telefono, curso, conocimientos_previos, permiso_redes_sociales, fecha_registro)
VALUES ('Marta', 'Morell', 'Málaga', 'marta@adalab.es', '+3468785647', 'Data Analytics', 'Python', True, '2025-04-22');

SELECT * FROM adalabers;

-- Es súper importante que la cantidad de valores coincida con la cantidad de columnas!!
-- también es importante que el orden sea el mismo!!
-- Que las comillas sean simples.
-- Que se respeten las restricciones, si pone NOT NULL, tengo que poner un valor ahí.

-- Ejemplo 2: Insertar múltiples registros a la vez
-- Separamos cada conjunto de valores con una coma.

INSERT INTO adalabers (nombre_completo, apellido, ciudad, correo, telefono, curso, conocimientos_previos, permiso_redes_sociales, fecha_registro)
VALUES 
('Marta', 'Sanz', 'Barcelona', 'martas@adalab.es', '+3468785647', 'Data Analytics', 'SQL', TRUE, '2025-04-22'),
('Ana', 'Robles', 'Sevilla', 'ana@adalab.es', '+3468785647', 'Data Analytics', 'Python', False, '2025-04-22'),
('Iris', 'Barredo', 'Oviedo', 'iris@adalab.es', '+3468785647', 'Data Analytics', 'Excel', FALSE, '2025-04-22');


-- 5.3. **Consultar Datos (SELECT) - (READ)**
-- La instrucción `SELECT` nos ayuda a obtener y visualizar la información almacenada en nuestras tablas.
-- Usamos `*` para seleccionar todas las columnas de una tabla.
-- Sintaxis Básica: SELECT [columnas] FROM nombre_tabla;

-- Ejemplo: Seleccionar todas las columnas de la tabla 'adalabers'
SELECT * FROM adalabers;
-- SELECT nombre_completo, apellido FROM adalabers;

-- Con la cláusula `WHERE`, podemos filtrar los datos que queremos ver, basándonos en ciertas condiciones.

-- Ejemplo: Seleccionar información de Ana
SELECT ciudad FROM adalabers
WHERE nombre_completo = 'Ana'; -- Filtro

-- Ejemplo con `AND`: Para combinar múltiples condiciones, donde todas deben ser verdaderas.
-- Quiero las adalabers cuyo nombre es 'Marta' Y su curso es Data Analytics

SELECT * FROM adalabers 
WHERE nombre_completo = 'Marta' AND curso = 'Data Analytics' AND conocimientos_previos = 'SQL';

-- Ejemplo con `OR`: Para combinar múltiples condiciones, donde al menos una debe ser verdadera.
-- Quiero las adalabers cuyo nombre es 'Ana' O su ciudad es 'Barcelona'.alter

SELECT * FROM adalabers 
WHERE nombre_completo = 'Ana' OR ciudad = 'Barcelona';


-- 5.4. **Actualizar Datos (UPDATE) - (UPDATE)**
-- La instrucción `UPDATE` nos permite modificar datos existentes en una tabla.
-- **ADVERTENCIA MUY IMPORTANTE: Si olvidas la cláusula `WHERE`, se actualizarán todos los registros de la tabla**.
-- MySQL Workbench tiene un modo seguro que lo impide por defecto.

-- No se puede usar un UPDATE o DELETE sin el WHERE
-- Si hacemos esto, se borra o elimina todos los datos de la tabla. 
-- MySQL Workbench tiene una opción que impide usar el UPDATE y el DELETE sin el WHERE.

-- Sintaxis Básica: `UPDATE nombre_tabla SET columna1 = nuevo_valor1 [, columna2 = nuevo_valor2, ...] WHERE condición;`

-- Ejemplo 1: Actualizar una única columna
UPDATE adalabers
SET telefono = '969829868976'
WHERE nombre_completo = 'Ana';

SELECT * FROM adalabers;


-- Ejemplo 2: Actualizar múltiples columnas a la vez
-- Para actualizar varios campos de un registro, separamos las asignaciones con comas en la cláusula `SET`.
UPDATE adalabers
SET ciudad = 'Canarias', permiso_redes_sociales = TRUE -- Cambia la ciudad y el permiso de redes sociales
WHERE nombre_completo = 'Iris';


-- Ejemplo 3: Actualizar usando el operador `IN`
-- El operador `IN` permite verificar si un valor está contenido en una lista de elementos.
-- Vamos a actualizar el permiso de rrss a False si la ciudad es Málaga o Barcelona.

UPDATE adalabers
SET permiso_redes_sociales = False 
WHERE ciudad IN ('Málaga', 'Barcelona'); -- Filtro para várias opciones para una misma columna


UPDATE adalabers
SET curso = 'Data Engineer'
WHERE nombre_completo != 'Iris'; -- <>



-- 5.5. **Eliminar Datos (DELETE) - (DELETE)**
-- La instrucción `DELETE` elimina registros específicos de una tabla.
-- **ADVERTENCIA MUY IMPORTANTE: ¡No olvides el `WHERE`! Si se omite esta cláusula,
-- se eliminarán todos los registros de la tabla, dejando la tabla vacía**.

-- Sintaxis Básica: `DELETE FROM nombre_tabla WHERE condición;`

-- Ejemplo: Eliminar un registro específico
DELETE FROM adalabers
WHERE correo = 'marta@adalab.es';


SELECT * FROM adalabers;


-- Caso de error común: `DELETE` sin `WHERE`.
-- Si ejecutas esto, se borrarán todos los datos de la tabla. **¡NO EJECUTAR A MENOS QUE SEA INTENCIONAL!**
-- DELETE FROM adalabers;





















CREATE TABLE IF NOT EXISTS adalabers (
	id_adalaber INT AUTO_INCREMENT PRIMARY KEY, 
    nombre_completo VARCHAR(30) NOT NULL, 
    apellido VARCHAR(30) NOT NULL,
    ciudad VARCHAR(60), 
    correo VARCHAR(100) UNIQUE, 
    telefono VARCHAR(15), 
    curso VARCHAR(50), 
    conocimientos_previos ENUM('Python', 'SQL', 'Excel', 'Ninguno'), 
    permiso_redes_sociales BOOLEAN, 
    fecha_registro DATE NOT NULL
);





