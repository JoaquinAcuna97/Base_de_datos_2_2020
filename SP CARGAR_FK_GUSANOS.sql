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