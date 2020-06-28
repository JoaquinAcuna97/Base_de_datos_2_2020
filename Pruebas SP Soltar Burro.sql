/*
select * from gusano
select * from equipo
select * from partida
select * from jugador
select * from celda
select * from tablero
*/
--INSERT DE DATOS
INSERT INTO PARTIDA (duracion, turno, dificultad, estado) VALUES (15, 30,'Facil','CARGANDO');
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('DOS','R',0,0,1);
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


variable terreno VARCHAR2(1000);
exec :terreno := '..........W.........R...............R.............-......P.PPPPP..R.WPPPPPPP...........PPR...........-.........PPPPPPPPPPP.PPPPP..........PPP...........-...........PPPPPPPP.....PPP...........PP..........-.........RPPPP..PPPP.....W......W.......PP........-.........PPPP.T.PPPP..PPPPPPPPPPPPPPPR.PPP........-........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-........PPPP.....PPPPPPPPPPPPPPPPPPP..............-..................PPPPPPPPPPPPPPPPPP..............-..................PPPPP....PPPPPPPPP..............-..................PPPPP........PP.PP..............-.............R.....PPP..W....PPP.PPP..W...........-.....R..W...PPPPPPPPPPPPPPPPPPPPPPPPPPPPP...W.....-AAAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTAAAAA-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
exec CARGAR_TABLERO (1, :terreno);
--exec UPDATE_TABLERO (1, :terreno);

exec ver_tablero(1);
EXEC CARGAR_FK_GUSANOS(1, 1)

exec SOLTAR_BURRO(1,33,1)