create database hito_3_2023;
use hito_3_2023;
drop database hito_3_2023;

#####crear una variable####################
set @usuario ='GUEST';
set @locacion ='EL ALTO';

##############mostrar la variable##################
select @usuario;
select @locacion;

#################crear una funcion ##################
CREATE FUNCTION variable()
returns TEXT
BEGIN
    return @usuario;
end;

select variable();

################## mostar las funciones de Maria DB########################
SHOW variables;

###crear una variable global de nombre hito 3 a esta variable asignarle el valor ADMIN
###CREAR UNA FUNCION QUE MANEJE ESTA VARIABLE GLOBAL LA FUNCION VERIFICA LOS SIGUIENTES
###SI EL VALOR DE LA VARIABLE GLOBAL ES ADMIN RETORNAR UN MENSAJE QUE DIGA "USUARIO ADMIN"

set @hito_3 ='ADMIN';

CREATE FUNCTION VALIDA_USUARIO()
returns varchar(50)
begin
    declare respuesta varchar(50);
        if @hito_3 = 'admin' THEN
       SET RESPUESTA ='USUARIO ADMIN';
        ELSE
       SET respuesta='USUARIO INVITADO';
        END IF;
    RETURN respuesta;
end;

select VALIDA_USUARIO();

###### con el metodo CASE#############
CREATE FUNCTION VALIDA_USUARIO_v2()
returns varchar (50)
begin
    declare respuesta varchar (50);
    case @hito_3
        when 'admin' then set respuesta = 'usuario admin';
        else set respuesta='usuario invitado';
    end case;
    return respuesta;
end;

select VALIDA_USUARIO_v2();

####
#########bucles###### GENERAR LOS PRIMEROS NUMEROS 10 NUMEROS NATURALES#######

CREATE FUNCTION NUMEROS_NATURALES(limite int)
RETURNS  TEXT
BEGIN
    DECLARE cont int default 1;
    declare respuesta text default '';
    while cont <= limite DO
        set respuesta= concat(respuesta, cont, ',');
        set cont = cont +1;
    end while;
    return respuesta;
end;

select NUMEROS_NATURALES(20);

create FUNCTION NUMEROS_NATURALES_v2(limite int)
RETURNS  TEXT
BEGIN
    DECLARE cont int default 2;
    declare respuesta text default '';
    while cont <= limite DO
        set respuesta= concat(respuesta, cont, ',');
        set cont = cont + 2;
    end while;
    return respuesta;
end;

select NUMEROS_NATURALES_v2(10);

####estaria quemando#######
create function numeros_desordenado(limite int)
returns text
begin
    declare cont int default 0;
    declare respuesta text default '';
    while cont <= limite DO
        set respuesta=concat(respuesta, cont, '2 , 1 , 4 , 3 , 6 , 5, 8 , 7');
        set cont = cont + 4;
    end while;
    return respuesta;
end;
select numeros_desordenado(3);

##para que aparesca este estos nuermos######
###'2,1,4,3,6,5,8,7'###3

CREATE FUNCTION pares_imapres(limite int)
returns text
begin
    declare pares int default 2;
    declare impares int default 1;
    declare cont int default 1;
    declare respuesta TEXT default '';
    while cont <= limite DO
        if cont % 2 = 1 THEN
            set respuesta=concat(respuesta, pares, ' , ');
            set pares =pares + 2;
            else
            set respuesta = concat( respuesta, impares , ' , ');
            set impares=impares + 2;
        end if;
        set cont= cont +1;
        end while;
    return respuesta;
end;

select pares_imapres(8)