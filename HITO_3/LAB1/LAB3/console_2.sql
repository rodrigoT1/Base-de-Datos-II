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

select pares_imapres(8);

#####labs2#####################################################
####MANEJO DE REPEAT##################################

CREATE FUNCTION manejo_de_repeat(x int)
returns text
begin
    declare respuesta text default ''; -- respuesta = ''
    repeat
     -- logica
        set respuesta= concat(respuesta,x,', ');
     set x=x-1;
    until x<=0 END repeat;
    return respuesta;
end;

select manejo_de_repeat(10);

#####10, 9, 8, 7, 6, 5, 4, 3, 2, 1
###################################################################################################################
#####10--AA-- 9--BB-- 8--AA-- 7--BB-- 6--AA-- 5--BB-- 4--AA-- 3--BB-- 2--AA-- 1--BB--

CREATE FUNCTION manejo_de_repeat_v2(x int)
returns text
begin
    declare respuesta text default ''; -- respuesta = ''
    repeat
        iF x%2=0 THEN
        set respuesta= concat(respuesta,x , ' -AA- ');
        ELSE
        SET respuesta=CONCAT(respuesta, X , ' -BB- ');
        END IF;
     set x=x-1;
    until x<=0 END repeat;
    return respuesta;
end;

select manejo_de_repeat_v2(10);
######################################################################################################
create function manejo_loop(x int )
    returns text
    begin
        declare str text default '';
        loop_lavel: loop
            if x > 0
                then
                leave loop_lavel;
            end if;
            set str=concat(str, x, ',');
            set x = x + 1;
            iterate loop_lavel;
        end loop;
        return str;
    end;

select manejo_loop(-10);

###########################################################guvdf###################

create function manejo_loop_v3(x int )
    returns text
    begin
        declare str text default '';
        loop_lavel: loop
            if x > 0
                then
                leave loop_lavel;
            end if;
            iF x%2=0 THEN
        set str= concat(str,x , ' -AA- ');
        ELSE
        SET str=CONCAT(str, X , ' -BB- ');
        END IF;
            set str=concat(str, x, ',');
            set x = x + 1;
            iterate loop_lavel;
        end loop;
        return str;
    end;

select manejo_loop_v3(-10);

###################################lab l3#################################################

CREATE OR REPLACE FUNCTION cliente_estado_2(x integer)
returns text
BEGIN
    DECLARE respuesta TEXT DEFAULT ',';

        if x > 10000 THEN SET respuesta  = 'PLATINIUM';
        end if;
        if x >= 10000 AND x <=  50000 THEN
                   SET respuesta  = 'GOLD';
        end if;
        if x < 10000 THEN
            SET respuesta  = 'SILVER';
        end if;

    RETURN respuesta;
end;

SELECT cliente_estado_2(9999);

#############################################################################################

create function valida_length_7(password int)
returns text
begin
    declare resp text default '';
    if char_length(password) > 7 then
        set resp = 'PASSED';
        else
        set resp = 'FAILED';
    end if;
    RETURN resp;
end;

select valida_length_7('12345678');
############################################
##comparacion de cadenas
##el objetivo es saber si 2 cadenas son iguales

select strcmp('BDAII', 'bdaii2023');

create function uso_de_strcmp(cad1 TEXT,cad2 TEXT)
returns text
begin
    declare resp text default '';
    if STRCMP(cad1,cad2) =7 then
        set resp = 'cadenas iguales';
        else
        set resp = 'cadenas distintas';
    end if;
    RETURN resp;
end;
select uso_de_strcmp('bdaii','bdaii2023');

############################################################################################
create function funciones_anteriores(cad1 TEXT,cad2 TEXT)
returns text
begin
    declare resp text default '';
    declare cadenaTotal text default '';

    if char_length(cadenaTotal) > 15  and STRCMP(cad1,cad2) =0  then
        set resp = 'cadenas iguales';
        else
        set resp = 'cadenas distintas';
    end if;
    RETURN resp;
end;
select uso_de_strcmp('10','10');

###################################################################
#######ejercicios1##############################
create function comparar_y_Verifica(cad1 text, cad2 text)
returns text
begin
    declare respuesta text default '';
    declare cadenaTotal text default '';

    set cadenaTotal = concat(cad1,cad2);
    if char_length(cadenaTotal) > 15 and strcmp(cad1, cad2)=0 then
        set respuesta= 'valido carnal ';
        else
        set respuesta= 'no valido carnal verificao de nuevo';
    end if;
    return respuesta;
end;

select comparar_y_Verifica('BDAII-2023', 'bdaii-2023');

###############################################MANEJO DE SUBESTRING################################################
#BDAII 2023 unifranz
#2023

## cortara cualquiera pondremos 7 de ejemplo
# que en este caso solo dira 2023 Unifranz :)
select substr('BDAII 2023 Unifranz', 7);
select substr('hola', 1);

#solo que diga lo del medio en este caso 2023
select substr('BDAII 2023 Unifranz', 7 , 4);

### otra manera
select substr('BDAII 2023 Unifranz' from 7 for 4);

### lo mismo pero desde hacia atras
#desde la derecha
select substr('BDAII 2023 Unifranz',1,1);

#####MANEJO DE
#####BASE DE DATOS II, gestion 2023 Unifranz
#27
select locate('2023', 'BASE DE DATOS II, gestion 2023 Unifranz');
select locate('2023', 'BASE DE DATOS II, gestion 2023 Unifranz 2023',30);



create function ejercicio_de_LP(par1 text, par2 text)
returns text
begin

    declare respuesta text default '';
    declare buscar int default locate(par2,par1);

    if locate(par2, par1) >0 then
        set respuesta= concat('si existe: ', buscar);
        else
        set respuesta = 'no existe';
    end if;
    return respuesta;
end;
select ejercicio_de_LP('699349LP','LP');

#################Bucles############################

create function concatenar_numeros(numLimit integer)
returns text
begin
    declare cont int default 0;
    declare respuesta text default '';
    while cont <= numLimit DO
        set respuesta=concat(respuesta, cont,',');
        set cont = cont + 2;
    end while;
    return respuesta;
end;

#############################CORREGIR
create function concatenar_letra(cad1 TEXT ,limite int)
returns text
begin

    declare resp text default '';

    while limite >=0 do
    set resp= concat(resp, cad1, '-');
    set limite=limite - 1;
    end while;
    return resp;
end;
SELECT concatenar_letra('hola','3')