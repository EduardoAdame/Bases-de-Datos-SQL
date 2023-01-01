--Función que devuelve un valor
--Funcion que devuelve la cantidad de medicamento que caduca en una fecha dada.
CREATE OR REPLACE FUNCTION fnc_caducidad_med(vdate DATE,vgama INTEGER) 
 RETURNS BIGINT 
AS 
$$ 
DECLARE vtotal_med BIGINT; 
 
BEGIN 
 vtotal_med= (
	SELECT T2.total 
	FROM(
		SELECT T1.idgama, COUNT(T1.idgama) total 
		FROM(
			SELECT m.caducidad,cg.idgama
			FROM medicamento m 
			INNER JOIN medicamento_cgama cg ON m.idmedicamento=cg.idmedicamento
			WHERE idgama=vgama AND caducidad=vdate
		) T1 
		INNER JOIN cgama cg ON T1.idgama=cg.idgama
		GROUP BY T1.idgama	
		) T2);  
    
 RETURN vtotal_med; 
END; 
$$ 
LANGUAGE 'plpgsql' VOLATILE;

SELECT fnc_caducidad_med('08-10-2025', 1);


--Función que devuelve una tabla: 
--Nos devuelve la cantidad de medicamentos distribuídos y vendidos por medicamento
CREATE OR REPLACE FUNCTION fnc_ventaydistribucion ()

RETURNS  TABLE (oidmedicamento bigint, odistribucion bigint, oventas integer)
AS
$$

BEGIN
RETURN QUERY SELECT  m.idmedicamento, d.cantidad_distribuida, mr.unidades_recetadas 
 FROM medicamento m JOIN distribucion d ON m.idmedicamento = d.idmedicamento
 JOIN medicamento_receta mr ON mr.idmedicamento = m.idmedicamento;  
END 
$$ 
LANGUAGE 'plpgsql' VOLATILE;

select *  
from fnc_ventaydistribucion ();


--Función que realiza una acción en la base de datos
--Asignación e inserción de una persona
CREATE OR REPLACE FUNCTION fnc_inserta_nueva_persona
( correo varchar(100), nombre_persona varchar(100), app varchar(100),
apm varchar(100),fecha_nacimiento date, genero_nuevo varchar(100))

RETURNS  text
AS
$$

DECLARE id_nueva_persona integer;
DECLARE id_genero_asignado integer;
BEGIN

id_nueva_persona= (SELECT MAX(persona.idpersona) FROM persona )+1;
--No agregamos un caso donde sea nulo porque en las restricciones, el idpersona no es nulo--

id_genero_asignado = (SELECT cgenero.idgenero FROM cgenero WHERE cgenero.genero=genero_nuevo);

INSERT INTO persona (idpersona, correo, nombre_persona, app,apm, fecha_nacimiento, idgenero)
VALUES(id_nueva_persona, correo, nombre_persona, app,apm, fecha_nacimiento, id_genero_asignado);
RETURN 'Nueva_persona_insertada';
END;
$$
LANGUAGE 'plpgsql';

SELECT  fnc_inserta_nueva_persona('chicharron@gmail', 'Ale', 'Martínez', 'Galván', '12-11-2021', 'HOMBRE')

SELECT * FROM persona ORDER BY idpersona DESC; --verificación del nuevo registro--

