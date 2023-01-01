CREATE EXTENSION tablefunc; 

--Consulta básica: 
--Las 5 farmacias con la mayor cantidad de dinero en ventas
SELECT idfarmacia, cantidad_pesos FROM farmacia_receta WHERE cantidad_pesos>1000 LIMIT 5; 

--Subconsulta:
--Cantidad de medicamentos y ganancia por estado
SELECT CE.estado Estado, Unidades.TotalMedicamentos Medicamentos, GananciasPesos.TotalPesos Pesos
FROM cestado CE
JOIN cmunicipio CM ON CE.idestado = CM.idestado
JOIN cdireccion CD ON CD.idmunicipio = CM.idmunicipio
JOIN farmacia F ON F.iddireccion = CD.iddireccion
JOIN farmacia_receta FR ON F.idfarmacia = FR.idfarmacia
JOIN (
	SELECT DISTINCT idreceta, SUM(cantidad_pesos) TotalPesos
	FROM farmacia_receta
	GROUP BY idreceta
	ORDER BY TotalPesos DESC
) AS GananciasPesos ON GananciasPesos.idreceta = FR.idreceta
JOIN(
	SELECT DISTINCT idreceta, SUM(unidades_recetadas) TotalMedicamentos
	FROM medicamento_receta
	GROUP BY idreceta
	ORDER BY TotalMedicamentos DESC
) AS Unidades ON Unidades.idreceta = GananciasPesos.idreceta
WHERE Unidades.TotalMedicamentos IN (
	SELECT MAX(TotalMedicamentos)
	FROM(
		SELECT DISTINCT idreceta, SUM(unidades_recetadas) TotalMedicamentos
		FROM medicamento_receta
		GROUP BY idreceta
		ORDER BY TotalMedicamentos DESC
	) as unidades
) OR GananciasPesos.TotalPesos IN (
	SELECT MAX(TotalPesos)
	FROM(
		SELECT DISTINCT idreceta, SUM(cantidad_pesos) TotalPesos
		FROM farmacia_receta
		GROUP BY idreceta
		ORDER BY TotalPesos DESC
	) as pesos
) 
ORDER BY medicamentos, pesos;

--Compuesta:
--Presentación, componente y material
select presentacion ,componente, material  
from cpresentacion cp 
inner join ccomponente cc on cc.idpresentacion = cp.idpresentacion 
inner join cmaterial cm on cm.idmaterial = cc.idmaterial;


--Paginación:
--Devuelve el tipo de pago con el que se pagó cada receta
SELECT farmacia.idfarmacia, idfarm_receta, idpago 
FROM farmacia RIGHT JOIN farmacia_receta ON farmacia.idfarmacia=farmacia_receta.idfarmacia 
ORDER BY idfarmacia ASC;


--CROSSTAB:
--Precio de los medicamentos según sus gamas.
SELECT *
FROM CROSSTAB
(
 'SELECT  nombre, gama, precio FROM cgama JOIN medicamento_cgama ON cgama.idgama=medicamento_cgama.idgama RIGHT JOIN medicamento ON medicamento_cgama.idmedicamento = medicamento.idmedicamento
 WHERE precio IS NOT null
ORDER BY 1,2',
 'SELECT DISTINCT gama FROM cgama  ORDER BY 1
')
AS TA(NOMBRE VARCHAR, "GENERICO" BIGINT, "PATENTE" BIGINT, "SIMILAR" BIGINT);

--Función de ventana
--Nos devuelve la cantidad de material, material y componente por presentación 
select presentacion,componente,material, 
count(material) over (partition by presentacion) cantidad_material 
from (select presentacion ,componente, material  
from cpresentacion cp 
inner join ccomponente cc on cc.idpresentacion = cp.idpresentacion 
inner join cmaterial cm on cm.idmaterial = cc.idmaterial) t1 
order by (cantidad_material) desc;

--Agrupación
--Nos devuelve la cantidad de material y material por presentación
SELECT *
FROM
CROSSTAB
(
'select material,presentacion, count(componente) over (partition by presentacion) cantidad_material 
from (select presentacion, componente, material  
from cpresentacion cp 
inner join ccomponente cc on cc.idpresentacion = cp.idpresentacion 
inner join cmaterial cm on cm.idmaterial = cc.idmaterial) t1 
order by (cantidad_material) desc',
'SELECT presentacion FROM cpresentacion ORDER BY 1'
)
AS T(MATERIAL VARCHAR, "TABLETAS" VARCHAR, "GOTAS" VARCHAR, "CAPSULAS" VARCHAR, 
"TOPICO" VARCHAR, "EFERVESCENTE" VARCHAR, "AMPOLLETA ORAL" VARCHAR, "SOLUCION" VARCHAR);


