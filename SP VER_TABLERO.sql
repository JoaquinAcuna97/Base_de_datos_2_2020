create or replace NONEDITIONABLE PROCEDURE VER_TABLERO(idTablero Tablero.id%TYPE) IS
    casilla CHAR(1);
    varColumnaMax NUMBER;
--DECLARE
    CURSOR cursorTablero IS
        SELECT contenido, X_Columna, Y_Fila
          FROM CELDA
         WHERE TableroId = idTablero
         ORDER BY id;
    regTablero cursorTablero%ROWTYPE;
BEGIN
    SELECT X_Columnas - 1
      INTO varColumnaMax
      FROM TABLERO
      WHERE id = idTablero;
    OPEN cursorTablero;
    FETCH cursorTablero INTO regTablero;
    WHILE cursorTablero%FOUND LOOP--Mientras existan datos
        IF regTablero.X_Columna = varColumnaMax THEN
            DBMS_OUTPUT.PUT_LINE(regTablero.Contenido);
        ELSE
            DBMS_OUTPUT.PUT(regTablero.Contenido);
        END IF;
       FETCH cursorTablero INTO regTablero;
    END LOOP;
    CLOSE cursorTablero;
END;
