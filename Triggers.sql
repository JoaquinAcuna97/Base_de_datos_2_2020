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
    dbms_output.put_line('Pase');
	SELECT Letra
	  INTO varExisteHumano
	  FROM EQUIPO e
	  JOIN JUGADOR j ON j.idEquipo = e.idEquipo
	 WHERE idPartida = :new.idPartida
	   AND j.Tipo = 'Humano';
    dbms_output.put_line('Select');
	IF varExisteHumano IS NULL AND :new.Estado = 'INICIADA' THEN
		raise_application_error(-20003,'Error: La partida debe contener al menos un jugador humano');
	END IF;
END unJugadorHumano;


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
END explosionCaja;