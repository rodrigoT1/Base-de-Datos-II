create database recuperatorio;
use recuperatorio;

########################################################################################################################
###NUMEROS FIBONACCI
drop function numerosFibonacci;
########################################################################################################################
create function numerosFibonacci(numero int)
returns text
begin
    declare resp text default '';
    declare numeros int default 0;
    declare cont int default 1;
    declare nummerio1 int default 0;
    declare numero2 int default 1;

    while(numero >= cont) DO
        set resp = concat(resp,nummerio1,',');
        set numeros = nummerio1 + numero2;
        set cont = cont+1;
        set nummerio1 = numero2;
        set numero2 = numeros;
    end while;
    return resp;
end;
########################################################################################################################
select numerosFibonacci(6);######0,1,1,2,3,5,8
########################################################################################################################

########################################################################################################################
###LA SUMA DE LOS NUMEROS FIBONACCI
drop function sumFibonacci;

CREATE FUNCTION sumFibonacci(numero INT)
RETURNS INT
BEGIN
    DECLARE a INT DEFAULT 0;
    DECLARE b INT DEFAULT 1;
    DECLARE i INT DEFAULT 0;
    DECLARE c INT;
    DECLARE fib_sum INT DEFAULT 0;

    WHILE i < numero DO
          SET c = a + b;
          SET a = b;
          SET b = c;
          SET fib_sum = fib_sum + a;
          SET i = i + 1;
    END WHILE;
    RETURN fib_sum;
END;

########################################################################################################################
SELECT sumFibonacci(6); ###0,1,1,2,3,5,8 = 20
########################################################################################################################
#####LA MISMA SOLUCION PERO DIFERENTE

CREATE PROCEDURE generate_fibonacci(IN n INT)
BEGIN
    DECLARE a INT DEFAULT 0;
    DECLARE b INT DEFAULT 1;
    DECLARE i INT DEFAULT 0;
    DECLARE c INT;

    DROP TABLE IF EXISTS fibonacci;
    CREATE TABLE fibonacci (id INT AUTO_INCREMENT PRIMARY KEY, value INT);

    WHILE i < n DO
        SET c = a + b;
        SET a = b;
        SET b = c;
        INSERT INTO fibonacci (value) VALUES (a);
        SET i = i + 1;
    END WHILE;

    SELECT * FROM fibonacci;
END;

CALL generate_fibonacci(6);

SELECT SUM(value) FROM fibonacci;

