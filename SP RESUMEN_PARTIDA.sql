create or replace NONEDITIONABLE PROCEDURE RESUMEN_PARTIDA(partidaId NUMBER) IS
  estado VARCHAR2(50):='CARGANDO';
  espEquipo VARCHAR(50);
  espVictorias VARCHAR(50);
  espDerrotas VARCHAR(50);
  --seleccionar los jugadores de la partida
  CURSOR equipos IS
      SELECT idEquipo, letra, victorias, derrotas
        FROM EQUIPO e
      WHERE e.idPartida = partidaId;
  regFila equipos%ROWTYPE;
BEGIN
    SELECT p.estado
    INTO estado
    FROM partida p
    WHERE p.idPartida = partidaId;
    OPEN equipos;
    FETCH equipos INTO regFila;
    IF estado = 'FINALIZADA' THEN
      DBMS_OUTPUT.PUT_LINE('Equipo | '|| 'Enemigos Asesinados | '||'Aliados Derrotados');
      WHILE equipos%FOUND LOOP
         select rpad(' ',7-length(regFila.letra),' ') into espEquipo from dual;
         select rpad(' ',13-length(regFila.victorias),' ') into espVictorias from dual;
	     DBMS_OUTPUT.PUT_LINE(regFila.letra || espEquipo || '|        ' || regFila.victorias || espVictorias || '|        ' || regFila.derrotas);
        FETCH equipos INTO regFila;
      END LOOP;
      CLOSE equipos;
    ELSE
        DBMS_OUTPUT.PUT_LINE('La partida aun no esta finalizada');
        CLOSE equipos;
    END IF;
END;
