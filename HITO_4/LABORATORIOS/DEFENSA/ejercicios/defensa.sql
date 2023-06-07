create database tarea12_defensa;
use tarea12_defensa;
DROP DATABASE tarea12_defensa;

-- Crear tabla Departamento
CREATE TABLE Departamento (
  id_dep INT PRIMARY KEY,
  nombre VARCHAR(100)
);

-- Crear tabla Provincia
CREATE TABLE Provincia (
  id_prov INT PRIMARY KEY,
  nombre VARCHAR(100),
  id_dep INT,
  FOREIGN KEY (id_dep) REFERENCES Departamento (id_dep)
);


-- Crear tabla Persona
CREATE TABLE Persona (
  id_per INT PRIMARY KEY,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  fecha_nac DATE,
  edad INT,
  email VARCHAR(100),
  id_dep INT,
  id_prov INT,
  sexo CHAR(1),
  FOREIGN KEY (id_dep) REFERENCES Departamento (id_dep),
  FOREIGN KEY (id_prov) REFERENCES Provincia (id_prov)
);

-- Crear tabla Proyecto
CREATE TABLE Proyecto (
  id_proy INT PRIMARY KEY,
  nombreProy VARCHAR(100),
  tipoProy VARCHAR(100)
);

-- Crear tabla Detalle_proyecto
CREATE TABLE Detalle_proyecto (
  id_dp INT PRIMARY KEY,
  id_per INT,
  id_proy INT,
  FOREIGN KEY (id_per) REFERENCES Persona (id_per),
  FOREIGN KEY (id_proy) REFERENCES Proyecto (id_proy)
);

-- Insertar datos en la tabla Departamento
INSERT INTO Departamento (id_dep, nombre)
VALUES (1, 'El Alto'),
       (2, 'La Paz'),
       (3, 'Cochabamba');

select * from departamento;

-- Insertar datos en la tabla Provincia
INSERT INTO Provincia (id_prov, nombre, id_dep)
VALUES (1, 'Pedro Domingo Murillo	', 1),
       (2, 'Pacajes	', 1),
       (3, 'Larecaja	', 2);

select * from provincia;

-- Insertar datos en la tabla Persona
INSERT INTO Persona (id_per, nombre, apellido, fecha_nac, edad, email, id_dep, id_prov, sexo)
VALUES (1, 'Ana', 'González', '2000-10-10', 23, 'Ana@Gonzalez.com', 1, 1, 'F'),
       (2, 'Pedro', 'López', '1995-05-10', 28, 'pedro@Lopez.com', 1, 2, 'M'),
       (3, 'Emeth', 'Brount', '1885-01-20', 36, 'Emeth@Brount.com', 2, 3, 'M');

select * from persona;

-- Insertar datos en la tabla Proyecto
INSERT INTO Proyecto (id_proy, nombreProy, tipoProy)
VALUES (1, 'carretera', 'infractryctura'),
       (2, 'educacion digital', 'educacion'),
       (3, 'educacion', 'unidada');

select * from proyecto;

-- Insertar datos en la tabla Detalle_proyecto
INSERT INTO Detalle_proyecto (id_dp, id_per, id_proy)
VALUES (1, 1, 1),
       (2, 2, 2),
       (3, 3, 1);

select * from detalle_proyecto;


-- PARTE PRACTICA

-- EJERCICIO 10

-- 10. Crear una función que genere los numeros serie Fibonacci.
CREATE FUNCTION generar_fibonacci(n INT)
RETURNS VARCHAR(1000)
BEGIN
  DECLARE respuesta VARCHAR(1000);
  DECLARE cont INT;
  DECLARE cont1 INT;
  DECLARE fib INT;
  DECLARE i INT;

  SET respuesta = '';
  SET cont = 1;
  SET cont1 = 0;
  SET i = 0;

  WHILE i < n DO
    SET respuesta = CONCAT(respuesta, cont, ',');

    SET fib = cont;
    SET cont = cont + cont1;
    SET cont1 = fib;

    SET i = i + 1;
  END WHILE;
  SET respuesta = LEFT(respuesta, LENGTH(respuesta) - 1); 
  RETURN respuesta;
END;

SELECT generar_fibonacci(9) AS fibonacci_sequence;

-- EJERCICIO 10.1

-- crear una funcion que sume los numeros fibonacci
CREATE FUNCTION sumar_fibonacci(n INT)
RETURNS INT
BEGIN
  DECLARE fib_current INT;
  DECLARE fib_previous INT;
  DECLARE fib_temp INT;
  DECLARE suma INT;
  DECLARE i INT;

  SET fib_current = 1;
  SET fib_previous = 0;
  SET suma = 0;
  SET i = 0;

  WHILE i < n DO
    SET suma = suma + fib_current;

    SET fib_temp = fib_current;
    SET fib_current = fib_current + fib_previous;
    SET fib_previous = fib_temp;

    SET i = i + 1;
  END WHILE;

  RETURN suma;
END;

SELECT sumar_fibonacci(9) AS suma_fibonacci;

#EJERCICIO 11

-- Manejo de vistas.

CREATE VIEW Vista_Personas AS
SELECT CONCAT(Persona.nombre, ' ', Persona.apellido) AS nombres_apellidos,
       Persona.edad,
       Persona.fecha_nac,
       Proyecto.nombreProy AS nombre_proyecto
FROM Persona
JOIN Detalle_proyecto ON Persona.id_per = Detalle_proyecto.id_per
JOIN Proyecto ON Detalle_proyecto.id_proy = Proyecto.id_proy;

SELECT * FROM Vista_Personas;

SELECT CONCAT(Persona.nombre, ' ', Persona.apellido) AS nombres_apellidos,
       Persona.edad,
       Persona.fecha_nac,
       Proyecto.nombreProy AS nombre_proyecto
FROM Persona
JOIN Departamento ON Persona.id_dep = Departamento.id_dep
JOIN Detalle_proyecto ON Persona.id_per = Detalle_proyecto.id_per
JOIN Proyecto ON Detalle_proyecto.id_proy = Proyecto.id_proy
WHERE Persona.sexo = 'F' AND
      Departamento.nombre = 'El Alto' AND
      Persona.fecha_nac = '2000-10-10';


-- EJERCICIO 12
-- Manejo de TRIGGERS I.

-- Agregar el nuevo campo "ESTADO" a la tabla "Proyecto"
ALTER TABLE Proyecto
ADD COLUMN ESTADO VARCHAR(10);

DROP TRIGGER before_insert_proyecto;
DROP TRIGGER before_update_proyecto;

-- Trigger 1: Se ejecuta antes de insertar un nuevo registro en la tabla
CREATE TRIGGER before_insert_proyecto
BEFORE INSERT ON PROYECTO
FOR EACH ROW
BEGIN
    IF NEW.tipoProy IN ('EDUCACION', 'FORESTACION', 'CULTURA') THEN
        SET NEW.ESTADO = 'ACTIVO';
    ELSE
        SET NEW.ESTADO = 'INACTIVO';
    END IF;
END;

SELECT *,
    CASE
        WHEN tipoProy IN ('EDUCACION', 'FORESTACION', 'CULTURA') THEN 'ACTIVO'
        ELSE 'ACTIVOS'
    END AS ESTADO
FROM PROYECTO;

-- Trigger 2: Se ejecuta antes de actualizar un registro existente en la tabla
CREATE TRIGGER before_update_proyecto
BEFORE UPDATE ON PROYECTO
FOR EACH ROW
BEGIN
    IF NEW.tipoProy IN ('EDUCACION', 'FORESTACION', 'CULTURA') THEN
        SET NEW.ESTADO = 'ACTIVO';
    ELSE
        SET NEW.ESTADO = 'INACTIVO';
    END IF;
END;

SELECT *,
    CASE
        WHEN tipoProy IN ('EDUCACION', 'FORESTACION', 'CULTURA') THEN 'ACTIVO'
        ELSE 'INACTIVO'
    END AS ESTADO
FROM PROYECTO;

-- EJERCICIO 13

-- Manejo de Triggers II.
CREATE TRIGGER calculaEdad
BEFORE INSERT ON PERSONA
FOR EACH ROW
BEGIN
    DECLARE birth_date DATE;
    DECLARE age INT;

    SET birth_date = NEW.fecha_nac;
    SET age = TIMESTAMPDIFF(YEAR, birth_date, CURDATE());

    IF DATE_FORMAT(birth_date, '%m%d') > DATE_FORMAT(CURDATE(), '%m%d') THEN
        SET age = age - 1;
    END IF;

    SET NEW.edad = age;
END;

SELECT *,
    TIMESTAMPDIFF(YEAR, fecha_nac, CURDATE()) -
    (DATE_FORMAT(CURDATE(), '%m%d') < DATE_FORMAT(fecha_nac, '%m%d')) AS edad
FROM PERSONA;

-- EJERCICIO 14

-- Manejo de TRIGGERS III.
CREATE TABLE copia_persona (
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  fecha_nac DATE,
  edad INT,
  email VARCHAR(100),
  id_dep INT,
  id_prov INT,
  sexo CHAR(1)
);

INSERT INTO copia_persona (nombre, apellido, fecha_nac, edad, email, id_dep, id_prov, sexo)
VALUES ('Maria', 'Flores', '1887-10-11', 21, 'Maria@Flores.com', 1, 1, 'F'),
       ('George', 'Mcfly', '1995-05-10', 36, 'George@Mcfly.com', 1, 2, 'M'),
       ('Aylin', 'Luna', '2000-04-05', 29, 'Aylin@Luna.com', 2, 3, 'F');

CREATE TRIGGER before_insert_persona
BEFORE INSERT ON Persona
FOR EACH ROW
BEGIN
  INSERT INTO copia_persona (nombre, apellido, fecha_nac, edad, email, id_dep, id_prov, sexo)
  VALUES (NEW.nombre, NEW.apellido, NEW.fecha_nac, NEW.edad, NEW.email, NEW.id_dep, NEW.id_prov, NEW.sexo);
END;

SELECT * FROM copia_persona;

-- EJERCICIO 15

-- Crear una consulta SQL que haga uso de todas las tablas.
-- Ejecutar consulta
SELECT CONCAT(Persona.nombre, ' ', Persona.apellido) AS nombres_apellidos,
       Persona.edad,
       Persona.fecha_nac,
       Proyecto.nombreProy AS nombre_proyecto
FROM Persona
JOIN Detalle_proyecto ON Persona.id_per = Detalle_proyecto.id_per
JOIN Proyecto ON Detalle_proyecto.id_proy = Proyecto.id_proy;

-- Crear vista
CREATE VIEW Vista_Personas AS
SELECT CONCAT(Persona.nombre, ' ', Persona.apellido) AS nombres_apellidos,
       Persona.edad,
       Persona.fecha_nac,
       Proyecto.nombreProy AS nombre_proyecto
FROM Persona
JOIN Detalle_proyecto ON Persona.id_per = Detalle_proyecto.id_per
JOIN Proyecto ON Detalle_proyecto.id_proy = Proyecto.id_proy;

CREATE PROCEDURE obtenerSuma(IN numero1 INT, IN numero2 INT, OUT suma INT)
BEGIN
    SET suma = numero1 + numero2;
END






