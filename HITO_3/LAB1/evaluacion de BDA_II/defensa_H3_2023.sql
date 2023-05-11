create database defensa_hito3_2023;
use defensa_hito3_2023;

########################################################################################################################

drop function elilimar_consonantes_y_numero;

create function elilimar_consonantes_y_numero(cadena1 varchar(20), cadena2 varchar(20))
returns text
begin
    declare respuesta text default'';
    declare cont int default 1;
    declare nuevacadena varchar(100) default concat(cadena1,'-', cadena2);
    declare puntero char;

    while cont <= char_length(nuevacadena)DO
        SET puntero= SUBSTR(nuevacadena,cont,1);
        if puntero !='B' and puntero !='S' and puntero !='D' AND puntero !='T' AND puntero!='I' THEN
            SET respuesta = CONCAT(respuesta,puntero);
            IF (puntero='')then
                set respuesta=concat(respuesta,'');
            end if;
        end if;
        set cont = cont - 1;
    end while;
    return respuesta;
end;

select elilimar_consonantes_y_numero('BASE DE DATOS','2023');


drop table CLIENTES;

create table CLIENTES(
    id_cliente int auto_increment primary key,
    fullname varchar(20),
    last_name varchar(20),
    age int not null,
    genero varchar(20) not null
);

insert into CLIENTES(FULLNAME, LAST_NAME, AGE, GENERO)
value('Rodrigo','Torrez',18,'masculino'),
    ('camila','quisbet',19,'femenino'),
    ('fernanda','flores',17,'femenino');

select * from CLIENTES;

create function edadMaxima()
returns int
begin
    declare RESP int default 0;
    select max(age) into RESP from CLIENTES;
    return RESP;
end;

DROP FUNCTION EDADMAXIMA1;
DROP FUNCTION edadMaxima;


create function EDADMAXIMA1()
returns text
begin
    declare resp text default ``;
    declare par  int default 0;
    declare impar int default edadMaxima();

    if edadMaxima() %2=0 then
        repeat
          if(par %2=0) then
              set resp = concat(resp,par,',');
          end if;
          set par = par + 2;
        until par > edadMaxima() end repeat;

        imapres:loop
            if impar < 0 then
                leave imapres;
            end if;

            if impar %2 !=0 then
                set resp = concat(resp,impar,',');
            end if;

            set impar = impar -1;

            iterate imapres;
        end loop;
    end if;
    return resp;
end;

select EDADMAXIMA1();


create function numeroFibonacci(numero int)
returns text
begin
    declare resp text default '';
    declare numero int default 0;
    declare cont int default 1;
    declare numero1 int default 0;
    declare numero2 int default 1;

    while(numero >= cont)do
        set resp= concat(resp,numero1,',');
        set numero= numero1+numero2;
        set cont = cont +1;
        set numero1= numero2;
        set numero2 = numero;
    end while;
    return resp;
end;

select numeroFibonacci(5);

DROP FUNCTION reemplaza_palabras;

create function reemplaza_palabras(cadena1 varchar(100),remplazar varchar(100), nuevacadena varchar(100))
returns text
begin
    declare respuesta text default '';
    declare cont int default 1;
    declare Ncadena varchar(100) default concat(cadena1,'-', remplazar,'-',nuevacadena);
    declare puntero char;

    while cont <= char_length(Ncadena)DO
        SET puntero= SUBSTR(Ncadena,cont,1);
        if puntero !='B' and puntero !='S' and puntero !='D' AND puntero !='T' AND puntero!='I' THEN
            SET respuesta = CONCAT(respuesta,puntero);
            IF (puntero='')then
                set respuesta=concat(respuesta,'');
            end if;
        end if;
        set cont = cont - 1;
    end while;
    return respuesta;
end;

select reemplaza_palabras('Bienvenidops a UNIFRANZ, UNIFRANZ tiene 10 carreras','UNIFRANZ','UNIVALLE');

DROP function concatenar_letra;

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
SELECT concatenar_letra('hola','3');


select reverse('hola');


create or replace function reemplazarlaspalabraz(cadena1 text, cadena2 text, cadena3 text)
returns text
begin
    declare resp text default ``;
    declare cont int default 0;
    declare cadena text default concat(cadena1,cadena2,cadena3);
    declare puntero char;

    while cont <= char_length(cadena) do
        set puntero= substring(cadena,cont,1);
        if puntero='Bienvenidos a unifranz, unifranz tiene 10 carreas' then
            set cont = cont +1;
            else if puntero= ' unifranz ' then
                set cont = cont +1;
                set resp = concat(resp,puntero,' ');
                else if puntero = 'univalle' then
                    set cont = cont +1;
                    set resp = concat(resp,puntero);
                end if;
            end if;
        end if;
    end while;
    return resp;
end;

select replace('Bienvenidos a unifranz, unifranz tiene 10 carreas');