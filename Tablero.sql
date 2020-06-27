

 insert into TABLERO (id,X_columnas,Y_filas) values (1,50,15);

--cargar un tablero
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
 						IF casilla in ('A','T','P','B','.','W','R','H','L')  THEN
 								ids := ids +1;
 								insert into CELDA (id,X_columna,Y_fila,contenido,tableroid)
 								values (ids,i,j,casilla,1);

             END IF;
 			END LOOP;
     END LOOP;
     commit;
 END;


 CREATE OR REPLACE PROCEDURE VER_TABLERO(idTablero Tablero.id%TYPE) IS
     casilla CHAR(1);
     CURSOR cursorTablero IS
         SELECT contenido, X_Columna, Y_Fila
           FROM CELDA
          WHERE TableroId = idTablero;
     regTablero cursorTablero%ROWTYPE;
 BEGIN
     OPEN cursorTablero;
     FETCH cursorTablero INTO regTablero;
     WHILE cursorTablero%FOUND LOOP--Mientras existan datos
         IF regTablero.X_Columna = 49 THEN
             DBMS_OUTPUT.PUT_LINE(regTablero.Contenido);
         ELSE
             DBMS_OUTPUT.PUT(regTablero.Contenido);
         END IF;
        FETCH cursorTablero INTO regTablero;
     END LOOP;
     CLOSE cursorTablero;
 END;
