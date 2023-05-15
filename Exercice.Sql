-- 1 Exercice : Nom et année de naissance des artistes nés avant 1950.

SELECT *
FROM  artiste
WHERE annéeNaiss < 1950;


-- Exo 2 Titre de tous les drames.

SELECT  genre,titre 
FROM Film 
WHERE genre = 'Drame' ;

-- Exo 3 Quels rôles a joué Bruce Willis.

SELECT nomRôle,titre
FROM artiste NATURAL JOIN role NATURAL JOIN film
WHERE idArtiste = idActeur AND nom = 'Willis' AND prénom = 'Bruce';


-- Exo 4 Qui est le réalisateur de Memento.

SELECT * 
FROM Film 
WHERE titre = 'Memento' 
ORDER BY idRéalisateur = 525;

-- Exo 5 Quelles sont les notes obtenues par le film Fargo

SELECT note  
FROM film  NATURAL JOIN notation
WHERE titre = 'Fargo'; -- Sélectionne les notes associées au film Fargo

-- Exo 6 Qui a joué le rôle de Chewbacca?

SELECT nomRôle, titre, prénom, nom
FROM artiste NATURAL JOIN role NATURAL JOIN film
WHERE idArtiste = idActeur AND nomRôle = 'Chewbacca';

-- Exo 7 Dans quels films Bruce Willis a-t-il joué le rôle de John McClane?

SELECT nomRôle,titre, nom, prénom
FROM film NATURAL JOIN role NATURAL JOIN artiste
WHERE idArtiste = idActeur AND nom = 'Willis' AND prénom = 'Bruce' AND nomRôle = 'John McClane';

-- Exo 8 Nom des acteurs de 'Sueurs froides'

SELECT nom, prénom,titre, nomRôle 
FROM film NATURAL JOIN `artiste` NATURAL JOIN role
WHERE idArtiste = idActeur AND titre = 'Sueurs froides';

-- Exo 9 Quelles sont les films notés par l'internaute Prénom 0 Nom0.

SELECT titre, note, nom, prénom
FROM film NATURAL JOIN notation INNER JOIN internaute
WHERE prénom = 'Prénom0' AND nom = 'Nom0';

-- Version_2; - Exo 9;

SELECT titre, note, nom, prénom
FROM internaute, film, notation
WHERE prénom = 'Prénom0' AND nom = 'Nom0';


-- Exo 10 Films dont le réalisateur est Tim Burton, et l’un des acteurs Johnny Depp

SELECT titre
FROM   film f, role r, artiste a, artiste b
WHERE  f.idRéalisateur = a.idArtiste AND r.idActeur = b.idArtiste
AND  a.nom = 'Burton' AND a.prénom = 'Tim' AND b.nom = 'Depp' AND b.prénom = 'Johnny';

-- Reponse;
-- Titre "Sleepy Hollow, La Légende du cavalier sans tête"
************************************************************************************************

-- Exo 11 Titre des films dans lesquels a joué ́Woody Allen. Donner aussi le rôle.

-- Sélectionne le titre des films et le nom des rôles pour l'acteur Allen
SELECT film.titre, role.nomRôle, artiste.nom 
-- Spécifie les tables à utiliser pour la requête
FROM role , film, artiste 
-- Spécifie les critères de jointure entre les tables
WHERE film.idFilm = role.idFilm AND role.idActeur = artiste.idArtiste AND artiste.nom = 'Allen' AND artiste.prénom = 'Woody';
*******************************************************************************************************************************

-- Exo 12 Quel metteur en scène a tourné dans ses propres films ? Donner
-- le nom, le rôle et le titre des films.

SELECT nom, nomRôle, titre
FROM film f, artiste a, role r
WHERE f.idRéalisateur = a.idArtiste
AND r.idActeur = a.idArtiste
AND f.idFilm = r.idFilm

-- Exo 13 Titre des films de Quentin Tarantino dans lesquels il n’a pas joué

SELECT film.titre
FROM film, artiste, role
WHERE film.idRéalisateur = artiste.idArtiste 
AND film.idFilm = role.idFilm 
AND role.idActeur = artiste.idArtiste
AND artiste.nom ="Tarantino"
AND artiste.prénom = "Quentin";

-- Exo 14 Quel metteur en scène a tourné ́en tant qu’acteur ? 
-- Donner le nom, le rôle et le titre des films dans lesquels cet artiste a joué :

SELECT role.nomRôle, artiste.nom, artiste.prénom, film.titre
FROM film, artiste, role
WHERE film.idRéalisateur = role.idActeur 
AND role.idFilm = film.idFilm 
AND artiste.idArtiste = role.idActeur;

-- Exo 15 Donnez les films de Hitchcock sans James Stewart
************************************************************************* ,,,???

-- Exo 16 Dans quels films le réalisateur a-t-il le même prénom que l’un
-- des interprètes ? (titre, nom du réalisateur, nom de l’interprète). Le
-- réalisateur et l’interprète ne doivent pas être la même personne.

SELECT film.titre, realisateur.nom AS 'nom realisateur', interprete.nom AS nom_interprete
FROM film
JOIN artiste AS realisateur ON film.idRéalisateur = realisateur.idArtiste
JOIN role ON film.idFilm = role.idFilm
JOIN artiste AS interprete ON role.idActeur = interprete.idArtiste
WHERE realisateur.prénom = interprete.prénom AND realisateur.idArtiste != interprete.idArtiste;

********************************************************************************

--  17 Les films sans rôle
SELECT film.titre
FROM film
LEFT JOIN role ON film.idFilm = role.idFilm
WHERE role.idActeur IS NULL;

-- Exo 18 Quelles sont les films non notés par l'internaute Prénom1 Nom1

SELECT film.titre
FROM film
WHERE film.idFilm NOT IN (
    SELECT notation.idFilm
    FROM notation
    WHERE notation.email = 'Prénom1 Nom1'
);

-- LA Version_2

SELECT f.titre
FROM film f
LEFT JOIN notation n ON f.idFilm = n.idFilm AND n.email = 'Prénom1 Nom1'
WHERE n.idFilm IS NULL;
******************************************************************************************

-- Exo 19 Quels acteurs n’ont jamais réalisé de film ?

SELECT artiste.nom, artiste.prénom
FROM artiste
LEFT JOIN film ON artiste.idArtiste = film.idRéalisateur
WHERE film.idRéalisateur IS NULL

-- La Version_2

SELECT artiste.nom, artiste.prénom
FROM artiste
WHERE artiste.idArtiste NOT IN (
     SELECT film.idRéalisateur 
     FROM film
)

-- Exo 20 Quelle est la moyenne des notes de Memento

SELECT AVG(notation.note) AS 'Moyenne_Notes'

FROM film

JOIN notation ON film.idFilm = notation.idFilm

WHERE film.titre = 'Memento';

-- Exo 21 id, nom et prénom des réalisateurs, et nombre de films qu’ils ont tournés.

SELECT artiste.idArtiste, artiste.nom, artiste.prénom, COUNT(film.idFilm) as nombre_de_films
FROM artiste
JOIN film ON artiste.idArtiste = film.idRéalisateur
GROUP BY artiste.idArtiste, artiste.nom, artiste.prénom;

-- Exo 22; Nom et prénom des réalisateurs qui ont tourné au moins deux films.

SELECT artiste.nom, artiste.prénom
FROM film
JOIN artiste ON film.idRéalisateur = artiste.idArtiste
GROUP BY film.idRéalisateur
HAVING COUNT(film.idFilm) >= 2;

-- Exo 23 Quels films ont une moyenne des notes supérieure à 7

SELECT film.titre, AVG(notation.note) as moyenne
FROM film
JOIN notation ON film.idFilm = notation.idFilm
GROUP BY film.titre
HAVING AVG(notation.note) > 7;

-- on fini















