--SE ASUME QUE EL ENCARGADO DE EJECUTAR ESTE SP MODIFICARA LA UBICACION ANTERIOR DEL GUSANO A AIRE
CREATE OR REPLACE PROCEDURE SALTO_BUNGEE(idTablero NUMBER, Columna NUMBER, Fila NUMBER, gusanoId NUMBER) IS
    v_Equipo CHAR(1);
    contirnuar BOOLEAN := TRUE;
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
    IF regFila.Contenido = 'A' THEN
        UPDATE GUSANO
           SET Salud = 0
         WHERE idGusano = gusanoId;
         --continuar := FALSE;
    ELSIF regFila.Contenido = 'B' THEN
        --BEGIN
        UPDATE GUSANO
           SET Salud = 0
         WHERE idGusano = gusanoId;
        UPDATE CELDA
           SET Contenido = '.'
         WHERE TableroId = idTablero
           AND X_Columna =  regFila.X_Columna
           AND Y_Fila = regFila.Y_Fila;
        --continuar := FALSE;
    ELSIF regFila.Contenido = '.' THEN                
        --BEGIN
        FETCH cursorFilas INTO regFila;
        WHILE cursorFilas%FOUND LOOP
            IF regFila.Contenido = 'A' THEN
                UPDATE GUSANO
                   SET Salud = 0
                 WHERE idGusano = gusanoId;
                 --continuar := FALSE;
            ELSIF regFila.Contenido = 'B' THEN
                --BEGIN
                UPDATE GUSANO
                   SET Salud = 0
                 WHERE idGusano = gusanoId;
                UPDATE CELDA
                   SET Contenido = '.'
                 WHERE idTablero = idTablero
                   AND X_Columna =  regFila.X_Columna
                   AND Y_Fila = regFila.Y_Fila;
                 --continuar := FALSE;
            ELSIF regFila.Contenido = 'P' OR regFila.Contenido = 'T' THEN
                UPDATE CELDA
                   SET Contenido = v_Equipo
                 WHERE tableroId = idTablero
                   AND Y_Fila = regFila.Y_Fila-1
                   AND X_Columna = regFila.X_Columna;
            ELSIF regFila.Contenido <> '.' THEN
                Raise_Application_Error(-20.001, 'No se puede realizar el desplazamiento');
            END IF;
            FETCH cursorFilas INTO regFila;
        END LOOP;
        CLOSE cursorFilas;
    ELSE
        Raise_Application_Error(-20001, 'No se puede realizar el desplazamiento');
    END IF;
END;