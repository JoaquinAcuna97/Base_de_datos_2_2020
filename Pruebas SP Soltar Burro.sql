--INSERT DE DATOS
INSERT INTO PARTIDA (duracion, turno, dificultad, estado) VALUES (15, 30,'Facil','CARGANDO');
INSERT INTO TABLERO (X_columnas,Y_filas, idPartida) VALUES (50,15, 1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('DOS','R',0,0,1);
INSERT INTO JUGADOR(Nombre,Tipo,idEquipo) VALUES ('Player1','Humano',1);
-- INSERT EQUIPO UNO
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1, NULL);
-- INSERT EQUIPO DOS
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
/
variable terreno VARCHAR2(1000);
exec :terreno := '..........W.........R...............R.............-......P.PPPPP..R.WPPPPPPP...........PPR...........-.........PPPPPPPPPPP.PPPPP..........PPP...........-...........PPPPPPPP.....PPP...........PP..........-.........RPPPP..PPPP.....W......W.......PP........-.........PPPP.T.PPPP..PPPPPPPPPPPPPPPR.PPP........-........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-........PPPP.....PPPPPPPPPPPPPPPPPPP..............-..................PPPPPPPPPPPPPPPPPP..............-..................PPPPP....PPPPPPPPP..............-..................PPPPP........PP.PP..............-.............R.....PPP..W....PPP.PPP..W...........-.....R..W...PPPPPPPPPPPPPPPPPPPPPPPPPPPPP...W.....-AAAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTAAAAA-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
/
exec CARGAR_TABLERO (1, :terreno);
/
--exec UPDATE_TABLERO (1, :terreno);
exec ver_tablero(1);
/
EXEC CARGAR_FK_GUSANOS(1, 1);
/
UPDATE PARTIDA
   SET estado = 'INICIADA'
 WHERE idPartida = 1;
commit;
/
exec SOLTAR_BURRO(1,33,1);
/
exec ver_tablero(1);
