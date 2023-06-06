create database Hito_4_2023;
use Hito_4_2023;
drop database Hito_4_2023;
#####################################################-HITO4-LABS_1######################################################

create table numeros
(
    numero bigint primary key not null,
    cuadrado bigint,
    cubo bigint,
    raix_cuadrada real,
    sumatodo bigint
);

insert into numeros(numero) values (2);
select * from numeros;

create or replace trigger tr_completa_datos
    before insert ###-----NEW
    on numeros
    for each row
    begin
        declare valor_cuadrado bigint;
        declare valore_cubo bigint;
        declare valore_raiz real;

        set valor_cuadrado = power(new.numero,2);
        set valore_cubo = power(new.numero,3);
        set valore_raiz = sqrt(new.numero);

        set new.cuadrado = valor_cuadrado;
        set new.cubo = valore_cubo;
        set new.raix_cuadrada = valore_raiz;
    end;

insert into numeros(numero) values (4);
select * from numeros;
#########################################EJERCICI1######################################################################
###ARREGLAR#########
create or replace trigger suma_total
    before insert ###-----NEW
    on numeros
    for each row
    begin
        declare valor_cuadrado, valor_cubo, suma_total bigint;
        declare valor_raiz real;


        set valor_cuadrado = power(new.numero,2);
        set valor_cubo = power(new.numero,3);
        set valor_raiz = sqrt(new.numero);


        set new.cuadrado = valor_cuadrado;
        set new.cubo = valor_cubo;
        set new.raix_cuadrada = valor_raiz;
        set new.sumatodo = NEW.cuadrado + new.cubo + new.raix_cuadrada + new.numero;
    end;

select power(2,4);
insert into numeros values (2);
select * from numeros;

##########################################EJERCICIO2####################################################################
drop table usuarios;

create table Usuarios(
 id_usu int auto_increment,
 nombre varchar(30),
 apellido varchar(30),
 edad int,
 correo varchar(30) not null,
 password varchar(30),
 primary key (id_usu)
);

create trigger before_usuarios_update
  before update
  on Usuarios
  for each row
begin
  insert into Usuarios(nombre, password) values (old.nombre, old.password);
end;

insert into Usuarios(nombre,password)
values ('William Barra 33','WiBa33');
select * from Usuarios;

#############################################################LABS2######################################################

drop trigger before_usuarios_update;
#····no se puede odificar un registro desde trigger
#cuando se esta insertando

# create or replace trigger tr_genera_password_aften
#     after insert
#     on usuarios
#     for each row
#     begin
#         update usuarios set password = concat(
#             substring(new.nombre,1,2),
#             substring(new.apellido,1,2),
#             new.edad)
#         where id_usu = last_insert_id();
#     end;

drop table usuarios1;

create table Usuarios1(
 Id_usr INTEGER auto_increment PRIMARY KEY NOT NULL ,
 Nombres varchar(30) NOT NULL,
 Apellidos varchar(30) NOT NULL ,
 Fecha_Nac DATE NOT NULL ,
 Correo varchar(30) not null,
 Password varchar(100),
 Edad int
);

CREATE OR REPLACE TRIGGER tr_calcula_pass_edad
BEFORE INSERT ON Usuarios1
FOR EACH ROW
BEGIN
    -- Generate a password based on the user's name and email
    SET NEW.password = LOWER(
        CONCAT(
            SUBSTRING(NEW.nombreS, 1, 2),
            SUBSTRING(NEW.apellidos, 1, 2),
            SUBSTRING(NEW.correo, 1, 2)
        )
    );
    SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.FECHA_NAC, CURDATE());
END;

DROP TRIGGER tr_calcula_pass_edad;

insert into usuarios1(nombres,apellidos,Fecha_Nac,Correo)
values('pepito', 'pep', '2000-06-20','pepitomaster234ga');

select * from usuarios1;

###PARA VER EN LA EDAD
# SELECT TIMESTAMPDIFF(YEAR,'2004-03-14', CURDATE()) AS EDAD;
# select CURRENT_DATE;

-- crear un trigger para la tabla usuario1 verofocar si el password tiene mas  de 10 caracteres si tiene mas de 10
-- caracteres dejar ese valor como esta caso contrario generar un password tomar los 2 ultimos caracteresdel nombre
-- apellido y la edad

drop trigger tr_verificar_password;
CREATE OR REPLACE TRIGGER tr_verificar_password
BEFORE INSERT ON Usuarios1
FOR EACH ROW
BEGIN
    SET NEW.edad = TIMESTAMPDIFF(YEAR, NEW.FECHA_NAC, CURDATE());
    IF CHAR_LENGTH(NEW.password) < 10 THEN
        SET NEW.password = CONCAT(

            SUBSTRING(NEW.nombreS, LENGTH(NEW.nombreS) - 2, 2),
            SUBSTRING(NEW.apellidos, LENGTH(NEW.apellidos) - 2, 2),
            NEW.edad
        );
    END IF;
END;

truncate usuarios1;

INSERT INTO Usuarios1 (nombreS, apellidos, FECHA_NAC, correo, password)
VALUES ('John', 'Doe', '1990-05-10', 'johndoe@example.com', '1234');

INSERT INTO Usuarios1 (nombreS, apellidos, FECHA_NAC, correo, password)
VALUES ('jose', 'maro', '1990-02-11', 'johndoe@example.com', 'password5467');

INSERT INTO Usuarios1 (nombreS, apellidos, FECHA_NAC, correo, password)
VALUES ('mario', 'jose', '1990-02-11', 'mario@jose.com', 'password5');

select dayname(current_date);



insert into usuarios1(nombres,apellidos,Fecha_Nac,Correo)
values('pepito', 'pep', '2000-06-20','pepitotope@gmail.com');

drop trigger tr_usuarios_mantenimiento;
create or replace trigger tr_usuarios_mantenimiento
    before insert
    on usuarios1
    for each row
    begin
        declare dia_de_la_semana text default '';
        set dia_de_la_semana = dayname(current_date);

        if dia_de_la_semana ='Wednesday'
            then
            signal sqlstate '45000'
            set message_text = 'lo siento papu la base de datos en mantenimiento vuelve al año que viene';
        end if;
    end;
-- w
alter table usuarios1 add column nacionalidad varchar(20);
select * from usuarios1;

########################################################################################################################
-- lab 3

create table usuarios_rrhh(
    id_usr integer primary key not null,
    nombre_completo varchar(50) not null,
    fecha_nac date not null ,
    correo varchar(100) not null ,
    password varchar(100)
);

create table audit_usuarios_rrhh(
    fecha_mod text not null,
    usuario_log text not null,
    histname text not null,
    accion text not null ,

    id_usr text not null,
    nombre_completo text not null,
    password text not null
);

insert into usuarios_rrhh(id_usr, nombre_completo, fecha_nac, correo, password)
values(123456,'william barra','1990-01-01','wb@gmail.com', '123456');

insert into usuarios_rrhh(id_usr, nombre_completo, fecha_nac, correo, password)
values(654321,'pepito','1990-01-01','pep@gmail.com', '123456');

select * from usuarios_rrhh;
select * from audit_usuarios_rrhh;

-- PERMITE VER LA FECHA ACUTUAL
SELECT CURRENT_DATE;

-- PERMITE VER FECHA Y HORA
SELECT NOW();

-- PERMITE VER A LOS USUARIOS LOGUEADA
SELECT USER();

-- ME PERMITE OBTENER EL HOSTNAME
SELECT @@HOSTNAME;

-- ESTE COMANDO PERMITE VER TODAS LAS VARIABLES DE LA BASE DE DATOS
SHOW VARIABLES ;

create trigger tr_audit_usuarios_rrhh
after delete
on usuarios_rrhh
for each row
begin
    declare id_usuario text;
    declare nombres text;
    declare usr_password text;

    set id_usuario= old.id_usr;
    set nombres= old.nombre_completo;
    set usr_password= old.password;

    insert into audit_usuarios_rrhh(fecha_mod, usuario_log, histname, accion, id_usr, nombre_completo, password)
        select now(), user(), @@HOSTNAME, 'DELETE',id_usuario, nombres, usr_password;

end;

create or replace trigger tr_audit_usuarios_rrhh1
after insert
on usuarios_rrhh
for each row
begin
    insert into audit_usuarios_rrhh(fecha_mod, usuario_log, histname, accion, id_usr, nombre_completo, password)
        select now(), user(), @@HOSTNAME, 'INSERT',new.id_usr, new.nombre_completo, new.password;
end;

-- CREAR UN TRIGGER UPDATE PARA LA TABLA USUARIOS_RRHH
-- AGREGAR 2 CAMPOS A DICIONALES
-- ANTES_DEL_CAMBIO = CONCAT(ID_USR - NOMBRE - FECHA_NAC)
-- DESPUES_DEL_CAMBIO = CONCAT(ID_USR - NOMBRE - FECHA_NAC)

create table audit_usuarios_rrhh1(
    fecha_mod text not null,
    usuario_log text not null,
    histname text not null,
    accion text not null ,

    antes_del_cambio text not null,
    despues_del_cambio text not null
);

-- Crear el trigger
CREATE OR REPLACE TRIGGER tr_audit_usuarios_rrhh1
AFTER UPDATE
ON usuarios_rrhh
FOR EACH ROW
BEGIN
     declare antes text default concat(OLD.id_usr, ' ', OLD.nombre_completo, OLD.correo);
    declare despues text default concat(OLD.id_usr, ' ', NEW.nombre_completo, NEW.correo);

    call inserta_datos(
        now(),
        user(),
        @@hostname,
        'UPDATE',
        antes,
        despues
        );
end;

select * from usuarios_rrhh;
select * from audit_usuarios_rrhh;


CREATE OR REPLACE PROCEDURE inserta_datos(
    fecha TEXT,
    usuario TEXT,
    hostname TEXT,
    accion TEXT,
    antes TEXT,
    despues TEXT
)
BEGIN

    INSERT INTO audit_usuarios_rrhh1 (fecha_mod, usuario_log, histname, accion, antes_del_cambio, despues_del_cambio)
    VALUES (fecha, usuario, hostname, accion, antes, despues);
END;

