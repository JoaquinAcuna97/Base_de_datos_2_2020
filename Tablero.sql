insert into TABLERO (id,X_columnas,Y_filas) values (1,50,15);

 --cargar un tablero de burro
CREATE OR REPLACE PROCEDURE CARGAR_TABLERO_BURRO (idTablero Tablero.id%TYPE) AS
    exec :terreno := '..........W.........R...............R.............-......P.PPPPP..R.WPPPPPPP...........PPR...........-.........PPPPPPPPPPP.PPPPP..........PPP...........-...........PPPPPPPP.....PPP...........PP..........-.........RPPPP..PPPP.....W......W.......PP........-.........PPPP.T.PPPP..PPPPPPPPPPPPPPPR.PPP........-........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-........PPPP.....PPPPPPPPPPPPPPPPPPP..............-..................PPPPPPPPPPPPPPPPPP..............-..................PPPPP....PPPPPPPPP..............-..................PPPPP........PP.PP..............-.............R.....PPP..W....PPP.PPP..W...........-.....R..W...PPPPPPPPPPPPPPPPPPPPPPPPPPPPP...W.....-AAAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTAAAAA-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
    exec CARGAR_TABLERO (idTablero, :terreno);
 BEGIN

 END;

 --cargar un tablero Cualquiera de 50*15
CREATE OR REPLACE PROCEDURE CARGAR_TABLERO (idTablero Tablero.id%TYPE, varTerreno VARCHAR2) AS
 --IDS NUMBER(8) := 0;
 contador NUMBER(8) := 0;
 --varTerreno VARCHAR2(1000);
 casilla VARCHAR2(1000);
 BEGIN
	FOR j IN 0..14 LOOP
		FOR i IN 0..49 LOOP
			contador := contador +1;
			casilla := substr(varTerreno,contador,1);
			--IF casilla=chr(13) OR casilla=chr(10) THEN
			IF casilla = '-' THEN
				contador := contador +1;
				casilla := substr(varTerreno,contador,1);
			END	IF;
			IF casilla in ('A','T','P','B','.','W','R','H','L')  THEN
				insert into CELDA (X_columna,Y_fila,contenido,tableroid)
				values (i,j,casilla,1);
				COMMIT;
			END IF;
		END LOOP;
    END LOOP;
 END;

 CREATE OR REPLACE PROCEDURE VER_TABLERO(idTablero Tablero.id%TYPE) IS
     casilla CHAR(1);
     CURSOR cursorTablero IS
         SELECT contenido, X_Columna, Y_Fila, id
           FROM CELDA
          WHERE TableroId = idTablero
          ORDER BY id;
     regTablero cursorTablero%ROWTYPE;
 BEGIN
     OPEN cursorTablero;
     FETCH cursorTablero INTO regTablero;
     WHILE cursorTablero%FOUND LOOP--Mientras existan datos
         IF regTablero.X_Columna = 49 THEN
           DBMS_OUTPUT.PUT(regTablero.Contenido);
           DBMS_OUTPUT.PUT_LINE('');
         ELSE
           DBMS_OUTPUT.PUT(regTablero.Contenido);
         END IF;
        FETCH cursorTablero INTO regTablero;
     END LOOP;
     CLOSE cursorTablero;
 END;
