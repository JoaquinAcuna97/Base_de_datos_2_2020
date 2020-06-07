/*
drop table ARMA;
drop table GUSANO;
drop table EQUIPO;
drop table PARTIDA;
*/

CREATE TABLE ARMA(
	idArma NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key ,
	nombre VARCHAR2(100) UNIQUE NOT NULL,
	daño int NOT NULL,
	grupo VARCHAR2(5)
);

CREATE TABLE GUSANO(
	idGusano NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	salud NUMBER(3) NOT NULL CHECK(salud >=0 AND salud <= 100),
	idEquipo NUMBER(10) NOT NULL REFERENCES EQUIPO,
	accion VARCHAR(50) CHECK( accion IN ('Caminar', 'Saltar'))	
);

CREATE TABLE EQUIPO(
	idEquipo NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	nombre VARCHAR(100) NOT NULL,
	letra VARCHAR(1) UNIQUE NOT NULL CHECK(letra IN ('W', 'R', 'L', 'H')),
	derrotas NUMBER(10),
	victorias NUMBER(10)
);

CREATE TABLE PARTIDA(
	idPartida NUMBER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT by 1) primary key,
	duracion NUMBER(2) NOT NULL CHECK( duracion IN(15, 20, 25)),
	dificultad VARCHAR(50) NOT NULL CHECK(dificultad IN ('Facil', 'Intermedio', 'Dificil'))
);