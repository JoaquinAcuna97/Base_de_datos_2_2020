
-- PRUEBAS VER TABLERO
INSERT INTO  TABLERO (X_columnas,Y_filas) VALUES (50,15);
EXEC CARGAR_TABLERO(1);
EXEC VER_TABLERO(1);

--PRUEBAS SALTO BUNGEE
INSERT INTO PARTIDA
(duracion, dificultad, estado)
VALUES (15,'Facil','CARGANDO');


DELETE FROM EQUIPO WHERE Nombre = 'UNO'

INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('DOS','R',0,0,1);
SELECT * FROM EQUIPO WHERE Nombre = 'UNO';

INSERT INTO GUSANO (salud, idEquipo, accion) VALUES (100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES (100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES (100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES (100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);

SELECT * FROM GUSANO;

EXEC CARGAR_TABLERO(1);
EXEC VER_TABLERO(1);

EXEC SALTO_BUNGEE(1 , 16, 12, 1)

--PRUEBAS SALTO BUNGEE
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,141, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,141, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,141, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,141, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,141, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,141, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,141, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,141, NULL);

INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,62, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,62, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,62, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,62, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,62, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,62, NULL);
