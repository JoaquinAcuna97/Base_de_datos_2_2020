--PRUEBAS SALTO_BUNGEE

INSERT INTO PARTIDA (duracion, turno, dificultad, estado) VALUES (15, 30, 'Facil','CARGANDO');
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('DOS','R',0,0,1);

INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);

INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,2, NULL);
EXEC CARGAR_FK_GUSANOS(1, 1)

variable terreno VARCHAR2(1000);
exec :terreno := '..........W.........R...............R.............-......P.PPPPP..R.WPPPPPPP...........PPR...........-.........PPPPPPPPPPP.PPPPP..........PPP...........-...........PPPPPPPP.....PPP...........PP..........-.........RPPPP..PPPP.....W......W.......PP........-.........PPPP.T.PPPP..PPPPPPPPPPPPPPPR.PPP........-........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-........PPPP.....PPPPPPPPPPPPPPPPPPP..............-..................PPPPPPPPPPPPPPPPPP..............-..................PPPPP....PPPPPPPPP..............-..................PPPPP........PP.PP..............-.............R.....PPP..W....PPP.PPP..W...........-.....R..W...PPPPPPPPPPPPPPPPPPPPPPPPPPPPP...W.....-AAAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTAAAAA-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
exec CARGAR_TABLERO (1, :terreno);
EXEC VER_TABLERO(1);

EXEC SALTO_BUNGEE(1 , 20, 5, 1)