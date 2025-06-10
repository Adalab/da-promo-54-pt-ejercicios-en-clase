-- ***********************************************************************************
--  Creación de Tablas 🌟
--  Hoy nos enfocaremos en la creación de tablas, un aspecto fundamental para
--  organizar y gestionar nuestros datos de manera efectiva.
--  Aprenderemos sobre los tipos de datos, las restricciones que podemos aplicar
--  y cómo establecer relaciones entre tablas.
-- ***********************************************************************************


-- ***********************************************************************************
--  1. Comentarios en SQL y Mejores Prácticas
-- ***********************************************************************************

/*
Para añadir comentarios de varias líneas en SQL, se utiliza la sintaxis
barra y asterisco al principio, y asterisco y barra al final.
Todo lo que esté dentro de estos caracteres no se ejecutará como código.
*/

-- Para comentarios de una sola línea, se utilizan dos guiones y un espacio.
-- Si hay más texto en la misma línea después de los guiones, también será comentario.

SELECT * FROM categories; -- Esta sentencia lo que hace el seleccionar, etc.

-- Mejores prácticas en SQL:
-- Las palabras clave de SQL (como SELECT, FROM, CREATE, TABLE, etc) se escriben en Mayúsculas.
-- Los nombres de tablas, columnas y esquemas (que serían como variables) van en minúsculas. 
-- Cada fragmento o sentencia de código SQL termina siempre con un punto y coma >> ;



-- ***********************************************************************************
--  2. Creación y Uso de Esquemas (Bases de Datos)
-- ***********************************************************************************

-- Un esquema en SQL es como una carpeta dentro de una base de datos.
-- Organiza y agrupa tablas y otros objetos relacionados (vistas, índices, etc.).
-- Piensa en él como una forma de mantener todo organizado y separado dentro de tu base de datos.

-- ¿Por qué usar un esquema?
-- - Organización: Mantiene tablas y objetos organizados, especialmente con grandes cantidades de datos.
-- - Seguridad: Permite gestionar permisos de acceso para usuarios específicos.
-- - Claridad: Facilita la gestión y mantenimiento de la base de datos.

-- Sintaxis para crear un esquema:
-- CREATE SCHEMA nombre_del_esquema;
-- También es una buena práctica añadir 'IF NOT EXISTS' para evitar errores si el esquema ya existe.

CREATE SCHEMA IF NOT EXISTS promo_paola;

-- Sintaxis para usar o seleccionar un esquema:
-- USE nombre_del_esquema;
-- Al usar 'USE', MySQL entenderá que el código a continuación está referenciado a este esquema en particular.
-- Es importante usarlo porque si no estás en el esquema correcto, te dará error al crear tablas.
-- La conexión se pone en negrita en Workbench para indicar que está seleccionada.

USE promo_paola;

-- ***********************************************************************************
--  3. Creación de Tablas: Sentencia CREATE TABLE
-- ***********************************************************************************

-- La sentencia CREATE TABLE es el medio principal para definir la estructura de tus tablas.
-- Nos permite organizar nuestros datos en filas y columnas, como una hoja de cálculo.

-- Sintaxis básica de CREATE TABLE:
/*
CREATE TABLE nombre_tabla (
    nombre_columna1 tipo_de_dato1 restriccion1,
    nombre_columna2 tipo_de_dato2 restriccion2,
    nombre_columna3 tipo_de_dato3 restriccion3
);
*/

-- - nombre_tabla: El nombre que quieres darle a tu tabla (ej: 'clientes').
-- - nombre_columna: El nombre de cada columna (ej: 'nombre_cliente').
-- - tipo_de_dato: Qué tipo de datos va a almacenar esa columna (texto, números, fechas, etc.).
-- - restriccion: Reglas para asegurar que los datos se ingresen correctamente (ej: NOT NULL).
-- Cada columna se define en una línea separada, y al final de cada definición de columna (excepto la última)
-- se usa una coma. La sentencia completa termina con un punto y coma.

CREATE SCHEMA IF NOT EXISTS tienda_nueva;
USE tienda_nueva;

CREATE TABLE IF NOT EXISTS clientas (
	id_clienta INT PRIMARY KEY,
    nombre_clienta VARCHAR(50) NOT NULL,
    email_clienta VARCHAR(100), 
    fecha_registro DATE);


-- ***********************************************************************************
--  4. Tipos de Datos
-- ***********************************************************************************

-- Es crucial elegir los tipos de datos apropiados para garantizar que los datos
-- ingresados mantengan el formato esperado. Si usas el tipo de dato adecuado,
-- evitas errores y aseguras operaciones más fáciles y precisas.

-- 4.1. Tipos de Datos Numéricos
-- Se usan para guardar números, ya sean enteros o decimales. Cada uno ocupa una cantidad de memoria distinta.
-- Es importante elegir el que mejor se ajuste para optimizar el rendimiento y el almacenamiento.

-- SMALLINT: Para números enteros pequeños (ej: edad). Ocupa poco espacio (2 bytes).
-- MEDIUMINT: Para números enteros medianos (3 bytes).
-- INT o INTEGER: Más común para enteros, hasta 10 dígitos (4 bytes).
-- BIGINT: Para números muy grandes (hasta 19 dígitos) (8 bytes).
-- FLOAT: Para números decimales con baja precisión (4 bytes).
-- DOUBLE: Para decimales con más precisión (8 bytes).
-- BOOL o BOOLEAN: Para valores verdadero o falso (true/false). En SQL, 0 es Falso y cualquier otro valor es Verdadero.

-- Opciones adicionales para numéricos:
-- UNSIGNED: Evita que los números puedan ser negativos.
-- ZEROFILL: Rellena los números con ceros a la izquierda para completar el espacio.

-- 4. TIPOS DE DATOS NUMÉRICOS (EJEMPLOS EN UNA MISMA TABLA)
-- Esta tabla incluye una columna para cada tipo de dato numérico, con comentarios explicativos.
CREATE TABLE ejemplos_numericos (
    edad SMALLINT, -- Ideal para datos pequeños como edad (máx. 32,767)
    poblacion MEDIUMINT, -- Enteros medianos (ej. habitantes de una ciudad pequeña)
    ingresos INT, -- Enteros comunes (ej. salario)
    deuda BIGINT, -- Números muy grandes (ej. deuda nacional)
    promedio FLOAT, -- Decimales con precisión baja (ej. promedio de calificaciones, temperatura)
    interes DOUBLE, -- Decimales con mayor precisión (ej. tasa de interés, mediciones científicas)
    activo BOOLEAN, -- Verdadero o falso (1 o 0)
    puntos_positivos INT UNSIGNED, -- Solo permite valores positivos (ej. cantidad de stock)
    numero_con_zeros INT(5) ZEROFILL -- Muestra el número con ceros a la izquierda (En este caso un total de 5 números siendo que rellena con ceros a la izquierda. 42 se vería como 00042 al hacer el SELECT.)
);


-- 4.2. Tipos de Datos de Texto
-- Para almacenar palabras, frases o cualquier texto.

-- CHAR(tamaño): Para cadenas de texto de tamaño fijo. Si sabes que siempre ocupará un número exacto de caracteres.
--              Si la longitud del dato es menor que el tamaño especificado, se rellena con espacios.
--              Ej: DNI, sexo (H/M) si el tamaño es fijo.
-- VARCHAR(tamaño): El más utilizado. Para cadenas de texto de tamaño variable, con un número máximo de caracteres.
--                 Flexible, se usa mucho porque no ocupa espacio innecesario si el dato es más corto que el máximo.
--                 Ej: Nombre, dirección.
-- TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT: Para cadenas de texto de diferentes longitudes, sin necesidad de especificar un tamaño fijo.
-- ENUM(val1, val2, val3, ...): Ideal para listas de opciones predefinidas. Restringe los valores posibles a los especificados.
--                            Si se intenta insertar un valor fuera de las opciones, dará error.
--                            Ej: conocimientos_previos ('sin', 'poco', 'mucho'), colores ('rojo', 'amarillo', 'azul').

-- Importante: Para valores de texto, se usan comillas simples (''). Evitar comillas dobles.

-- =============================================
-- 4.2. TIPOS DE DATOS DE TEXTO (EJEMPLOS EN UNA MISMA TABLA)
-- Esta tabla muestra cómo usar los distintos tipos de datos de texto.

CREATE TABLE ejemplos_texto (
    codigo_char CHAR(5), -- Texto de longitud fija. Ej: 'A23' → se almacena como 'A23  '
    nombre_varchar VARCHAR(50), -- Texto de longitud variable. Ej: 'María López'
    descripcion_tinytext TINYTEXT, -- Texto corto. Ej: 'Texto corto'
    comentario_text TEXT, -- Texto de hasta 65k caracteres. Ej: 'Comentario extenso...'
    historia_mediumtext MEDIUMTEXT, -- Texto hasta 16 millones de caracteres. Ej: 'Historia larga...'
    libro_longtext LONGTEXT, -- Texto muy largo. Ej: 'Texto de libro completo simulado...'
    conocimientos_previos ENUM('sin', 'poco', 'mucho'), -- Lista predefinida. Ej: 'mucho'
    color_preferido ENUM('rojo', 'amarillo', 'azul') -- Lista predefinida. Ej: 'rojo'
);



-- 4.3. Tipos de Datos de Fecha y Hora
-- Para guardar fechas o tiempos.

-- DATE: Guarda fechas en formato AAAA-MM-DD (Año-Mes-Día).
-- TIME: Guarda horas en formato HH:MM:SS (Hora:Minuto:Segundo).
-- DATETIME: Combina fecha y hora en formato AAAA-MM-DD HH:MM:SS.
-- YEAR: Guarda solo el año.

-- =============================================
-- 4.3. TIPOS DE DATOS DE FECHA Y HORA (EJEMPLOS EN UNA MISMA TABLA)
-- Esta tabla muestra cómo usar los distintos tipos de datos temporales.

CREATE TABLE ejemplos_fecha (
    fecha_nacimiento DATE, -- Fecha en formato AAAA-MM-DD. Ej: '1990-05-20'
    hora_entrada TIME, -- Hora en formato HH:MM:SS. Ej: '08:30:00'
    fecha_registro DATETIME, -- Fecha y hora completa. Ej: '2024-03-15 14:45:00'
    anio_fundacion YEAR -- Solo el año. Ej: 2001
);


-- ***********************************************************************************
--  5. Restricciones de Columna y Tabla
-- ***********************************************************************************

-- Las restricciones son reglas que se aplican a las columnas y/o tablas para asegurar la validez e integridad de los datos.

-- 5.1. Restricciones Comunes

-- NOT NULL: Indica que una columna no puede contener valores nulos o vacíos.
--           Ej: un nombre de cliente no puede faltar.
-- PRIMARY KEY: Identifica de manera única cada registro en una tabla.
--              Las columnas Primary Key NO pueden contener valores nulos y deben ser ÚNICOS.
--              Normalmente, se usa una columna "ID" que se auto-incrementa para esto.
-- UNIQUE: Garantiza que todos los valores en una columna sean únicos.
--         A diferencia de la Primary Key, SÍ permite valores nulos.
--         Ej: Un correo electrónico de un suscriptor debe ser único, pero podría no tenerlo.
-- AUTO_INCREMENT: Usado con tipos numéricos (generalmente INT) y PRIMARY KEY.
--                 Rellena la columna automáticamente con números incrementales (1, 2, 3...).
-- DEFAULT: Establece un valor predeterminado para la columna si no se especifica uno al insertar un registro.
--          Ej: 'sin datos' para una dirección vacía.
-- CONSTRAINT CHECK (condición): Permite especificar una condición que debe cumplir cada valor en la columna.
--                               Normalmente se usa con la cláusula CONSTRAINT para darle un nombre a la condición.
--                               Ej: Asegurar que el precio de un producto sea mayor que cero.




-- =============================================
-- 5.1. RESTRICCIONES COMUNES (EJEMPLOS EN UNA TABLA)
-- Esta tabla ilustra cómo aplicar las restricciones más usadas en SQL.

CREATE TABLE ejemplos_restricciones (
    id INT PRIMARY KEY AUTO_INCREMENT, -- Clave primaria única, autoincremental. Ej: 1, 2, 3...
    nombre_cliente VARCHAR(100) NOT NULL, -- No puede ser nulo. Ej: 'Ana Torres'
    email_cliente VARCHAR(100) UNIQUE, -- Debe ser único, pero puede ser nulo. Ej: 'ana@mail.com'
    direccion VARCHAR(200) DEFAULT 'sin datos', -- Valor por defecto si no se proporciona. Ej: 'sin datos'
    precio_producto INT,
    CONSTRAINT chk_precio_positivo CHECK (precio_producto > 0) -- El precio debe ser mayor que 0. Ej: 25
);


-- ***********************************************************************************
--  6. Ejemplos de Creación de Tablas
-- ***********************************************************************************

CREATE TABLE IF NOT EXISTS productos (
	id_producto INT PRIMARY KEY AUTO_INCREMENT, 
    nombre VARCHAR(100) NOT NULL, 
    color ENUM('rojo', 'amarillo', 'verde') NOT NULL, 
    precio FLOAT CHECK (precio > 0), 
    stock INT CHECK (stock >= 0)
);


-- ***********************************************************************************
--  7. Relaciones entre Tablas: Claves Foráneas (FOREIGN KEY)
-- ***********************************************************************************

-- Una clave foránea (FOREIGN KEY) es una columna (o conjunto de columnas) en una tabla
-- que se utiliza para crear una relación con otra tabla.
-- Esta clave actúa como un "puente" entre dos tablas, apuntando a la clave primaria de la "tabla madre".

-- Beneficios de usar Claves Foráneas:
-- - Integridad Referencial: Asegura que los datos en la "tabla hija" correspondan a datos válidos en la "tabla madre".
-- - Relaciones entre Tablas: Permite conectar datos de diferentes tablas para consultas más complejas y mejor organización.

-- Para establecer una clave foránea, la "tabla madre" (a la que se hace referencia) debe existir primero.

-- Sintaxis para definir una Clave Foránea:
/*
FOREIGN KEY (nombre_columna_en_tabla_hija)
REFERENCES nombre_tabla_madre(nombre_columna_primary_key_en_madre)
[ON DELETE opcion_referencia]
[ON UPDATE opcion_referencia]
*/
-- La cláusula FOREIGN KEY (columna) se pone al final de la definición de la tabla.

-- Opciones para ON DELETE / ON UPDATE:
-- - RESTRICT: (Por defecto) Rechaza la eliminación/actualización si hay filas relacionadas en la tabla hija.
-- - CASCADE: Si se elimina/actualiza una fila en la tabla madre, la acción se refleja en cascada en la tabla hija.
--            Es muy común usar ON DELETE CASCADE y ON UPDATE CASCADE para mantener la coherencia.
-- - SET NULL: Al eliminar/actualizar una fila en la tabla madre, la columna correspondiente en la tabla hija se establece en NULL.


-- =============================================
-- Ejemplo de Clave Foránea
-- Relaciona 'empleadas' con 'departamentos'

-- Tabla principal: 'departamentos'
CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY,                    -- ID único del departamento
    nombre_departamento VARCHAR(100) NOT NULL           -- Nombre obligatorio del departamento
);

-- Tabla secundaria: 'empleadas'
CREATE TABLE empleadas (
    id_empleada INT AUTO_INCREMENT PRIMARY KEY,         -- ID de la empleada (único, autoincremental)
    nombre VARCHAR(100) NOT NULL,                       -- Nombre obligatorio de la empleada
    id_departamento INT,                                -- Columna que relaciona con la tabla 'departamentos'

    FOREIGN KEY (id_departamento)                       -- Declaramos la clave foránea directamente
        REFERENCES departamentos(id_departamento)       -- Indica que se relaciona con 'departamentos.id_departamento'
        ON DELETE SET NULL                              -- Si se borra un departamento, deja esta columna en NULL
        ON UPDATE CASCADE                               -- Si cambia el ID del departamento, se actualiza aquí también
);


-- Creamos la tabla 'categorias' (la tabla madre para 'peliculas')
CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,        -- ID de la categoría (Primary Key)
    nombre_categoria VARCHAR(100) NOT NULL              -- Nombre de la categoría
);

-- Creamos la tabla 'peliculas' (la tabla hija que tendrá una Foreign Key a 'categorias')
CREATE TABLE IF NOT EXISTS peliculas (
    id_pelicula INT AUTO_INCREMENT PRIMARY KEY,         -- ID de la película (Primary Key)
    nombre VARCHAR(200) NOT NULL,                       -- Nombre de la película, no nulo
    id_categoria INT NOT NULL,                          -- ID de la categoría (será la Foreign Key)
    duracion INT,                                       -- Duración en minutos (entero)
    disponibilidad BOOLEAN DEFAULT FALSE,               -- Disponibilidad (true/false), por defecto false

    -- Definición de la Clave Foránea
    -- Esta columna 'id_categoria' hace referencia a 'id_categoria' en la tabla 'categorias'
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
    ON DELETE CASCADE ON UPDATE CASCADE                 -- Si la categoría se borra o actualiza, se refleja en películas
);




