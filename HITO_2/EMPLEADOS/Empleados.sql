create database practica_empleados;
use practica_empleados;
drop table datos_empleados;
create table datos_empleados
(
    id_empleado int primary key not null,
    empleado varchar(20) not null,
    empresa varchar(20) not null,
    area varchar (20)not null
);
insert into datos_empleados(id_empleado, empleado, empresa,area)
values(1,'rodrigo','SAMSUNG','supervisor');
insert into datos_empleados(id_empleado, empleado, empresa,area)
values(2,'rolando','Oppo','administrador');
insert into datos_empleados(id_empleado, empleado, empresa,area)
values(3,'ronald','Huawei','diseñador');
insert into datos_empleados(id_empleado, empleado, empresa,area)
values(4,'jose','SAMSUNG','gerente');

select *  from datos_empleados
create table empleados
(
    id_emp int primary key not null,
    empleados varchar(20)
);
insert into empleados (id_emp, empleados)
values (1,'rodrigo');
insert into empleados (id_emp, empleados)
values (2,'rolando');
insert into empleados (id_emp, empleados)
values (3,'ronald');
insert into empleados (id_emp, empleados)
values (4,'jose');

select * from empleados;

create table empresa
(
    id_empre int primary key  not null,
    empresa varchar(20)
);
insert into empresa (id_empre, empresa)
values (1,'SAMSUNG');
insert into empresa (id_empre, empresa)
values (2,'Oppo');
insert into empresa (id_empre, empresa)
values (3,'Huawei');
insert into empresa (id_empre, empresa)
values (4,'SAMSUNG');

select * from empresa;

create table area
(
    id_are int primary key not null ,
    area varchar (20)
);
insert into area (id_are, area )
values (1,'supervisor');
insert into area (id_are, area )
values (2,'administrador');
insert into area (id_are, area )
values (3,'diseñador');
insert into area (id_are, area )
values (4,'gerente');

select * from area

