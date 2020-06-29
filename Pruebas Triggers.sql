
-- PRUEBAS VER TABLERO
INSERT INTO PARTIDA (duracion, turno, dificultad, estado) VALUES (15, 30, 'Facil','CARGANDO');
INSERT INTO TABLERO (X_columnas,Y_filas, idPartida) VALUES (50,15, 1);
EXEC CARGAR_TABLERO_BURRO(1);
EXEC VER_TABLERO(1);

--PRUEBAS gusanoSoloEnAire

INSERT INTO TABLERO (X_columnas,Y_filas, idPartida) VALUES (50,15, 1);
EXEC CARGAR_TABLERO_BURRO(1);

UPDATE CELDA
SET contenido = 'W',
WHERE tableroid = 1;

--PRUEBAS jugadorSeleccionaMaxTreintaArmas
INSERT INTO PARTIDA (duracion, dificultad, estado) VALUES (15,'Facil','CARGANDO');
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
INSERT INTO JUGADOR(Nombre,Tipo,idEquipo) VALUES ('Player1','Humano',1);

INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Stone Canary',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Air Strike',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Alien Abduction',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Aqua Sheep',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Armageddon',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Ballista',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Banana Bomb',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Baseball Bat',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Battle Axe',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Bazooka',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Black Hole',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Blowpipe',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Bovine Blitz',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Buffalo of Lies',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Bunker Buster',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Canned Heat',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Chilli Con Carnage',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Cloned Sheep',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Cluster Bomb',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Concrete Donkey',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Custom Weapon',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Dodgy Phone Battery',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Dragon Ball',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Dynamite',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Earthquake',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Electric Sheep',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Electrical Storm',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Fatkins Strike',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Ferrets',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Fire Punch',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Flame Thrower',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Flood',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Fridge Launcher',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Gas Canister',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Gas Pump',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Giant Crossbow',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Giant Laser',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Golden Bazooka',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Grenade',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Handgun',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Holy Hand Grenade',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Homing Air Strike',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Homing Missile',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Homing Pigeon',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Inflatable Scouser',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Lightning Strike',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Mad Cows',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Mail Strike',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('MB Bomb',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Mega Mine',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Mega Mortar',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Mikes Carpet Bomb',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Mine',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Mine Strike',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Minigun',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Mole Squadron',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Monkey Troop',100);
INSERT INTO ARMA(NOMBRE,DANIO) VALUES('Mortar',100);

SELECT * FROM JUGADOR;

INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 1 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 2 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 3 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 4 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 5 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 6 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 7 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 8 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 9 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 10 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 11 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 12 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 13 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 14 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 15 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 16 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 17 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 18 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 19 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 20 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 21 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 22 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 23 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 24 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 25 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 26 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 27 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 28 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 29 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 30 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 31 );
INSERT INTO ARMASJUGADOR(idjugador_armasjugador,idarma_armasjugador) values(1, 32 );
--PRUEBAS RESUMEN_PARTIDA

INSERT INTO PARTIDA (duracion, dificultad, estado) VALUES (15,'Facil','FINALIZADA');

INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',4,3,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('DOS','P',0,4,1);

INSERT INTO JUGADOR(Nombre,Tipo,idEquipo) VALUES ('Player1','Humano',1);
INSERT INTO JUGADOR(Nombre,Tipo,idEquipo) VALUES ('Playerw','IA',2);

EXEC RESUMEN_PARTIDA(1);

--PRUEBAS ELIMINAR_PARTIDA

INSERT INTO PARTIDA (duracion, dificultad, estado) VALUES (15,'Facil','FINALIZADA');

INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',4,3,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('DOS','P',0,4,1);

INSERT INTO JUGADOR(Nombre,Tipo,idEquipo) VALUES ('Player1','Humano',1);
INSERT INTO JUGADOR(Nombre,Tipo,idEquipo) VALUES ('Playerw','IA',2);

INSERT INTO TABLERO (X_columnas,Y_filas, idPartida) VALUES (50,15, 1);
EXEC CARGAR_TABLERO_BURRO(1);


SELECT * FROM PARTIDA;
SELECT * FROM EQUIPO;
SELECT * FROM JUGADOR;
SELECT * FROM TABLERO;
SELECT * FROM CELDA;

EXEC ELIMINAR_PARTIDA(1);

SELECT * FROM PARTIDA;
SELECT * FROM EQUIPO;
SELECT * FROM JUGADOR;
SELECT * FROM TABLERO;
SELECT * FROM CELDA;

--PRUEBAS maximoGusanosPorEquipo
INSERT INTO PARTIDA (duracion, turno, dificultad, estado) VALUES (15, 30, 'Facil','CARGANDO');
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
--INSERT QUE VERIFICA TRIGGER
INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);

--PRUEBAS maximoEquiposPorPartida
INSERT INTO PARTIDA (duracion, turno, dificultad, estado) VALUES (15, 30, 'Facil','CARGANDO');
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('DOS','L',0,0,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('TRES','H',0,0,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('CUATRO','R',0,0,1);

--INSERT QUE VERIFICA EL TRIGGER
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
--PRUEBAS unJugadorHumano
INSERT INTO PARTIDA (duracion, turno, dificultad, estado) VALUES (15, 30, 'Facil','CARGANDO');
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('DOS','R',0,0,1);
INSERT INTO JUGADOR(Nombre, Tipo, idEquipo) VALUES('Jugador Uno', 'IA', 1);
INSERT INTO JUGADOR(Nombre, Tipo, idEquipo) VALUES('Jugador Dos', 'IA', 2);
--PRUEBA QUE VERIFICA EL TRIGGER
UPDATE PARTIDA
   SET estado = 'INICIADA'
 WHERE idPartida = 1;

 --PRUEBAS gusanoMuereContactoAgua
 INSERT INTO PARTIDA (duracion, turno, dificultad, estado) VALUES (15, 30, 'Facil','CARGANDO');
 INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
 INSERT INTO TABLERO (X_columnas,Y_filas, idPartida) values (50,15,1);
 INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
 INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
 /
 variable terreno VARCHAR2(1000);
 exec :terreno := '..................................................-......P.PPPPP....WPPPPPPP...........PP............-.........PPPPPPPPPPP.PPPPP..........PPP...........-...........PPPPPPPP.....PPP...........PP..........-..........PPPP..PPPP....................PP........-.........PPPP.T.PPPP..PPPPPPPPPPPPPPP..PPP........-........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-........PPPP.....PPPPPPPPPPPPPPPPPPP..............-..................PPPPPPPPPPPPPPPPPP..............-..................PPPPP....PPPPPPPPP..............-..................PPPPP........PP.PP..............-...................PPP.......PPP.PPP..............-........W...PPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-AAAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTAAAAA-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
 /
 exec CARGAR_TABLERO (1, :terreno);
 /
 EXEC CARGAR_FK_GUSANOS(1, 1);
 /
 EXEC ver_tablero(1);
 /
 select * from celda where y_fila = 12 and x_columna = 8;
 /
 select * from gusano where idGusano = 2;
 /
 EXEC SALTO_BUNGEE(1 , 2, 4, 2);
 /
 exec ver_tablero(1);

--PRUEBAS FK_VALIDA_GUSANO
 INSERT INTO PARTIDA (duracion, turno, dificultad, estado) VALUES (15, 30, 'Facil','CARGANDO');
 INSERT INTO EQUIPO (Nombre, letra, derrotas, victorias, idPartida) VALUES ('UNO','W',0,0,1);
 INSERT INTO TABLERO (X_columnas,Y_filas, idPartida) values (50,15,1);
 INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
 INSERT INTO GUSANO (salud, idEquipo, accion) VALUES(100,1,NULL);
 /
 variable terreno VARCHAR2(1000);
 exec :terreno := '..................................................-......P.PPPPP....WPPPPPPP...........PP............-.........PPPPPPPPPPP.PPPPP..........PPP...........-...........PPPPPPPP.....PPP...........PP..........-..........PPPP..PPPP....................PP........-.........PPPP.T.PPPP..PPPPPPPPPPPPPPP..PPP........-........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-........PPPP.....PPPPPPPPPPPPPPPPPPP..............-..................PPPPPPPPPPPPPPPPPP..............-..................PPPPP....PPPPPPPPP..............-..................PPPPP........PP.PP..............-...................PPP.......PPP.PPP..............-........W...PPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-AAAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTAAAAA-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
 /
 exec CARGAR_TABLERO (1, :terreno);
 /
update celda
   set idgusano = 2
WHERE x_columna = 8
  and y_fila = 12;
