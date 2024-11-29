USE `chinook`;

-- ESERCIZIO 1 Recuperate tutte le tracce che abbiano come genere “Pop” o “Rock”.

-- HO PRIMA VERIFICATO QUANTI E QUALI GENERI CI FOSSERO
SELECT DISTINCT
*
FROM
`genre`;

-- POI HO ESEGUITO L'ESERCIZIO ORDINANDO ENTRAMBE LE COLONNE PER ORDINE CRESCENTE
SELECT
	g.`Name` Genere
    , t.`Name` Traccia
FROM
	`track` t
INNER JOIN
	`genre` g
ON
	t.`GenreId` = g.`GenreId`
WHERE
	g.`Name` IN ('Pop', 'Rock')
ORDER BY 
	Genere ASC
    , Traccia ASC
;

-- ESERCIZIO 2 Elencate tutti gli artisti e/o gli album che inizino con la lettera “A”.

-- SOLO ARTISTI
SELECT
	`Name`
FROM
	`artist`
WHERE
	`Name` LIKE 'A%'
ORDER BY
	`Name`
;

-- SOLO ALBUM
SELECT
	`Title`
FROM
	`album`
WHERE
	`Title` LIKE 'A%'
ORDER BY
	`Title`
;

-- ENTRAMBI
SELECT
	`Name` Artista
    , `Title` Album
FROM
	`artist` ar
INNER JOIN
	`album` al
ON
	ar.`ArtistId` = al.`ArtistId`
WHERE 
	`Name` LIKE 'A%'
    AND 
    `Title` LIKE 'A%'
;


-- ESERCIZIO 3 Elencate tutte le tracce che hanno come genere “Jazz” o che durano meno di 3 minuti.

-- GENERE JAZZ
SELECT
	g.`Name` Genere
    , t.`Name` Traccia
FROM
	`track` t
INNER JOIN
	`genre` g
ON
	t.`GenreId` = g.`GenreId`
WHERE
	g.`Name` IN ('Jazz')
ORDER BY
	Traccia
;

-- DURATA MAX 3 MIN (3 MIN CORRISPONDONO A 180.000 MILLISECONDI)
SELECT
	`Name` Traccia
    , `Milliseconds` Durata
FROM
	`track`
WHERE
	`Milliseconds` < 180001
ORDER BY
	Traccia
;

-- ENTRAMBI
SELECT
	g.`Name` Genere
    , t.`Name` Traccia
    , `Milliseconds` Durata
FROM
	`track` t
INNER JOIN
	`genre` g
ON
	t.`GenreId` = g.`GenreId`
WHERE
	g.`Name` IN ('Jazz')
    AND
    `Milliseconds` < 180001
ORDER BY
	Traccia
;
	
-- ESERCIZIO 4 Recuperate tutte le tracce più lunghe della durata media.

SELECT
	`Name` Traccia
	, `Milliseconds` Durata
FROM
	`track`
WHERE
	`Milliseconds` > (SELECT 
		AVG(`Milliseconds`) 
        FROM 
			`track`)
ORDER BY 
	Traccia
;

-- ESERCIZIO 5 Individuate i generi che hanno tracce con una durata media maggiore di 4 minuti.
-- 4 MIN CORRISPONDONO A 240.000 MILLISECONDI)

SELECT DISTINCT
	g.`Name` Genere
FROM
	`track` t
INNER JOIN
	`genre` g
ON
	t.`GenreId` = g.`GenreId`
WHERE
    (SELECT 
	AVG(`Milliseconds`) 
	FROM 
		`track`)
	> 240000
ORDER BY
	Genere
;

-- TUTTI I GENERI HANNO TRACCE CON DURATA MEDIA DI 4 MIN
SELECT
	`Name` Genere
FROM
	`genre`
;

-- DIMOSTRAZIONE CON LE TRACCE E MINUTAGGI
SELECT DISTINCT
	g.`Name` Genere
    , t.`Name` Traccia
    , `Milliseconds` Minutaggio
FROM
	`track` t
INNER JOIN
	`genre` g
ON
	t.`GenreId` = g.`GenreId`
WHERE
    (SELECT 
	AVG(`Milliseconds`) 
	FROM 
		`track`)
	> 240000
ORDER BY
	Genere
--    , Traccia
    , Minutaggio
;

-- ESERCIZIO 6 Individuate gli artisti che hanno rilasciato più di un album. (RISULTATO 56 ARTISTI)

-- CON E SENZA CONTEGGIO DEGLI ALBUM
SELECT
	`Name` Nome
  --  , COUNT(`Title`)
FROM
	`artist` ar
INNER JOIN
	`album` al
ON
	ar.`ArtistId` = al.`ArtistId`
GROUP BY
	Nome
HAVING
	COUNT(`Title`) > 1
;

-- VERIFICA DI QUANTI ARTISTI CI SONO IN TOTALE PER CAPIRE SE HA FUNZIONATO LA QUERY (RISULTATO 275 ARTISTI)
SELECT 
	`Name`
FROM
	`artist`
;

-- ESERCIZIO 7 Trovate la traccia più lunga in ogni album. (INCOMPLETO)

SELECT
	`Title` Album
	, `Name` Traccia
    , MAX(`Milliseconds`) Tempo
FROM
	`track` t
INNER JOIN
	`album` a
ON
	t.`AlbumId` = a.`AlbumId`
WHERE
	`Milliseconds` = (
    SELECT MAX(`Milliseconds`)
    FROM `track` t
	WHERE `Title` = `Title`)
GROUP BY
	`Title`
;


-- ESERCIZIO 8 Individuate la durata media delle tracce per ogni album.

SELECT
	`Title` Album
    , AVG(`Milliseconds`)
FROM
	`track` t
INNER JOIN
	`album` a
ON
	t.`AlbumId` = a.`AlbumId`
GROUP BY
	Album
;

-- ESERCIZIO 9 Individuate gli album che hanno più di 20 tracce e mostrate il nome dell’album e il numero di tracce in esso contenute. (RISULTATO 22 ALBUM)

SELECT
	`Title` Album
    , COUNT(`Name`) N°_Tracce
FROM
	`track` t
INNER JOIN
	`album` a
ON
	t.`AlbumId` = a.`AlbumId`
GROUP BY
	Album
HAVING
	COUNT(`Name`) > 19
;

-- VERIFICA (347 ALBUM)
SELECT
	COUNT(`Title`)
FROM
	`album`
;



