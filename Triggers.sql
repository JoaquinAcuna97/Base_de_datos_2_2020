CREATE OR REPLACE TRIGGER unJugadorHumano
BEFORE INSERT OR UPDATE ON PARTIDA
FOR EACH ROW
DECLARE varExisteHumano VARCHAR(1);
BEGIN
    BEGIN
        SELECT Letra
          INTO varExisteHumano
          FROM EQUIPO e
          JOIN JUGADOR j ON j.idEquipo = e.idEquipo
         WHERE idPartida = :new.idPartida
           AND j.Tipo = 'Humano';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            varExisteHumano := NULL;
    END;
	IF varExisteHumano IS NULL AND :new.Estado = 'INICIADA' THEN
		raise_application_error(-20003,'Error: La partida debe contener al menos un jugador humano');
	END IF;
END unJugadorHumano;--OK
/

CREATE OR REPLACE TRIGGER gusanoMuereContactoAgua
BEFORE UPDATE ON CELDA
FOR EACH ROW
DECLARE varIdGusano VARCHAR(1);
BEGIN
	IF :OLD.Contenido = 'A' THEN
		SELECT idGusano
		  INTO varIdGusano
		  FROM GUSANO g
		 WHERE g.idGusano = :new.idGusano;
	END IF;
  IF varIdGusano IS NOT NULL THEN
        UPDATE GUSANO
           SET salud = 0
         WHERE GUSANO.idGusano = :new.idGusano;
        :new.contenido := 'A';
		:new.idGusano := NULL;
	END IF;
END gusanoMuereContactoAgua;--OK
/
CREATE OR REPLACE TRIGGER gusanoSoloEnAire
BEFORE UPDATE ON CELDA
FOR EACH ROW
BEGIN
	IF :NEW.Contenido IN ('W', 'R', 'L', 'H') THEN
    IF :OLD.Contenido IN ('P', 'T', 'W', 'R', 'L', 'H') AND :OLD.Contenido != :new.Contenido THEN
      raise_application_error(-20003,'Error: un gusano solo puede ir en el aire');
    END IF;
	END IF;
END gusanoSoloEnAire;
/
CREATE OR REPLACE TRIGGER explosionCaja
BEFORE UPDATE ON CELDA
FOR EACH ROW
DECLARE varIdGusano VARCHAR(1);
BEGIN
	IF :OLD.Contenido = 'B' THEN
		SELECT idGusano
		  INTO varIdGusano
		  FROM GUSANO g
		 WHERE g.idGusano = :new.idGusano;
	END IF;
	IF varIdGusano IS NOT NULL THEN
		UPDATE GUSANO
		   SET salud = 0
		 WHERE GUSANO.idGusano = :new.idGusano;
		:new.Contenido := '.';
		:new.idGusano := NULL;
	END IF;
END explosionCaja;--OK
/

CREATE OR REPLACE TRIGGER jugadorSeleccionaMaxTreintaArmas
BEFORE INSERT OR UPDATE ON ARMASJUGADOR
FOR EACH ROW
DECLARE varCantidadArmas NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO varCantidadArmas
       FROM ARMASJUGADOR
      WHERE idjugador_armasjugador = :new.idjugador_armasjugador;
	IF varCantidadArmas >= 30 THEN
		raise_application_error(-20001,'Error: Los equipos solo pueden tener un máximo de 30 Armas');
	END IF;
END jugadorSeleccionaMaxTreintaArmas;--OK
/
CREATE OR REPLACE TRIGGER FK_VALIDA_GUSANO
BEFORE UPDATE OR INSERT ON CELDA
FOR EACH ROW
DECLARE
BEGIN
    IF :new.Contenido NOT IN ('W', 'R','L','H') AND :new.idGusano IS NOT NULL THEN
        raise_application_error(-20010, 'No se puede asignar una FK a un contenido que no corresonde a un equipo.');
    END IF;
END FK_VALIDA_GUSANO;
/
CREATE OR REPLACE TRIGGER maximoGusanosPorEquipoInsert
BEFORE INSERT ON GUSANO
FOR EACH ROW
DECLARE
    varValorInicial NUMBER;
BEGIN
    SELECT cantGusanos
      INTO varValorInicial
      FROM EQUIPO
     WHERE equipo.idEquipo = :new.idEquipo;
    IF varValorInicial >= 8 THEN
        raise_application_error(-20001,'Error: Los equipos solo pueden tener un máximo de 8 gusanos');
    ELSE
        UPDATE EQUIPO
           SET cantGusanos = cantGusanos + 1
         WHERE idEquipo = :new.idEquipo;
    END IF;
END maximoGusanosPorEquipoInsert;
/
CREATE OR REPLACE TRIGGER maximoGusanosPorEquipoUpdate
BEFORE UPDATE ON GUSANO
FOR EACH ROW
DECLARE
    varValorInicial NUMBER;
BEGIN
    SELECT cantGusanos
      INTO varValorInicial
      FROM EQUIPO
     WHERE equipo.idEquipo = :new.idEquipo;
    IF :new.idEquipo != :old.idEquipo THEN
        --Disminuir cantidad equipo anterior
        UPDATE EQUIPO
           SET cantGusanos = cantGusanos - 1
         WHERE equipo.idEquipo = :old.idEquipo;
        --Aumentar cantidad equipo nuevo
        UPDATE EQUIPO
           SET cantGusanos = cantGusanos + 1
         WHERE equipo.idEquipo = :new.idEquipo;
    END IF;
END maximoGusanosPorEquipoUpdate;
/
CREATE OR REPLACE TRIGGER maximoGusanosPorEquipoDelete
AFTER DELETE ON GUSANO
FOR EACH ROW
DECLARE
    varValorInicial NUMBER;
BEGIN
    UPDATE EQUIPO
       SET cantGusanos = cantGusanos - 1
     WHERE idEquipo = :old.idEquipo;
END maximoGusanosPorEquipoDelete;
