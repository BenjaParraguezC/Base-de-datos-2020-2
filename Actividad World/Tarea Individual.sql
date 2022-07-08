/* 1. Realice una consulta que entregue solo el nombre de los países y el de sus capitales*/

select 
	COU.NAME as Country_name,
    CIT.NAME  as Capital_name
from COUNTRY COU
inner join CITY CIT  on (CIT.id = COU.CAPITAL); 
/* ---------------------------------------------------------- */

/*2. ¿Cuál es la ciudad con menor población, cuyo país tiene una superficie mayor a 500.000 y menor a 1.000.000?*/
select
	CIT.NAME As City_Name,
    COU.SURFACEAREA as Surfacearea,
	CIT.POPULATION AS POBLACION
from CITY CIT
inner join Country COU  on (CIT.Countrycode = Cou.CODE)
WHERE COU.SURFACEAREA > 500000 AND COU.SURFACEAREA < 1000000
ORDER BY CIT.POPULATION ASC LIMIT 1;

/* ---------------------------------------------------- */

/*3. ¿Cuál es la ciudad con menor población del país con más población?*/

SELECT 
    COU.NAME AS PAIS,
    CIT.NAME AS CIUDAD,
    CIT.POPULATION AS POBLACION
FROM COUNTRY COU
INNER JOIN CITY CIT ON (CIT.COUNTRYCODE = COU.CODE)
WHERE COU.POPULATION = (SELECT 
                            max(POPULATION) 
                        FROM COUNTRY)
ORDER BY 3 ASC LIMIT 1;

/* ---------------------------------------------------- */

/*4. La cantidad de idiomas que habla cada país ordenados de mayor a menor.*/

SELECT
	distinct(COU.NAME) AS PAIS,
	count(LENG.LANGUAGE) AS IDIOMA
from COUNTRY COU
INNER JOIN countrylanguage LENG ON (LENG.Countrycode = COU.CODE)
group by (cou.code)
order by 2 desc;

/* ---------------------------------------------------- */
/* 5. ¿Cuál es la población Mundial? */

select 
sum(COU.POPULATION) as Poblacion_Mundial
from COUNTRY COU;

/* ---------------------------------------------------- */
/* 6. Seleccione el nombre de las ciudades junto con el nombre del país a la cual pertenecen. */

SELECT
	COU.NAME AS PAIS,
    CIT.NAME AS CIUDAD
FROM COUNTRY COU
INNER JOIN CITY CIT ON (CIT.COUNTRYCODE = COU.CODE);
    

/* ---------------------------------------------------- */
/* 7. Mostrar el nombre de los 15 países con más ciudades, y cuantas ciudades tiene (el número de ciudades) */

SELECT
	COU.NAME AS PAIS,
    count(CIT.NAME) AS CIUDAD
FROM COUNTRY COU
INNER JOIN CITY CIT ON (CIT.COUNTRYCODE = COU.CODE)
group by (COU.name)
order by 2 DESC limit 15;

/* ---------------------------------------------------- */
/*8. Seleccione El/Los idioma/s que se habla/n y el nombre del país al cual pertenece la ciudad de “Herat”. */

SELECT
	COU.NAME AS PAIS,
    CIT.NAME AS CIUDAD,
    LENG.LANGUAGE AS IDIOMA
FROM COUNTRY COU
INNER JOIN CITY CIT ON (CIT.COUNTRYCODE = COU.CODE)
INNER JOIN COUNTRYLANGUAGE LENG ON (LENG.Countrycode = COU.CODE)
WHERE cit.name = 'Herat';


/* ---------------------------------------------------- */
/*9. Los nombres de las ciudades junto con los nombres de los países, los cuales hablen el idioma “Spanish”*/

SELECT
	COU.NAME AS PAIS,
    CIT.NAME AS CIUDAD,
    LENG.LANGUAGE AS IDIOMA
FROM COUNTRY COU
INNER JOIN CITY CIT ON (CIT.COUNTRYCODE = COU.CODE)
INNER JOIN COUNTRYLANGUAGE LENG ON (LENG.Countrycode = COU.CODE)
where leng.Language = 'Spanish';


/* ---------------------------------------------------- */
/*10. Muestre el nombre de todos los países que hablen más de 2 idiomas y ordénelos alfabéticamente (A...Z).*/

SELECT
	COU.NAME AS PAIS,
    count(LENG.LANGUAGE) AS IDIOMA
FROM COUNTRY COU
INNER JOIN COUNTRYLANGUAGE LENG ON (LENG.Countrycode = COU.CODE)
group by (COU.name)
having count(leng.language) > 1
order by 1 ASC;

/* ---------------------------------------------------- */