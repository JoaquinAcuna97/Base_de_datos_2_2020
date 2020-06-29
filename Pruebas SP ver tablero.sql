-- PRUEBAS VER TABLERO
INSERT INTO TABLERO (X_columnas,Y_filas, idPartida) VALUES (50,15, 1);
exec :terreno := '..................................................-......P.PPPPP.....PPPPPPP...........PP............-.........PPPPPPPPPPP.PPPPP..........PPP...........-...........PPPPPPPP.....PPP...........PP..........-..........PPPP..PPPP....................PP........-.........PPPP.T.PPPP..PPPPPPPPPPPPPPP..PPP........-........PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP.........-........PPPP.....PPPPPPPPPPPPPPPPPPP..............-..................PPPPPPPPPPPPPPPPPP..............-..................PPPPP....PPPPPPPPP..............-..................PPPPP........PP.PP..............-............W......PPP.......PPP.PPP..............-............PPPPBPPPPPPPPPPPPPPPPPPPPPPPP.........-AAATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA';
EXEC CARGAR_TABLERO(1,:terreno);
EXEC VER_TABLERO(1);
