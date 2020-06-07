CREATE OR REPLACE PROCEDURE VER_TABLERO(idTablero Tablero.id%TYPE) IS
    casilla CHAR(1);
    CURSOR cursorTablero IS
        SELECT contenido, X_Columna, Y_Fila
          FROM CELDA
         WHERE TableroId = idTablero;
    regTablero cursorTablero%ROWTYPE;
BEGIN    
    OPEN cursorTablero;
    FETCH cursorTablero INTO regTablero;
    WHILE cursorTablero%FOUND LOOP--Mientras existan datos
        IF regTablero.X_Columna = 49 THEN
            DBMS_OUTPUT.PUT_LINE(regTablero.Contenido);
        ELSE
            DBMS_OUTPUT.PUT(regTablero.Contenido);
        END IF;
       FETCH cursorTablero INTO regTablero;
    END LOOP;
    CLOSE cursorTablero;
END;