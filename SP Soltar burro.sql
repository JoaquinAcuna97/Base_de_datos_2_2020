CREATE OR REPLACE NONEDITIONABLE PROCEDURE SOLTAR_BURRO(idTablero NUMBER, Columna NUMBER, equipoId NUMBER) IS
    varMaxColumnaTablero NUMBER(2);
    varMaxFilaTablero NUMBER(2);
    columnaInicial NUMBER(2);
    contenidoCelda VARCHAR(1);
    varGusanoId NUMBER(10);
    varEquipoId NUMBER(10);
    varColumnaFin NUMBER(2);
	excFueraRango EXCEPTION;

BEGIN
    SELECT X_Columnas-1, Y_Filas-1
      INTO varMaxColumnaTablero, varMaxFilaTablero
      FROM TABLERO
     WHERE id = idTablero;
    IF columna < 0 OR columna > varMaxColumnaTablero THEN
        RAISE excFueraRango;
		--Raise_Application_Error(-20003, 'Valor de columna fuera del rango del tablero');
    END IF;
    columnaInicial :=columna;
    IF (varMaxColumnaTablero - columna) < 5 THEN
        columnaInicial := varMaxColumnaTablero - 5;
    END IF;
    varColumnaFin := columnaInicial+4;
    FOR fila IN 0..varMaxFilaTablero LOOP
        FOR col IN columnaInicial..varColumnaFin LOOP
            SELECT contenido
              INTO contenidoCelda
              FROM CELDA
             WHERE Y_Fila = fila
               AND X_Columna = col
               AND tableroId = idTablero;            
            IF contenidoCelda IN ('P','T','B') THEN
                UPDATE CELDA
                   SET contenido = '.'
                 WHERE tableroId = idTablero
                   AND Y_Fila = fila
                   AND X_Columna = col;
            ELSIF contenidoCelda IN ('W','R','L','H') THEN
                SELECT g.idGusano, e.idEquipo
                  INTO varGusanoId, varEquipoId
                  FROM CELDA c
                  JOIN GUSANO g ON g.idGusano = c.idGusano
                  JOIN EQUIPO e ON e.idEquipo = g.idEquipo
                 WHERE tableroId = idTablero
                   AND Y_Fila = fila
                   AND X_Columna = col
                   ;
                --Matar gusano
                UPDATE GUSANO
                   SET salud = 0
                 WHERE idGusano = varGusanoId;
                --Aumenta contador de derrotas
                UPDATE EQUIPO
                   SET derrotas = derrotas + 1
                 WHERE idEquipo = varEquipoId;
                --Aumento victorias del equipo que lanzó el burro
                UPDATE EQUIPO
                   SET victorias = victorias + 1
                 WHERE idEquipo = equipoId;
                --Modifico contenido a aire
                UPDATE CELDA
                   SET contenido = '.'
                 WHERE tableroId = idTablero
                   AND Y_Fila = fila
                   AND X_Columna = col;                
            END IF;                
        END LOOP;
    END LOOP;
	COMMIT;
    EXCEPTION
		WHEN excFueraRango THEN
			DBMS_OUTPUT.PUT_LINE('Valor de columna fuera del rango del tablero');
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - Mensaje: ' || SQLERRM);
		ROLLBACK;
END SOLTAR_BURRO;