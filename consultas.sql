--- ====
--- Orden de importación
-- habilidades
-- tipo_relacion
-- raza
-- trabajo
-- persona
-- lugares
-- languages
-- anecdotas
-- caracteristicas_rol
-- caracteristicas_fisicas
-- personajes
-- relacion
-- mn_habilidades_personaje
-- capitulos
-- mn_lugares_anecdota
-- mn_anecdotas_relacionadas
-- capitulos_cuerpo
-- mn_anecdota_capitulo
-- mn_personaje_anecdota
-- mn_personaje_capitulo
====


-- ID de los personajes que hayan estado en el lugar 'Taberna 7ºCielo'
SELECT DISTINCT pj.id, pj.nombre FROM personaje pj
JOIN mn_personaje_anectdota mnpa ON mnpa.id_personaje=pj.id
WHERE mnpa.id_anecdota IN (SELECT a.id FROM anecdotas a
JOIN mn_lugares_anecdota mnla ON mnla.id_anecdota = a.id
WHERE(SELECT id FROM lugares WHERE nombre = "Taberna 7ºCielo"))

-- ID, y Nombre de las personas con personajes que tuvieran la habilidad 'Bola de Fuego'
-- Los capitulos que tengan personajes que estén relacionados como pareja
-- ¿Que habilidades tienen los personajes casados?
-- ¿Que trabajos podemos encontrar en las anecdotas de 'La catedral del Dolor'?
-- Razas que sean jugado en alguna partida
-- Listado de diferentes Habilidades de los guerreros
-- Capitulos con más de una anecdota relacionada <= SubSelect ¿????? (¿Se puede hacer? | Having)
select * from capitulos
WHERE id IN ( select mn.id_capitulo from mn_anecdota_capitulo mn
group BY mn.id_capitulo
HAVING COUNT(mn.id_anecdota) > 1 );
select c.id, c.titulo from mn_anecdota_capitulo mn
JOIN capitulos c ON c.id = mn.id_capitulo
group BY mn.id_capitulo
HAVING COUNT(mn.id_anecdota) > 1;


-- Todas las relaciones de los personajes del capitulo 1
-- Habilidades de los elfos
-- ¿Cual es la media de altura de los enanos?
-- ¿Cual es la media de los personajes de una persona?
-- ¿Cual es la raza habitual de 'Pablo Rodriguez'?
-- ¿Cuantos lugares no están en las anecdotas? (NOT IN)


SELECT count(id) FROM anecdotas
WHERE id NOT IN ( SELECT DISTINCT id_lugar FROM mn_lugares_anecdota WHERE id_lugar );


SELECT ( (SELECT count(id) FROM anecdotas) --  (SELECT count(DISTINCT id_lugar) FROM mn_lugares_anecdota WHERE id_lugar) ) as count;

-- -> Devuelve TODOS los personajes, los trabajos que tengan y rellena con null lo que no tengan trabajo
select p.id, p.nombre, t.nombre as curro from personaje p left join trabajo t on t.id = p.id_trabajo;
-- -> Devuevle TODOS los trabajos, y el primer personaje que tenga ese trabajo. Pero no los personajes que no tengan trabajo
select p.id, p.nombre, t.nombre as curro from personaje p right join trabajo t on t.id = p.id_trabajo;
-- -> Devuelve SOLO los personajes que tengan algun trabajo
select p.id, p.nombre, t.nombre as curro from personaje p inner join trabajo t on t.id = p.id_trabajo;

-- Titulos de las anedoctas del capitulo 10
-- Personajes que estén en capitulos traducidos al inglés
-- ¿Que raza de personaje es más alto de media?
SELECT r.id, r.nombre, avg(cf.altura) as media FROM personaje p LEFT JOIN raza r on r.id = p.id_raza LEFT JOIN carasteristicas_fisicas cf ON cf.id = p.id_fisicas group by r.id order by media limit 1;

-- Habilidades que no estuvieran en ninguna anecdota
SELECT DISTINCT h.id FROM habilidades h
JOIN mn_habilidad_personaje mnhp ON mnhp.id_habilidad = h.id
JOIN personaje p ON p.id = mnhp.id_personaje
JOIN mn_personaje_anectdota mnpa ON mnpa.id_personaje = p.id;

-- Listado los personajes en cada capitulo
-- ¿Cuanto tiempo ha pasado entre la anecdota más antigua y la más nueva?
select ((select max(cuando) from anecdotas) -- (select min(cuando) from anecdotas) );

-- ¿Cual es la media de fuerza de los Elfos?
-- ¿Que personaje tiene la carisma más alta y quien lo interpreta?
SELECT p.*, pj.nombre as personaje
FROM persona p
JOIN personaje pj ON (pj.id_persona = p.id)
WHERE pj.id = (
	SELECT pj.id
	FROM juego_de_rol.caracteristicas_rol cr
	JOIN juego_de_rol.personaje pj ON (pj.id_rol = cr.id)
	ORDER BY cr.carisma DESC
	LIMIT 1
)

-- ¿En cuantas anecdotas estuvo 'Den, El Negro'?
SELECT count(p.id) as count FROM personaje p  JOIN mn_personaje_anectdota mn ON mn.id_personaje = p.id WHERE p.nombre = "Den, El Negro";
-- ¿Cuantos personajes hubo en cada anecdota?
-- ¿Que raza tiene la constitución más alta?
-- ¿Cual es el apodo del personaje que más aparece en cada capitulo?
-- Listado de Personajes de cada capitulo <= ¿Se puede hacer?
-- Lugares más repetidos en los capitulos
select l.* from mn_lugares_anecdota mn
JOIN lugares l ON l.id = mn.id_lugar
where mn.id_lugar
group by mn.id_lugar
having count(mn.id_anecdota) > 1
ORDER by count(mn.id_anecdota) DESC;

-- Altura y Destreza del personaje más viejo
SELECT r.destreza, f.altura , MAX(p.edad) as edad FROM caracteristicas_rol r JOIN personaje p ON p.id_rol = r.id JOIN carasteristicas_fisicas f ON p.id_fisicas = f.id
SELECT r.destreza, f.altura , p.edad
FROM caracteristicas_rol r
JOIN personaje p ON p.id_rol = r.id
JOIN carasteristicas_fisicas f ON p.id_fisicas = f.id
ORDER by p.edad DESC
LIMIT 1;

-- ¿Que trabajo suelen tener los elfos?



-- EXTRA:
-- -> Devuelve TODOS los personajes, los trabajos que tengan y rellena con null lo que no tengan trabajo
select p.id, p.nombre, t.nombre as curro from personaje p left join trabajo t on t.id = p.id_trabajo;
-- -> Devuevle TODOS los trabajos, y el primer personaje que tenga ese trabajo. Pero no los personajes que no tengan trabajo
select p.id, p.nombre, t.nombre as curro from personaje p right join trabajo t on t.id = p.id_trabajo;
-- -> Devuelve SOLO los personajes que tengan algun trabajo
select p.id, p.nombre, t.nombre as curro from personaje p inner join trabajo t on t.id = p.id_trabajo;



-- CREAR VISTAS
CREATE VIEW lugaresRepetidos
AS
select l.* from mn_lugares_anecdota mn
JOIN lugares l ON l.id = mn.id_lugar
where mn.id_lugar
group by mn.id_lugar
having count(mn.id_anecdota) > 1
ORDER by count(mn.id_anecdota) DESC;

-- CONSULTAR VISTAS
SELECT * FROM lugaresRepetidos;

-- CREATE A TRIGGER FROM INSERT IN PERSONAJE CHANGE EDAD if under 18 to 18
-- https://www.siteground.es/kb/uso-triggers-mysql/
-- https://www.neoguias.com/como-crear-y-utilizar-triggers-en-mysql/
CREATE TRIGGER personaje_mayor_de_edad
AFTER INSERT ON personaje
FOR EACH ROW
BEGIN
    IF NEW.edad < 18 THEN
        SET NEW.edad = 18;
    END IF;
END;

