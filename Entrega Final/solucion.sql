/*//DROPEO Y CREACION DE TABLAS//*/
DROP TABLE CELDA;
DROP TABLE TABLERO;
DROP TABLE ARMASJUGADOR;
DROP TABLE JUGADOR;
DROP TABLE GUSANO;
DROP TABLE EQUIPO;
DROP TABLE PARTIDA;
DROP TABLE ARMA;

CREATE TABLE ARMA(
	idArma NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key ,
	nombre VARCHAR2(100) UNIQUE NOT NULL,
	danio int NOT NULL,
	grupo VARCHAR2(5)
);

CREATE TABLE PARTIDA(
	idPartida NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	duracion NUMBER(2) NOT NULL CHECK( duracion IN(15, 20, 25)),
	turno NUMBER(2) NOT NULL CHECK(turno =30),
	dificultad VARCHAR(50) NOT NULL CHECK(dificultad IN ('Facil', 'Intermedio', 'Dificil')),
	estado VARCHAR2(50) NOT NULL CHECK( estado IN ('CARGANDO', 'INICIADA', 'FINALIZADA')),
	cantEquipos NUMBER(1) default 0
);

CREATE TABLE EQUIPO(
	idEquipo NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	nombre VARCHAR(100) NOT NULL,
	letra VARCHAR(1) UNIQUE NOT NULL CHECK(letra IN ('W', 'R', 'L', 'H')),
	derrotas NUMBER(10),
	victorias NUMBER(10),
	idPartida NUMBER(10) NOT NULL REFERENCES PARTIDA  ON DELETE CASCADE,
	cantGusanos NUMBER(1) default 0,
	CONSTRAINT unique_equipo_partida UNIQUE(letra, idPartida)
);

CREATE TABLE GUSANO(
	idGusano NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	salud NUMBER(3) NOT NULL CHECK(salud >=0 AND salud <= 100),
	idEquipo NUMBER(10) NOT NULL REFERENCES EQUIPO  ON DELETE CASCADE,
	accion VARCHAR(50) CHECK (accion IN ('Caminar', 'Saltar')),
	nombre VARCHAR(50)
);

CREATE TABLE JUGADOR(
	idJugador NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	Nombre VARCHAR2(200),
	Tipo VARCHAR(20) CHECK(Tipo IN ('Humano', 'IA')),
	idEquipo NUMBER(10)  REFERENCES EQUIPO  ON DELETE SET NULL
);

CREATE TABLE ARMASJUGADOR(
	idjugador_armasjugador NUMBER NOT NULL REFERENCES JUGADOR ON DELETE SET NULL,
	idarma_armasjugador NUMBER NOT NULL REFERENCES ARMA ON DELETE SET NULL,
	CONSTRAINT unique_arma_jugador UNIQUE(idjugador_armasjugador, idarma_armasjugador)
);

 CREATE TABLE TABLERO(
 	id 		number(12) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
 	X_columnas	 number(2) not null CHECK (X_columnas =50),
 	Y_filas		 number(2) not null CHECK (Y_filas =15),
	idPartida NUMBER(10) NOT NULL REFERENCES PARTIDA  ON DELETE CASCADE
 );

 CREATE TABLE CELDA(
	id NUMBER(12) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	X_columna number(2) NOT NULL,
	Y_fila NUMBER(2) NOT NULL,
	contenido char(1) NOT NULL CHECK (contenido in ('A','T','P','B','.','W','R','L','H')),
	tableroid NUMBER(12) NOT NULL REFERENCES TABLERO ON DELETE CASCADE,
	idGusano NUMBER(10) REFERENCES GUSANO
 );
 
/*CREACION DE TRIGGERS*/
CREATE OR REPLACE TRIGGER unJugadorHumano
BEFORE INSERT OR UPDATE ON PARTIDA
FOR EACH ROW
DECLARE varExisteHumano VARCHAR(1);
BEGIN
    BEGIN
        SELECT Letra
          INTO varExisteHumano
          FROM EQUIPO e
          JOIN JUGADOR j ON j.idEquipo = e.idEquipo
         WHERE idPartida = :new.idPartida
           AND j.Tipo = 'Humano';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            varExisteHumano := NULL;
    END;
	IF varExisteHumano IS NULL AND :new.Estado = 'INICIADA' THEN
		raise_application_error(-20003,'Error: La partida debe contener al menos un jugador humano');
	END IF;
END unJugadorHumano;--OK
/
CREATE OR REPLACE TRIGGER gusanoMuereContactoAgua
BEFORE UPDATE ON CELDA
FOR EACH ROW
DECLARE varIdGusano VARCHAR(1);
BEGIN
	IF :OLD.Contenido = 'A' THEN
		SELECT idGusano
		  INTO varIdGusano
		  FROM GUSANO g
		 WHERE g.idGusano = :new.idGusano;
	END IF;
  IF varIdGusano IS NOT NULL THEN
        UPDATE GUSANO
           SET salud = 0
         WHERE GUSANO.idGusano = :new.idGusano;
        :new.contenido := 'A';
		:new.idGusano := NULL;
	END IF;
END gusanoMuereContactoAgua;--OK
/
CREATE OR REPLACE TRIGGER gusanoSoloEnAire
BEFORE UPDATE ON CELDA
FOR EACH ROW
BEGIN
	IF :NEW.Contenido IN ('W', 'R', 'L', 'H') THEN
    IF :OLD.Contenido IN ('P', 'T', 'W', 'R', 'L', 'H') AND :OLD.Contenido != :new.Contenido THEN
      raise_application_error(-20003,'Error: un gusano solo puede ir en el aire');
    END IF;
	END IF;
END gusanoSoloEnAire;
/
CREATE OR REPLACE TRIGGER explosionCaja
BEFORE UPDATE ON CELDA
FOR EACH ROW
DECLARE varIdGusano VARCHAR(1);
BEGIN
	IF :OLD.Contenido = 'B' THEN
		SELECT idGusano
		  INTO varIdGusano
		  FROM GUSANO g
		 WHERE g.idGusano = :new.idGusano;
	END IF;
	IF varIdGusano IS NOT NULL THEN
		UPDATE GUSANO
		   SET salud = 0
		 WHERE GUSANO.idGusano = :new.idGusano;
		:new.Contenido := '.';
		:new.idGusano := NULL;
	END IF;
END explosionCaja;--OK
/
CREATE OR REPLACE TRIGGER jugadorSeleccionaMaxTreintaArmas
BEFORE INSERT OR UPDATE ON ARMASJUGADOR
FOR EACH ROW
DECLARE varCantidadArmas NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO varCantidadArmas
       FROM ARMASJUGADOR
      WHERE idjugador_armasjugador = :new.idjugador_armasjugador;
	IF varCantidadArmas >= 30 THEN
		raise_application_error(-20001,'Error: Los equipos solo pueden tener un máximo de 30 Armas');
	END IF;
END jugadorSeleccionaMaxTreintaArmas;--OK
/
CREATE OR REPLACE TRIGGER FK_VALIDA_GUSANO
BEFORE UPDATE OR INSERT ON CELDA
FOR EACH ROW
DECLARE
BEGIN
    IF :new.Contenido NOT IN ('W', 'R','L','H') AND :new.idGusano IS NOT NULL THEN
        raise_application_error(-20010, 'No se puede asignar una FK a un contenido que no corresonde a un equipo.');
    END IF;
END FK_VALIDA_GUSANO;
/
CREATE OR REPLACE TRIGGER maximoGusanosPorEquipoInsert
BEFORE INSERT ON GUSANO
FOR EACH ROW
DECLARE
    varValorInicial NUMBER;
BEGIN
    SELECT cantGusanos
      INTO varValorInicial
      FROM EQUIPO
     WHERE equipo.idEquipo = :new.idEquipo;
    IF varValorInicial >= 8 THEN
        raise_application_error(-20001,'Error: Los equipos solo pueden tener un máximo de 8 gusanos');
    ELSE
        UPDATE EQUIPO
           SET cantGusanos = cantGusanos + 1
         WHERE idEquipo = :new.idEquipo;
    END IF;
END maximoGusanosPorEquipoInsert;
/
CREATE OR REPLACE TRIGGER maximoGusanosPorEquipoUpdate
BEFORE UPDATE ON GUSANO
FOR EACH ROW
DECLARE
    varValorInicial NUMBER;
BEGIN
    SELECT cantGusanos
      INTO varValorInicial
      FROM EQUIPO
     WHERE equipo.idEquipo = :new.idEquipo;
    IF :new.idEquipo != :old.idEquipo THEN
        --Disminuir cantidad equipo anterior
        UPDATE EQUIPO
           SET cantGusanos = cantGusanos - 1
         WHERE equipo.idEquipo = :old.idEquipo;
        --Aumentar cantidad equipo nuevo
        UPDATE EQUIPO
           SET cantGusanos = cantGusanos + 1
         WHERE equipo.idEquipo = :new.idEquipo;
    END IF;
END maximoGusanosPorEquipoUpdate;
/
CREATE OR REPLACE TRIGGER maximoGusanosPorEquipoDelete
AFTER DELETE ON GUSANO
FOR EACH ROW
DECLARE
    varValorInicial NUMBER;
BEGIN
    UPDATE EQUIPO
       SET cantGusanos = cantGusanos - 1
     WHERE idEquipo = :old.idEquipo;
END maximoGusanosPorEquipoDelete;

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
 
 /*-------------------------------------------------------------------------------------------*/
CREATE OR REPLACE PROCEDURE CARGAR_TABLERO_BURRO (idTablero Tablero.id%TYPE) AS
   terreno VARCHAR2(1000):= '..................................................-......P.PPPPP.....PPPPPPP...........PP............-.........PPPPPPPPPPP.PPPPP..........PPP...........-...........PPPPPPPP.....PPP...........PP..........-..........PPPP..PPPP....................PP........-.........PPPP.T.PPPP..PPPPPPPPPPPPPPP..PPP........-........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-........PPPP.....PPPPPPPPPPPPPPPPPPP..............-..................PPPPPPPPPPPPPPPPPP..............-..................PPPPP....PPPPPPPPP..............-..................PPPPP........PP.PP..............-............W......PPP.......PPP.PPP..............-............PPPPBPPPPPPPPPPPPPPPPPPPPPPPP.........-AAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';

BEGIN
   CARGAR_TABLERO (idTablero, terreno);
END;

/*-------------------------------------------------------------------------------------------*/
create or replace NONEDITIONABLE PROCEDURE VER_TABLERO(idTablero Tablero.id%TYPE) IS
    casilla CHAR(1);
    varColumnaMax NUMBER;
--DECLARE
    CURSOR cursorTablero IS
        SELECT contenido, X_Columna, Y_Fila
          FROM CELDA
         WHERE TableroId = idTablero
         ORDER BY id;
    regTablero cursorTablero%ROWTYPE;
BEGIN
    SELECT X_Columnas - 1
      INTO varColumnaMax
      FROM TABLERO
      WHERE id = idTablero;
    OPEN cursorTablero;
    FETCH cursorTablero INTO regTablero;
    WHILE cursorTablero%FOUND LOOP--Mientras existan datos
        IF regTablero.X_Columna = varColumnaMax THEN
            DBMS_OUTPUT.PUT_LINE(regTablero.Contenido);
        ELSE
            DBMS_OUTPUT.PUT(regTablero.Contenido);
        END IF;
       FETCH cursorTablero INTO regTablero;
    END LOOP;
    CLOSE cursorTablero;
END;

/*CREACION DE PROCEDIMIENTOS*/
create or replace NONEDITIONABLE PROCEDURE CARGAR_FK_GUSANOS(idTablero NUMBER, partidaId NUMBER) IS
    varCantGusanos NUMBER;
    varCantLetras NUMBER;
    CURSOR cursorTablero IS
        SELECT id--, x_columna, y_fila, contenido, tableroId
          FROM CELDA
         WHERE tableroId = idTablero
           AND contenido IN ('W','R','L','H')
         ORDER BY contenido;
        regTablero cursorTablero%ROWTYPE;
    CURSOR cursorGusanos IS
        SELECT g.idGusano--, e.Letra
          FROM gusano g
          JOIN equipo e ON e.idEquipo = g.idEquipo
         WHERE e.idPartida = partidaId
         ORDER BY e.letra;
    regGusanos cursorGusanos%ROWTYPE;
BEGIN
    SELECT count(id)
      INTO varCantLetras
      FROM CELDA
     WHERE idTablero = 1
       AND contenido IN ('W','R','L','H')
     ORDER BY contenido;

    SELECT count(g.idGusano)
      INTO varCantGusanos
      FROM gusano g
      JOIN equipo e ON e.idEquipo = g.idEquipo
     WHERE e.idPartida = partidaId
     ORDER BY e.Letra;

    IF varCantGusanos <> varCantLetras THEN
        raise_application_error(-20202,'Error: La cantidad de gusanos existentes, no coinciden con el de la partida');
    END IF;

    OPEN cursorTablero;
    OPEN cursorGusanos;
    FETCH cursorTablero INTO regTablero;
    FETCH cursorGusanos INTO regGusanos;
    WHILE cursorTablero%FOUND AND cursorGusanos%FOUND LOOP
        UPDATE CELDA
           SET idGusano = regGusanos.idGusano
         WHERE id = regTablero.id;
         COMMIT;
        FETCH cursorTablero INTO regTablero;
        FETCH cursorGusanos INTO regGusanos;
    END LOOP;
    CLOSE cursorTablero;
    CLOSE cursorGusanos;
END;

 /*-------------------------------------------------------------------------------------------*/
create or replace NONEDITIONABLE PROCEDURE SALTO_BUNGEE(idTablero NUMBER, Columna NUMBER, Fila NUMBER, gusanoId NUMBER) IS
    v_Equipo CHAR(1);
    continuar BOOLEAN := TRUE;
    --v_contenido CHAR(1);
    CURSOR cursorFilas IS
        SELECT Contenido, X_Columna, Y_Fila
          FROM CELDA
        WHERE TableroId = idTablero
          AND X_Columna = Columna
          AND Y_Fila >= Fila;
    regFila cursorFilas%ROWTYPE;
	noDesplaza EXCEPTION;
BEGIN
    SELECT e.letra
      INTO v_Equipo
      FROM EQUIPO e
      JOIN GUSANO g ON g.idEquipo = e.idEquipo
       AND g.idGusano = gusanoId
    ;
    OPEN cursorFilas;
    FETCH cursorFilas INTO regFila;
    IF regFila.Contenido IN ('A','B') THEN
        UPDATE CELDA
           SET idGusano = NULL
         WHERE tableroId = idTablero
           AND idGusano = gusanoId;
        UPDATE CELDA
           SET Contenido = v_Equipo
         WHERE TableroId = idTablero
           AND X_Columna =  regFila.X_Columna
           AND Y_Fila = regFila.Y_Fila;
        continuar := FALSE;
    ELSIF regFila.Contenido = '.' THEN
        FETCH cursorFilas INTO regFila;
        WHILE cursorFilas%FOUND AND continuar LOOP
            IF regFila.Contenido IN ('P','T') THEN
                UPDATE CELDA
				   SET idGusano = NULL
                     , contenido = '.'
				 WHERE tableroId = idTablero
				   AND idGusano = gusanoId;
                UPDATE CELDA
                   SET Contenido = v_Equipo,
                       idGusano = gusanoId
                 WHERE tableroId = idTablero
                   AND Y_Fila = regFila.Y_Fila-1
                   AND X_Columna = regFila.X_Columna;
                continuar := FALSE;
            ELSIF regFila.Contenido IN ('B', 'A') THEN
                UPDATE CELDA
				   SET idGusano = NULL,
                       contenido = '.'
				 WHERE tableroId = idTablero
				   AND idGusano = gusanoId;
				UPDATE CELDA
                   SET Contenido = v_Equipo,
                       idGusano = gusanoId
                 WHERE tableroId = idTablero
                   AND Y_Fila = regFila.Y_Fila
                   AND X_Columna = regFila.X_Columna;
                continuar := FALSE;
            ELSIF regFila.Contenido <> '.' THEN
                RAISE noDesplaza;
            END IF;
            FETCH cursorFilas INTO regFila;
        END LOOP;
        CLOSE cursorFilas;
    ELSE
		RAISE noDesplaza;
    END IF;
	COMMIT;
	EXCEPTION
	WHEN noDesplaza THEN
		DBMS_OUTPUT.PUT_LINE('Error: No se puede realizar el desplazamiento');
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - Mensaje: ' || SQLERRM);
    ROLLBACK;
END;

/*-------------------------------------------------------------------------------------------*/
CREATE OR REPLACE NONEDITIONABLE PROCEDURE SOLTAR_BURRO(idTablero NUMBER, Columna NUMBER, equipoId NUMBER) IS
    varMaxColumnaTablero NUMBER(2);
    varMaxFilaTablero NUMBER(2);
    columnaInicial NUMBER(2);
    contenidoCelda VARCHAR(1);
    varGusanoId NUMBER(10);
    varEquipoId NUMBER(10);
    varColumnaFin NUMBER(2);
	varEstadoPartida VARCHAR(20);
    excFueraRango EXCEPTION;
    excPartidaNoIniciada EXCEPTION;
BEGIN
    SELECT X_Columnas-1, Y_Filas-1
      INTO varMaxColumnaTablero, varMaxFilaTablero
      FROM TABLERO
     WHERE id = idTablero;
    SELECT estado
      INTO varEstadoPartida
      FROM PARTIDA p
      JOIN EQUIPO e ON e.idPartida = p.idPartida
     WHERE e.idEquipo = equipoId;
    IF varEstadoPartida <> 'INICIADA' THEN
        RAISE excPartidaNoIniciada;
    END IF;
    IF columna < 0 OR columna > varMaxColumnaTablero THEN
        RAISE excFueraRango;
		--Raise_Application_Error(-20003, 'Valor de columna fuera del rango del tablero');
    END IF;
    columnaInicial :=columna;
    IF (varMaxColumnaTablero - columna) < 5 THEN
        columnaInicial := varMaxColumnaTablero - 5;
    END IF;
    varColumnaFin := columnaInicial+4;
    FOR fila IN 0..varMaxFilaTablero LOOP
        FOR col IN columnaInicial..varColumnaFin LOOP
            SELECT contenido
              INTO contenidoCelda
              FROM CELDA
             WHERE Y_Fila = fila
               AND X_Columna = col
               AND tableroId = idTablero;
            IF contenidoCelda IN ('P','T','B') THEN
                UPDATE CELDA
                   SET contenido = '.'
                 WHERE tableroId = idTablero
                   AND Y_Fila = fila
                   AND X_Columna = col;
            ELSIF contenidoCelda IN ('W','R','L','H') THEN
                SELECT g.idGusano, e.idEquipo
                  INTO varGusanoId, varEquipoId
                  FROM CELDA c
                  JOIN GUSANO g ON g.idGusano = c.idGusano
                  JOIN EQUIPO e ON e.idEquipo = g.idEquipo
                 WHERE tableroId = idTablero
                   AND Y_Fila = fila
                   AND X_Columna = col
                   ;
                --Matar gusano
                UPDATE GUSANO
                   SET salud = 0
                 WHERE idGusano = varGusanoId;
                --Aumenta contador de derrotas
                UPDATE EQUIPO
                   SET derrotas = derrotas + 1
                 WHERE idEquipo = varEquipoId;
                --Aumento victorias del equipo que lanzó el burro
                UPDATE EQUIPO
                   SET victorias = victorias + 1
                 WHERE idEquipo = equipoId;
                --Modifico contenido a aire
                UPDATE CELDA
                   SET contenido = '.',
                       idGusano = NULL
                 WHERE tableroId = idTablero
                   AND Y_Fila = fila
                   AND X_Columna = col;
            END IF;
        END LOOP;
    END LOOP;
	COMMIT;
    EXCEPTION
        WHEN excPartidaNoIniciada THEN
            DBMS_OUTPUT.PUT_LINE('Error: La partida debe estar en estádo iniciada para poder soltar burro');
		WHEN excFueraRango THEN
			DBMS_OUTPUT.PUT_LINE('Error: Valor de columna fuera del rango del tablero');
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - Mensaje: ' || SQLERRM);
		ROLLBACK;
END SOLTAR_BURRO;

 /*-------------------------------------------------------------------------------------------*/
create or replace NONEDITIONABLE PROCEDURE RESUMEN_PARTIDA(partidaId NUMBER) IS
  estado VARCHAR2(50):='CARGANDO';
  espEquipo VARCHAR(50);
  espVictorias VARCHAR(50);
  espDerrotas VARCHAR(50);
  --seleccionar los jugadores de la partida
  CURSOR equipos IS
      SELECT idEquipo, letra, victorias, derrotas
        FROM EQUIPO e
      WHERE e.idPartida = partidaId;
  regFila equipos%ROWTYPE;
BEGIN
    SELECT p.estado
    INTO estado
    FROM partida p
    WHERE p.idPartida = partidaId;
    OPEN equipos;
    FETCH equipos INTO regFila;
    IF estado = 'FINALIZADA' THEN
      DBMS_OUTPUT.PUT_LINE('Equipo | '|| 'Enemigos Asesinados | '||'Aliados Derrotados');
      WHILE equipos%FOUND LOOP
         select rpad(' ',7-length(regFila.letra),' ') into espEquipo from dual;
         select rpad(' ',13-length(regFila.victorias),' ') into espVictorias from dual;
	     DBMS_OUTPUT.PUT_LINE(regFila.letra || espEquipo || '|        ' || regFila.victorias || espVictorias || '|        ' || regFila.derrotas);
        FETCH equipos INTO regFila;
      END LOOP;
      CLOSE equipos;
    ELSE
        DBMS_OUTPUT.PUT_LINE('La partida aun no esta finalizada');
        CLOSE equipos;
    END IF;
END;

 /*-------------------------------------------------------------------------------------------*/
 create or replace NONEDITIONABLE PROCEDURE ELIMINAR_PARTIDA(partidaId NUMBER) IS
BEGIN
    DELETE
    FROM partida
    WHERE partida.idPartida = partidaId;
    DBMS_OUTPUT.PUT_LINE('Partida eliminada');
END;
