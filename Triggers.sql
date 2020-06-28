--drop trigger maximoGusanosPorEquipo
CREATE OR REPLACE TRIGGER maximoGusanosPorEquipo
BEFORE INSERT OR UPDATE ON GUSANO
FOR EACH ROW
DECLARE varCantidadGusanos NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO varCantidadGusanos
       FROM GUSANO
      WHERE idEquipo = :new.idEquipo;
	IF varCantidadGusanos >= 8 THEN
		raise_application_error(-20001,'Error: Los equipos solo pueden tener un máximo de 8 gusanos');
	END IF;
END maximoGusanosPorEquipo;--OK

CREATE OR REPLACE TRIGGER maximoEquiposPorPartida
BEFORE INSERT OR UPDATE ON EQUIPO
FOR EACH ROW
DECLARE varCantidadEquipos NUMBER;
BEGIN
	SELECT COUNT(*)
	  INTO varCantidadEquipos
	  FROM EQUIPO e
	 WHERE e.idPartida = :new.idPartida;
	IF varCantidadEquipos >= 4 THEN
		raise_application_error(-20002,'Error: Las partidas solo pueden tener un máximo de 4 equipos');
	END IF;
END maximoEquiposPorPartida;--OK

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
        :new.Contenido := '.';
		:new.idGusano := NULL;
	END IF;
END gusanoMuereContactoAgua;--OK

CREATE OR REPLACE TRIGGER gusanoSoloEnAire
BEFORE UPDATE ON CELDA
FOR EACH ROW
BEGIN
	IF :NEW.Contenido IN ('W', 'R', 'L', 'H') THEN
    IF :OLD.Contenido != '.' THEN
      raise_application_error(-20003,'Error: un gusano solo puede ir en el aire');
    END IF;
	END IF;
END gusanoSoloEnAire;

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


CREATE OR REPLACE TRIGGER jugadorSeleccionaMaxTreArmas
BEFORE INSERT OR UPDATE ON ARMASJUGADOR
FOR EACH ROW
DECLARE varCantidadArmas NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO varCantidadArmas
       FROM ARMASJUGADOR
      WHERE IDJUGADOR_ARMASJUGADOR = :new.IDJUGADOR_ARMASJUGADOR;
	IF varCantidadArmas >= 30 THEN
		raise_application_error(-20001,'Error: Los equipos solo pueden tener un máximo de 30 Armas');
	END IF;
END jugadorSeleccionaMaxTreArmas;--OK
