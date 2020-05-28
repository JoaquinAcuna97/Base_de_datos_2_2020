-- DROP TABLE CELDA;
-- DROP TABLE TABLERO;
--
--
--
-- CREATE TABLE TABLERO(
-- 	id 		number(12)	not null primary key,
-- 	X_columnas	 number(2) not null,
-- 	Y_filas		 number(2) not null
-- );
-- CREATE TABLE CELDA(
-- 	id 		number(12)	not null primary key,
--     X_columna	 number(2) not null,
-- 	Y_fila	 number(2) not null,
--     contenido 	char(1) 	not null check (contenido in ('A','T','P','B','.') ),
-- 	tableroid 	number(12)	not null references TABLERO
-- );
--
--
-- insert into TABLERO (id,X_columnas,Y_filas) values (1,50,15);
-- commit;
--
--
-- --cargar un tablero
--
-- DECLARE
-- IDS NUMBER(8) := 0;
-- contador NUMBER(8) := 0;
-- terreno VARCHAR2(1000) :='
-- ..................................................
-- ......P.PPPPP.....PPPPPPP...........PP............
-- .........PPPPPPPPPPP.PPPPP..........PPP...........
-- ...........PPPPPPPP.....PPP...........PP..........
-- ..........PPPP..PPPP....................PP........
-- .........PPPP.T.PPPP..PPPPPPPPPPPPPPP..PPP........
-- ........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........
-- ........PPPP.....PPPPPPPPPPPPPPPPPPP..............
-- ..................PPPPPPPPPPPPPPPPPP..............
-- ..................PPPPP....PPPPPPPPP..............
-- ..................PPPPP........PP.PP..............
-- ...................PPP.......PPP.PPP..............
-- ............PPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........
-- TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
-- AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
-- casilla VARCHAR2(1000);
-- BEGIN
--   		FOR j IN 0..14 LOOP
-- 			  FOR i IN 0..49 LOOP
-- 						contador := contador +1;
--             casilla := substr(terreno,contador,1);
-- 						IF casilla=chr(13) OR casilla=chr(10) THEN
-- 							contador := contador +1;
-- 							casilla := substr(terreno,contador,1);
-- 						END	IF;
-- 						IF casilla in ('A','T','P','B','.')  THEN
-- 								ids := ids +1;
-- 								--dbms_output.put_line('POSICIONX '||MOD(ids,50)||'POSICIONY '||MOD(ids,15)||' caracter '||casilla);
-- 								insert into CELDA (id,X_columna,Y_fila,contenido,tableroid)
-- 								values (ids,i,j,casilla,1);
-- 								commit;
-- 								--dbms_output.put_line('caracter '||casilla);
--             END IF;
-- 			END LOOP;
--     END LOOP;
-- END;
--

--ver un tablero
DECLARE
    --Cursor con cantidad de postulaciones de una oferta
    CURSOR cursorx  (idtablero NUMBER) IS
        SELECT contenido, X_columna,id,Y_fila
        FROM CELDA
        WHERE tableroid = idtablero order by id;


--Variables para trabajar con una fila espec�fica de un cursor
unaPos cursorx%ROWTYPE;

BEGIN
--Se abre el cursor de celdas y se obtiene la primera fila
    OPEN cursorx(1);
    FETCH cursorx INTO unaPos;
    WHILE cursorx%FOUND LOOP --Mientras existan celdas
        IF unaPos.X_columna = 49  THEN
      --  DBMS_OUTPUT.PUT_LINE( '['||unaPos.X_columna || ']['||unaPos.Y_fila || ']'||chr(13)||chr(10));
        DBMS_OUTPUT.PUT_LINE(unaPos.contenido);
        ELSE
				DBMS_OUTPUT.PUT(unaPos.contenido);
      --  DBMS_OUTPUT.PUT('['||unaPos.X_columna || ']['||unaPos.Y_fila || '] . ');
        END IF;
        FETCH cursorx INTO unaPos;
    END LOOP;
    CLOSE cursorx;
END;
