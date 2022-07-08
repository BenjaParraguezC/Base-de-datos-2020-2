
/*1)  ¿Cuántas películas tiene la base de datos?*/

SELECT 
	count(Mov.name) as Peliculas
FROM movies Mov;

/* 2)  ¿Cuántas películas de comedia existen? */
SELECT
	count(GEN.genre) AS Cantidad_Comedia
from movies_genres GEN
WHERE Gen.GENRE = 'Comedy';

/*3)  ¿Cuántos actores existen en la base?*/

SELECT 
	count(ACT.id) as Cantidad_actores
from actors ACT;

/*4)  Dada la consulta anterior,
a. Seleccione los actores cuyos apellidos empiecen con la letra A. ¿Cuántos existen*/

SELECT 
	count(ACT.last_name) as Cantidad_actores
from actors ACT
where ACT.last_name like "A%";

/* 4b. Ahora seleccione los actores cuyos apellidos terminen con alguna vocal. ¿Cuántos existen?*/

SELECT 
	count(ACT.last_name) as Apellidos_Vocal
from actors ACT
where ACT.last_name like "%A" or ACT.last_name like "%E" or ACT.last_name like "%I" or ACT.last_name like "%O" or  ACT.last_name like "%U";

/* 5)  ¿Qué rol/roles ha interpretado Harrison Ford?*/
SELECT
	ACT.first_name as Nombre,
	ACT.last_name as Apellido,
    ROL.role as Rol
From actors ACT
inner join roles ROL on (ACT.id =  Rol.actor_id)
where act.last_name = 'Ford'
order by 1 DESC limit 1;


/*6)  ¿A qué película corresponde el rol de Han Solo?*/

SELECT
	Rol.role as Rol,
    Peli.name as Pelicula
From movies Peli
inner join roles rol on (movie_id = peli.id)
where rol.role = 'Han solo';

/*7)  Diga todas las películas que han sido dirigidas por un director de apellido Coppola, especificando a que director le pertenece.*/

SELECT
	DIR.last_name as Apellido,
    MOV.name as pelicula
from movies_directors MDR
inner join directors DIR on (DIR.id = MDR.director_id)
inner join Movies mov on (MOV.id = MDR.movie_id)
Where dir.last_name = 'Coppola';

    
/*8)  Diga el nombre de las primeras 10 películas en el ranking, con su respectivo ranking*/

SELECT
	MOV.name as Pelicula,
    MOV.rank as ranking 
from movies mov
order by 2 DESC LIMIT 10;


/*9)  Diga el nombre de la/s película/s donde su género sea crimen y su año sea 1972*/

SELECT 
	MOV.name as Pelicula,
    MOV.year as Anno,
    GEN.genre as Genero_pelicula
from movies MOV
inner join movies_genres GEN on  (MOV.id = GEN.movie_id)
where gen.genre = 'Crime' and mov.year = '1972';

/* 10) ¿Cuál es la probabilidad de que el director Quentin Tarantino haga una película de Misterio?*/

SELECT 
    DIR.first_name as Nombre,
    DIR.last_name as Apellido,
    DGER.genre as genero,
    DGER.prob as probabilidad
from directors dir
inner join directors_genres DGER on  (DIR.id = DGER.director_id)
Where dir.first_name = 'Quentin' and dir.last_name = 'Tarantino' and dger.genre = 'mystery';


/*11) Diga el promedio de año de las películas de guerra*/

Select
	avg(MOV.year) as Anno,
    GEN.genre as Genero
    
from movies mov
inner join movies_genres gen on (Mov.id = Gen.movie_id)
where gen.genre = 'war';


/* 12) Dado el total de películas, indique el número de películas que tiene cada género (ej: Horror: 3 películas) */

SELECT
	GEN.genre as Genero,
    count(gen.genre) as Cantidad
from movies_genres gen
group by (gen.genre);

/* 13) Indique la película en la que han actuado más actores o actrices*/

SELECT
	count(MGEN.actor_id) as Cantidad_Actores,
    MOV.name as Pelicula
from movies mov
inner join roles mgen on (MOV.ID = MGEN.movie_id)
group by (mov.name)
order by 1 DESC LIMIT 1;

/* Número total de actrices y actores en base a sus actuaciones en películas (OJO: Si un actor/actriz ha actuado en dos películas (o más) se debe contar también entonces dos veces (o más))*/

SELECT
	count(MGEN.actor_id) as Cantidad_Actores,
    MOV.name as Pelicula
from movies mov
inner join roles mgen on (MOV.ID = MGEN.movie_id)
group by (mov.name);

/* 15) Las películas de Thriller, ¿actúan más actores o actrices?*/

Select
	MGER.GENRE as genero,
    count(ACT.gender) as Actores
from roles rol
inner join movies_genres mger on (MGER.movie_id =ROL.movie_id)
inner join  actors ACT on (rol.actor_id = act.id)
where mger.genre = 'thriller' and act.gender = 'M'
group by mger.genre;

/*En este caso sacamos el total de actores de thriller que son 930, luego
de hacer el filtro nos damos cuenta que la cantidad de hombres es de 718, por
ende actuan mas actores que actrices*/

/* 16) ¿Qué películas hizo el director Christopher Nolan?*/

Select
	dir.first_name as nombre,
    DIR.lasT_name as Apellido,
    MDIR.director_id as DirectorID,
    MDIR.movie_id as MOVIEID,
    MOV.name as Movie_id
from movies_directors MDIR
inner join directors dir on (DIR.id = MDIR.director_id)
inner join movies mov on (mov.id = mdir.movie_id)
where dir.last_name = 'Nolan';

/*17) ¿Qué director es el que ha hecho más películas?*/

Select
	dir.first_name as nombre,
    DIR.lasT_name as Apellido,
    count(MOV.name) as Movie_id
from movies_directors MDIR
inner join directors dir on (DIR.id = MDIR.director_id)
inner join movies mov on (mov.id = mdir.movie_id)
group by (dir.first_name)
order by 3 desc limit 1;

/* 18) ¿Cuál es el director que ha trabajado con más actrices?*/
SELECT
	DIR.first_name as NombreDir,
    DIR.Last_name as ApellidoDir,
    count(ACT.gender) as Actrices
    
from movies_directors MDR
inner join directors dir on (dir.id = MDR.director_id)
inner join roles rol on (rol.movie_id = MDR.movie_id)
inner join actors act on (act.id = rol.actor_id)
where act.gender = 'F'
group by dir.first_name asc
order by 3 desc limit 1;



/*19) ¿Qué película tiene el rango (Rank) más alto de las de Acción?*/

Select
	MOV.name as pelicula,
	MOV.rank as ranking,
    MGER.genre as genero

from movies mov
inner join movies_genres MGER on (MGER.movie_id=MOV.id)    
where mger.genre = 'action'
order by 2 DESC limit 1;


/*20) ¿Cuales es o son los géneros de película preferidos para trabajar de las actrices?*/
Select
	MGER.GENRE as genero,
    count(ACT.gender) as Actrices

from roles rol
inner join movies_genres mger on (MGER.movie_id =ROL.movie_id)
inner join  actors ACT on (rol.actor_id = act.id)
where act.gender = 'F'
group by mger.genre  asc
order by 2 desc;
