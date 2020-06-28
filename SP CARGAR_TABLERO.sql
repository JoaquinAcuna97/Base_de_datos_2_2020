
 --cargar un tablero de burro
 CREATE OR REPLACE PROCEDURE CARGAR_TABLERO_BURRO (idTablero Tablero.id%TYPE) AS
     terreno VARCHAR2(1000):= '..................................................-......P.PPPPP.....PPPPPPP...........PP............-.........PPPPPPPPPPP.PPPPP..........PPP...........-...........PPPPPPPP.....PPP...........PP..........-..........PPPP..PPPP....................PP........-.........PPPP.T.PPPP..PPPPPPPPPPPPPPP..PPP........-........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-........PPPP.....PPPPPPPPPPPPPPPPPPP..............-..................PPPPPPPPPPPPPPPPPP..............-..................PPPPP....PPPPPPPPP..............-..................PPPPP........PP.PP..............-............W......PPP.......PPP.PPP..............-............PPPPBPPPPPPPPPPPPPPPPPPPPPPPP.........-AAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';

  BEGIN
     CARGAR_TABLERO (idTablero, terreno);
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
