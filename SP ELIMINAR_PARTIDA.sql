create or replace NONEDITIONABLE PROCEDURE ELIMINAR_PARTIDA(partidaId NUMBER) IS
BEGIN
    DELETE
    FROM partida
    WHERE partida.idPartida = partidaId;
    DBMS_OUTPUT.PUT_LINE('Partida eliminada');
END;
