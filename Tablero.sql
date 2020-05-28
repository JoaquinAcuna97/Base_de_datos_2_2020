DROP TABLE TABLERO;
DROP TABLE CELDA;

DBMS_OUTPUT.ENABLE (buffer_size => NULL);
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
        DBMS_OUTPUT.PUT_LINE(unaPos.contenido || ' ');
        END IF;
        CLOSE cursorx;
         FETCH cursorx INTO unaPos;
    END LOOP;
    CLOSE cursorx;
END; 