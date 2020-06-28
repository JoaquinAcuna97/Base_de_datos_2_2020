create or replace NONEDITIONABLE PROCEDURE ELIMINAR_PARTIDA(partidaId NUMBER) IS
BEGIN
    DELETE
    FROM partida
    WHERE partida.idPartida = partidaId;
    DBMS_OUTPUT.PUT_LINE('Partida eliminada');
END;


CREATE OR REPLACE PROCEDURE ELIMINAR_PARTIDA (partidaId NUMBER) AS
   BEGIN
      DELETE FROM partida
      WHERE partida.idPartida = partidaId;
   END;
