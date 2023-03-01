CREATE DATABASE hito_II;

CREATE DATABASE ejemplo;

drop database ejemplo;

create database caso1;
use caso1;

drop database caso1

create table nombre
(
    id_nombre int primary key not null,
    nombre varchar(100)not null,
    apellidos varchar(100) not null
);
insert into nombre(id_nombre, nombre, apellidos)
values (1,'william','barra');

insert into nombre(id_nombre, nombre, apellidos)
values (2,'rodrigo','torrez');

select * from nombre
drop database if exists caso1;

drop database UNIVERSIDAD

CREATE DATABASE UNIVERSIDAD;
USE UNIVERSIDAD

DROP TABLE ESTUDIANTES
DROP DATABASE UNIVERSIDAD

CREATE TABLE ESTUDIANTES
(
    ID_est integer auto_increment primary key not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    edad integer not null,
    fono integer not null,
    email varchar(50)not null

);
describe ESTUDIANTES;

insert into ESTUDIANTES (nombres, apellidos, edad, fono, email ) values

('NOMBRE1','APELLIDOS1','10','11111','USER1@GMAIL.COM'),
('NOMBRE2','APELLIDOS2','20','11111','USER2@GMAIL.COM'),
('NOMBRE3','APELLIDOS3','10','11111','USER3@GMAIL.COM');

#para ver ta tabla
select *from ESTUDIANTES

SELECT LAST_INSERT_ID();

ALTER TABLE ESTUDIANTES
    ADD COLUMN DIRECCION VARCHAR (200) DEFAULT 'EL ALTO';

#para añadir una columna
ALTER TABLE ESTUDIANTES
    ADD COLUMN FAX VARCHAR(10),
    ADD COLUMN GENERO VARCHAR (10);

# para llamar a una tabla
select *
    from ESTUDIANTES as est
where est.nombres = 'NOMBRE2';

#otra opcion
select est.nombres , est.apellidos, est.edad
    from ESTUDIANTES as est
where est.edad ='15';

#NOMBRES PARES(OTRA OPCION)
select est. *
    from ESTUDIANTES as est
where est.ID_EST % 2 = 0;
describe ESTUDIANTES;

#RELACION CON TABLAS

DROP TABLE estudiantes

CREATE TABLE estudiantes
(
    id_est integer auto_increment primary key not null,
    nombres varchar(10) not null,
    apellidos varchar(10) not null,
    edad integer not null,
    fono integer not null,
    email varchar (100) not null
)
select * from estudiantes
create table materias
(
    id_mat integer auto_increment primary key not null,
    nombre_mat varchar (100) not null,
    cod_mat varchar(100) not null
)
select *from materias
create table inscripcion
(
    id_ins integer auto_increment primary key  not null,
    id_est integer not null,
    id_mat integer not null,
    foreign key (id_est) references estudiantes(id_est),
    foreign key (id_mat) references materias(id_mat)
)
select *from inscripcion