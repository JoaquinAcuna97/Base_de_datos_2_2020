--SE ASUME QUE EL ENCARGADO DE EJECUTAR ESTE SP MODIFICARA LA UBICACION ANTERIOR DEL GUSANO A AIRE
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
                   SET Contenido = v_Equipo,
                       idGusano = gusanoId
                 WHERE tableroId = idTablero
                   AND Y_Fila = regFila.Y_Fila-1
                   AND X_Columna = regFila.X_Columna;
                continuar := FALSE;
            ELSIF regFila.Contenido IN ('B', 'A') THEN
                UPDATE CELDA
                   SET Contenido = v_Equipo,
                       idGusano = gusanoId
                 WHERE tableroId = idTablero
                   AND Y_Fila = regFila.Y_Fila
                   AND X_Columna = regFila.X_Columna;
                continuar := FALSE;
            ELSIF regFila.Contenido <> '.' THEN
                Raise_Application_Error(-20001, 'No se puede realizar el desplazamiento');
            END IF;
            FETCH cursorFilas INTO regFila;
        END LOOP;
        CLOSE cursorFilas;
    ELSE
        Raise_Application_Error(-20002, 'No se puede realizar el desplazamiento');
    END IF;
END;