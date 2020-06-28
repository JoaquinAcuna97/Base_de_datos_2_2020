--VACIAR TABLAS
DROP TABLE CELDA;
DROP TABLE TABLERO;
DROP TABLE ARMASJUGADOR;
DROP TABLE JUGADOR;
DROP TABLE GUSANO;
DROP TABLE EQUIPO;
DROP TABLE PARTIDA;
DROP TABLE ARMA;

CREATE TABLE ARMA(
	idArma NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key ,
	nombre VARCHAR2(100) UNIQUE NOT NULL,
	danio int NOT NULL,
	grupo VARCHAR2(5)
);

CREATE TABLE PARTIDA(
	idPartida NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	duracion NUMBER(2) NOT NULL CHECK( duracion IN(15, 20, 25)),
	turno NUMBER(2) CHECK(turno =30),
	dificultad VARCHAR(50) NOT NULL CHECK(dificultad IN ('Facil', 'Intermedio', 'Dificil')),
	estado VARCHAR2(50) NOT NULL CHECK( estado IN ('CARGANDO', 'INICIADA', 'FINALIZADA'))
);


CREATE TABLE EQUIPO(
	idEquipo NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	nombre VARCHAR(100) NOT NULL,
	letra VARCHAR(1) UNIQUE NOT NULL CHECK(letra IN ('W', 'R', 'L', 'H')),
	derrotas NUMBER(10),
	victorias NUMBER(10),
	idPartida NUMBER(10) NOT NULL REFERENCES PARTIDA  ON DELETE CASCADE,
	CONSTRAINT unique_equipo_partida UNIQUE(letra, idPartida)
);

CREATE TABLE GUSANO(
	idGusano NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	salud NUMBER(3) NOT NULL CHECK(salud >=0 AND salud <= 100),
	idEquipo NUMBER(10) NOT NULL REFERENCES EQUIPO  ON DELETE CASCADE,
	accion VARCHAR(50) CHECK (accion IN ('Caminar', 'Saltar')),
	nombre VARCHAR(50)
);

CREATE TABLE JUGADOR(
	idJugador NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	Nombre VARCHAR2(200),
	Tipo VARCHAR(20) CHECK(Tipo IN ('Humano', 'IA')),
	idEquipo NUMBER(10) REFERENCES EQUIPO  ON DELETE SET NULL
);


CREATE TABLE ARMASJUGADOR(
	idjugador_armasjugador NUMBER NOT NULL REFERENCES JUGADOR ON DELETE SET NULL,
	idarma_armasjugador NUMBER NOT NULL REFERENCES ARMA ON DELETE SET NULL,
	CONSTRAINT unique_arma_jugador UNIQUE(idjugador_armasjugador, idarma_armasjugador)
);

 CREATE TABLE TABLERO(
 	id 		number(12) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
 	X_columnas	 number(2) not null CHECK (X_columnas =50),
 	Y_filas		 number(2) not null CHECK (Y_filas =15),
	idPartida NUMBER(10) NOT NULL REFERENCES PARTIDA  ON DELETE CASCADE
 );

 CREATE TABLE CELDA(
	id NUMBER(12) GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	X_columna number(2) NOT NULL,
	Y_fila NUMBER(2) NOT NULL,
	contenido char(1) NOT NULL CHECK (contenido in ('A','T','P','B','.','W','R','L','H')),
	tableroid NUMBER(12) NOT NULL REFERENCES TABLERO ON DELETE CASCADE,
	idGusano NUMBER(10) REFERENCES GUSANO
 );