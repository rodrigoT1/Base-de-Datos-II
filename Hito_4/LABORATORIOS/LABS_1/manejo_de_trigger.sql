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