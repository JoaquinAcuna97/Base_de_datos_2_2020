
DROP TABLE CELDA;
DROP TABLE TABLERO;
--
--
--
 CREATE TABLE TABLERO(
 	id 		number(12)	not null primary key,
 	X_columnas	 number(2) not null,
 	Y_filas		 number(2) not null
 );
 CREATE TABLE CELDA(
 	id 		number(12)	not null primary key,
     X_columna	 number(2) not null,
 	Y_fila	 number(2) not null,
     contenido 	char(1) 	not null check (contenido in ('A','T','P','B','.') ),
 	tableroid 	number(12)	not null references TABLERO
 );


 insert into TABLERO (id,X_columnas,Y_filas) values (1,50,15);
 commit;
--
--
-- --cargar un tablero
-- 
CREATE OR REPLACE PROCEDURE CARGAR_TABLERO (idTablero Tablero.id%TYPE) AS
 IDS NUMBER(8) := 0;
 contador NUMBER(8) := 0;
 terreno VARCHAR2(1000) :='
..................................................
......P.PPPPP.....PPPPPPP...........PP............
.........PPPPPPPPPPP.PPPPP..........PPP...........
...........PPPPPPPP.....PPP...........PP..........
..........PPPP..PPPP....................PP........
.........PPPP.T.PPPP..PPPPPPPPPPPPPPP..PPP........
........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........
........PPPP.....PPPPPPPPPPPPPPPPPPP..............
..................PPPPPPPPPPPPPPPPPP..............
..................PPPPP....PPPPPPPPP..............
..................PPPPP........PP.PP..............
...................PPP.......PPP.PPP..............
............PPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........
TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
 casilla VARCHAR2(1000);
 BEGIN
   		FOR j IN 0..14 LOOP
 			  FOR i IN 0..49 LOOP
 						contador := contador +1;
             casilla := substr(terreno,contador,1);
 						IF casilla=chr(13) OR casilla=chr(10) THEN
 							contador := contador +1;
 							casilla := substr(terreno,contador,1);
 						END	IF;
 						IF casilla in ('A','T','P','B','.')  THEN
 								ids := ids +1;
 								insert into CELDA (id,X_columna,Y_fila,contenido,tableroid)
 								values (ids,i,j,casilla,1);
 								commit;
             END IF;
 			END LOOP;
     END LOOP;
     --RETURN 0;
 END;


CREATE OR REPLACE PROCEDURE VER_TABLERO (idtablero Tablero.id%TYPE) AS
casilla CHAR(1);
--i NUMBER(2,0);
--j NUMBER(2,0);
BEGIN
    --DBMS_OUTPUT.PUT_LINE('Start');
   		FOR j IN 0..14 LOOP
 			  FOR i IN 0..49 LOOP
                        --DBMS_OUTPUT.PUT_LINE('Loop: '||i||j);
 						SELECT contenido
                        INTO casilla
                          FROM CELDA
                         WHERE tableroid = idtablero
                           AND x_columna = i AND y_fila = j;
                        IF i = 49 THEN
                            DBMS_OUTPUT.PUT_LINE(casilla);
 						ELSE
                            DBMS_OUTPUT.PUT(casilla);
                        END	IF;
 			END LOOP;
     END LOOP;
--     EXCEPTION
--     WHEN NO_DATA_FOUND THEN
--     DBMS_OUTPUT.PUT_LINE('Error tablero: '||i||j);
 END;
