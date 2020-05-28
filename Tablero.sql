DROP TABLE CELDA;
DROP TABLE TABLERO;



CREATE TABLE TABLERO(
	id 		number(12)	not null primary key,
	X_columnas	 number(2) not null, 
	Y_filas		 number(2) not null
);
CREATE TABLE CELDA(
	id 		number(12)	not null primary key,
    X_columna	 number(2) not null, 
	Y_fila	 number(2) not null,
    contenido 	char(1) 	not null check (contenido in ('A','T','P','B','.') ),
	tableroid 	number(12)	not null references TABLERO
);

--Oferentes
insert into TABLERO (id,X_columnas,Y_filas) values (1,50,15);
commit;

insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (0,0,0,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (1,0,1,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (2,0,2,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (3,0,3,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (4,0,4,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (5,0,5,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (6,0,6,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (7,0,7,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (8,0,8,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (9,0,9,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (10,0,10,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (11,0,11,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (12,0,12,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (13,0,13,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (14,0,14,'.',1);

insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (15,1,0,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (16,1,1,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (17,1,2,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (18,1,3,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (19,1,4,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (20,1,5,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (21,1,6,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (22,1,7,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (23,1,8,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (24,1,9,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (25,1,10,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (26,1,11,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (27,1,12,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (28,1,13,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (29,1,14,'.',1);

insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (30,2,0,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (31,2,1,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (32,2,2,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (33,2,3,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (34,2,4,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (35,2,5,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (36,2,6,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (37,2,7,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (38,2,8,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (39,2,9,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (40,2,10,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (41,2,11,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (42,2,12,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (43,2,13,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (44,2,14,'.',1);

insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (45,3,0,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (46,3,1,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (47,3,2,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (48,3,3,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (49,3,4,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (50,3,5,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (51,3,6,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (52,3,7,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (53,3,8,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (54,3,9,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (55,3,10,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (56,3,11,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (57,3,12,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (58,3,13,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (59,3,14,'.',1);

insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (60,4,0,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (61,4,1,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (62,4,2,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (63,4,3,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (64,4,4,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (65,4,5,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (66,4,6,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (67,4,7,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (68,4,8,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (69,4,9,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (70,4,10,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (71,4,11,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (72,4,12,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (73,4,13,'.',1);
insert into CELDA (id,X_columna,Y_fila,contenido,tableroid) values (74,4,14,'.',1);
commit;



DECLARE
    --Cursor con cantidad de postulaciones de una oferta
    CURSOR cursorx  (idtablero NUMBER) IS
        SELECT contenido, Y_fila
        FROM CELDA
        WHERE tableroid = idtablero; 

        
--Variables para trabajar con una fila específica de un cursor

unaPos cursorx%ROWTYPE;
BEGIN
--Se abre el cursor de celdas y se obtiene la primera fila
    OPEN cursorx(1);
    FETCH cursorx INTO unaPos;
    WHILE cursorx%FOUND LOOP --Mientras existan celdas

        IF unaPos.Y_fila =14  THEN
        DBMS_OUTPUT.PUT_LINE(unaPos.contenido || ' '||chr(13)||chr(10));
        ELSE
        DBMS_OUTPUT.PUT(unaPos.contenido || ' ');
        END IF;
         FETCH cursorx INTO unaPos;
    END LOOP;
    CLOSE cursorx;
END; 